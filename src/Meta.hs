{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications  #-}

module Meta where

import           Data.Char (toLower)
import qualified Data.HashMap.Lazy as HM
import           Data.List (stripPrefix)
import           Data.Maybe (catMaybes, fromMaybe)
import           Data.Monoid ((<>))
import           Data.Text (Text)
import           Data.Text.Lens (_Text)
import           Data.Time
import           Data.Time.Format (formatTime, defaultTimeLocale)
import           GHC.Exts (fromList)
import           GHC.Generics (Generic)
import           SitePipe hiding (getTags, reviews)
import           Utils


data PostMeta = PostMeta
  { postMetaUrl        :: String
  , postMetaTitle      :: String
  , postMetaRawDate    :: LocalTime
  , postMetaComments   :: Bool
  , postMetaRawTags    :: String
  , postMetaConfidence :: Maybe Int
  , postMetaRelated    :: Maybe [String]
  } deriving (Generic, Show)

instance FromJSON PostMeta where
  parseJSON =
    genericParseJSON defaultOptions
      { fieldLabelModifier = (fromMaybe <*> stripPrefix "raw") . fmap toLower . drop 8
      }

postMetaTags :: PostMeta -> [String]
postMetaTags = splitTags . postMetaRawTags

postMetaSlug :: PostMeta -> String
postMetaSlug = toSlug . postMetaUrl

postMetaZulu :: PostMeta -> String
postMetaZulu = formatTime defaultTimeLocale "%Y-%m-%dT%H:%M:%SZ" . postMetaRawDate

postMetaDate :: PostMeta -> String
postMetaDate = formatTime defaultTimeLocale "%B %e, %Y" . postMetaRawDate


assembleMeta :: Value -> Value
assembleMeta o =
  let date       = o ^?! _Object . at "date"
      bookAuthor = o ^?! _Object . at "author"
      confidence = o ^?! _Object . at "confidence"
      stars      = o ^?! _Object . at "stars"
   in o & _Object . at "meta" ?~ Array (fromList $ catMaybes
          [ date
          , bookAuthor
          , confidence >>= fmap (String . ("Confidence: " <>))
                         . getConfidence
                         . round
                         . (^?! _Number)
          , stars >>= fmap ( review (_String . _Text)
                           . ("Rating: " <>)
                           . (<> "/5")
                           . show @Int
                           . round)
                    . (^? _Number)
          ])

getConfidence :: Int -> Maybe Text
getConfidence 1 = Just "certain"
getConfidence 2 = Just "highly likely"
getConfidence 3 = Just "likely"
getConfidence 4 = Just "possible"
getConfidence 5 = Just "unlikely"
getConfidence 6 = Just "highly unlikely"
getConfidence 7 = Just "remote"
getConfidence 8 = Just "impossible"
getConfidence _ = Nothing


toSlug :: String -> String
toSlug = replaceAll ("/posts" <> postFormat) (const "")
       . replaceAll "\\.html"  (const "")

postFormat :: String
postFormat = "/[0-9]{4}-[0-9]{2}-[0-9]{2}-"


dumpPostMeta :: Value -> PostMeta -> Value
dumpPostMeta v pm = object $
  mconcat
    [ v ^. _Object . SitePipe.to HM.toList
    , [ "url"           .= ("blog/" <> postMetaSlug pm <> "/index.html")
      , "canonical_url" .= ("blog/" <> postMetaSlug pm)
      , "slug"          .= postMetaSlug pm
      , "zulu"          .= postMetaZulu pm
      , "date"          .= postMetaDate pm
      , "related"       .= postMetaRelated pm
      , "title"         .= postMetaTitle pm
      , "page_title"    .= postMetaTitle pm
      , "html_tags"     .= (fmap makeTags $ postMetaTags pm)
      ]
    , mkHas "related" $ postMetaRelated pm
    ]


mkHas :: (ToJSON (f a), Foldable f) => Text -> f a -> [(Text, Value)]
mkHas nm f =
  case length f of
    0 -> [ ("has_" <> nm) .= False
         ]
    _ -> [ nm .= f
         , ("has_" <> nm) .= True
         ]
