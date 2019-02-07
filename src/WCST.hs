{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE ScopedTypeVariables       #-}
{-# LANGUAGE TypeApplications          #-}
{-# LANGUAGE ViewPatterns              #-}
{-# LANGUAGE DuplicateRecordFields     #-}
{-# LANGUAGE OverloadedStrings         #-}

module Main where

import           ClipIt
import           Control.Arrow ((&&&))
import           Control.Monad (join)
import           Data.List (sortBy)
import qualified Data.Map as M
import           Data.Maybe (catMaybes)
import           Data.Maybe (isJust)
import           Data.Monoid ((<>))
import           Data.Ord (comparing)
import           Data.Text (Text)
import           Data.Text.Lens (_Text)
import           Data.Time.Format (formatTime, defaultTimeLocale)
import           Data.Time.Parse (strptime)
import           Data.Traversable (for)
import           GHC.Exts (fromList)
import           SitePipe hiding (getTags)
import           Utils


postFormat :: String
postFormat = "/[0-9]{4}-[0-9]{2}-[0-9]{2}-"


toSlug :: String -> String
toSlug = replaceAll ("/posts" <> postFormat) (const "")
       . replaceAll "\\.html"  (const "")


assembleMeta :: Value -> Value
assembleMeta o =
  let date       = o ^?! _Object . at "date"
      confidence = o ^?! _Object . at "confidence"
   in o & _Object . at "meta" ?~ Array (fromList $ catMaybes
          [ date
          , confidence >>= fmap (String . ("Confidence: " <>))
                         . getConfidence
                         . round
                         . (^?! _Number)
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


main :: IO ()
main = site $ do
  let l = _Object . at "url" . _Just . _String . _Text

  about <- resourceLoader markdownReader ["about.markdown"]
  now   <- resourceLoader markdownReader ["now.markdown"]

  rawPosts <- sortBy (comparing (^?! l))
          <$> resourceLoader markdownReader ["posts/*.markdown"]

  clipfiles <- fmap (^?! _Object . at "content" . _Just . _String . _Text)
           <$> resourceLoader textReader ["clippings/*"]
  let clippings = join $ fmap getClippings clipfiles

  let urls = fmap (^?! l) rawPosts
      getEm' = getNextAndPrev urls
      posts' =
        flip fmap rawPosts $
          \x ->
            let url  = x ^?! l
                (fmap toSlug -> prev, fmap toSlug -> next) = getEm' url
                tagsOf = x ^? _Object . at "tags" . _Just . _String . _Text
                related = x ^? _Object . at "related" . _Just
                date = fst . (^?! _Just) . strptime "%Y-%m-%d %H:%M"
                     $ x ^?! _Object . at "date" . _Just . _String . _Text
                slug = toSlug url

             in x & l                         .~ "blog/" <> slug <> "/index.html"
                  & _Object . at "page_title" .~ x ^?! _Object . at "title"
                  & _Object . at "canonical_url" ?~ _String . _Text # ("blog/" <> slug)
                  & _Object . at "slug"       ?~ _String . _Text # slug
                  & _Object . at "has_prev"   ?~ _Bool # isJust prev
                  & _Object . at "has_next"   ?~ _Bool # isJust next
                  & _Object . at "has_related" ?~ _Bool # isJust related
                  & _Object . at "related"    ?~ (maybe (Array $ fromList []) id related :: Value)
                  & _Object . at "html_tags"  .~
                      fmap (\y -> _String . _Text # makeTags y) tagsOf
                  & _Object . at "prev"       .~
                      fmap (review $ _String . _Text) prev
                  & _Object . at "next"       .~
                      fmap (review $ _String . _Text) next
                  & _Object . at "zulu"       ?~ _String . _Text #
                      formatTime defaultTimeLocale "%Y-%m-%dT%H:%M:%SZ" date
                  & _Object . at "date"       ?~ _String . _Text #
                      formatTime defaultTimeLocale "%B %e, %Y" date

      slugList = M.fromList
               $ fmap ((^?! _Object . at "slug" . _Just . _String) &&& id) posts

      posts = flip fmap posts' $ \post ->
        post & _Object . at "related" . _Just . _Array
                %~ fmap (\x -> maybe (error $ "bad related slug: " <> x ^?! _String . _Text) id
                             $ M.lookup (x ^?! _String) slugList)

  let tags   = getTags makeTagUrl $ reverse posts
      newest = last posts

      feed :: String -> Value
      feed url = object
        [ "posts"        .= take 10 (reverse posts)
        , "domain"       .= ("http://sandymaguire.me" :: String)
        , "url"          .= url
        , "last_updated" .= (newest ^?! _Object . at "zulu" . _Just . _String)
        ]

  writeTemplate' "post.html" . pure
    $ head about
      & _Object . at "url"        ?~ _String # "/about/index.html"
      & _Object . at "slug"       ?~ _String # "about"

  writeTemplate' "post.html" . pure
    $ head now
      & _Object . at "url"        ?~ _String # "/now/index.html"
      & _Object . at "slug"       ?~ _String # "now"

--   writeTemplate' "post.html" . pure
--     $ newest
--       & _Object . at "url"        ?~ _String # "/index.html"
--       & _Object . at "page_title" ?~ _String # "Home"

  let byYear = reverse
              . flip groupOnKey (reverse posts)
              $ \x -> reverse
                    . take 4
                    . reverse
                    $ x ^?! _Object . at "date" . _Just . _String . _Text

  let archive = object
        [ "url" .= ("/blog/archives/index.html" :: String)
        , "page_title" .= ("Archives" :: String)
        , "years" .= (flip fmap byYear $ \(year, ps) ->
            object
              [ "posts" .= ps
              , "year"  .= year
              ]
          )
        , "slug" .= ("archive" :: String)
        ]

  writeTemplate' "archive.html" $ pure archive

  writeTemplate' "archive.html" . pure
    $ archive
      & _Object . at "url"        ?~ _String # "/index.html"
      & _Object . at "page_title" ?~ _String # "We Can Solve This"

  writeTemplate' "post.html" posts
  writeTemplate' "tag.html"  tags

  writeTemplate' "rss.xml"  . pure $ feed "feed.rss"
  writeTemplate' "atom.xml" . pure $ feed "atom.xml"

  copyFiles
    [ "css"
    , "js"
    , "images"
    ]

  books <- for (fmap snd $ groupOnKey bookName clippings) $
    \(sortBy (comparing added) -> items) -> do
      let curBook = head items
          slug = canonicalName curBook
          book = object
            [ "page_title" .= bookName curBook
            , "title"     .= bookName curBook
            , "author"    .= author curBook
            , "started"   .= added curBook
            , "finished"  .= added (last items)
            , "url" .= ("books/" <> slug <> ".html")
            , "clippings" .= (flip fmap items $ \item ->
                object [ "body" .= contents item ]
               )
            , "slug" .= slug
            ]
      writeTemplate' "book.html" $ pure book
      pure book

  writeTemplate' "book-index.html" . pure
    $ object
      [ "page_title" .= ("Index of Book Quotes" :: String)
      , "url" .= ("books/index.html" :: String)
      , "books" .= sortBy (comparing $ titleCompare . (^?! _Object . at "title" . _Just . _String . _Text)) books
      , "slug" .= ("archive-books" :: String)
      ]

  copyFilesWith (drop 7) [ "static/*" ]


writeTemplate' :: String -> [Value] -> SiteM ()
writeTemplate' a = writeTemplate ("templates/" <> a) . fmap assembleMeta

