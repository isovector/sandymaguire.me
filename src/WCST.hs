{-# LANGUAGE DuplicateRecordFields     #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE OverloadedLists           #-}
{-# LANGUAGE OverloadedStrings         #-}
{-# LANGUAGE ScopedTypeVariables       #-}
{-# LANGUAGE TypeApplications          #-}
{-# LANGUAGE ViewPatterns              #-}

module Main where

import           BookReviews (mkBookReview)
import           ClipIt
import           Control.Arrow ((&&&))
import           Control.Monad (join)
import           Control.Monad.Reader.Class (asks)
import qualified Data.HashMap.Lazy as HM
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
import           SitePipe hiding (getTags, reviews)
import qualified System.FilePath.Glob as G
import           Utils


postFormat :: String
postFormat = "/[0-9]{4}-[0-9]{2}-[0-9]{2}-"


toSlug :: String -> String
toSlug = replaceAll ("/posts" <> postFormat) (const "")
       . replaceAll "\\.html"  (const "")


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


makeRelated :: M.Map Text Value -> Value -> Value
makeRelated slugList post =
  post & _Object . at "related" . _Just . _Array %~ fmap (\x ->
    maybe (error $ "bad related slug: " <> x ^?! _String . _Text) id
      $ M.lookup (x ^?! _String) slugList
                                                         )


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

l :: (AsValue t, Applicative f) => (String -> f String) -> t -> f t
l = _Object . at "url" . _Just . _String . _Text

main :: IO ()
main = site $ do
  about    <- resourceLoader markdownReader ["about.markdown"]
  now      <- resourceLoader markdownReader ["now.markdown"]
  topPosts <- resourceLoader markdownReader ["top-posts.markdown"]

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

      posts = fmap (makeRelated slugList) posts'

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

  writeTemplate' "now.html" . pure
    $ head now
      & _Object . at "url"        ?~ _String # "/now/index.html"
      & _Object . at "slug"       ?~ _String # "now"

  writeTemplate' "top-posts.html" . pure . makeRelated slugList
    $ head topPosts
      & _Object . at "url"        ?~ _String # "/top-posts/index.html"
      & _Object . at "slug"       ?~ _String # "top-posts"

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
          slug = canonicalName (author curBook) (bookName curBook)
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

  rawReviews <- loadFiles (mkBookReview . read) ["books/*.book"]
  reviews <- for rawReviews $ \(slug, Object rev) -> do
    let obj = Object $ rev <>
                [ "slug" .= ("book-review-" <> slug)
                , "url"  .= ("book-reviews/" <> slug <> "/index.html")
                , "page_title" .= ("Review of " <> (rev HM.! "title") ^. _String)
                ]
    writeTemplate' "book-review.html" $ pure obj
    pure obj

  writeTemplate' "book-index.html" . pure
    $ object
      [ "page_title" .= ("Index of Book Reviews" :: String)
      , "url" .= ("book-reviews/index.html" :: String)
      , "books" .= sortBy (comparing $ titleCompare . (^?! _Object . at "title" . _Just . _String . _Text)) reviews
      , "slug" .= ("archive-book-reviews" :: String)
      ]




  copyFilesWith (drop 7) [ "static/*" ]


writeTemplate' :: String -> [Value] -> SiteM ()
writeTemplate' a = writeTemplate ("templates/" <> a) . fmap assembleMeta


loadFiles :: (String -> a) -> [GlobPattern] -> SiteM [a]
loadFiles fileReader patterns = do
  filenames <- concat <$> traverse srcGlob patterns
  traverse (fmap fileReader . liftIO . readFile) filenames


srcGlob :: GlobPattern -> SiteM [FilePath]
srcGlob pattern = do
  srcD <- asks srcDir
  liftIO $ G.glob (srcD </> pattern)

