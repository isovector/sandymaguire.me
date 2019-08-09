{-# LANGUAGE DeriveGeneric             #-}
{-# LANGUAGE DuplicateRecordFields     #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE OverloadedLists           #-}
{-# LANGUAGE OverloadedStrings         #-}
{-# LANGUAGE ScopedTypeVariables       #-}
{-# LANGUAGE TupleSections             #-}
{-# LANGUAGE TypeApplications          #-}
{-# LANGUAGE ViewPatterns              #-}

module Main where

import           BookReviews (mkBookReview)
import           ClipIt
import           Control.Arrow (first)
import           Control.Monad (join, void)
import qualified Data.HashMap.Lazy as HM
import           Data.List (sortBy)
import qualified Data.Map as M
import           Data.Maybe (isJust)
import           Data.Monoid ((<>))
import           Data.Ord (comparing, Down (..))
import           Data.Text (Text)
import qualified Data.Text as T
import           Data.Text.Lens (_Text)
import           Data.Traversable (for)
import           Meta
import           SitePipe hiding (getTags, reviews)
import           SitePipeUtils
import           Text.Pandoc.Class
import           Utils


makeRelated :: M.Map Text Value -> Value -> Value
makeRelated slugList post =
  post & _Object . at "related" . _Just . _Array %~ fmap (\x ->
    maybe (error $ "bad related slug: " <> x ^?! _String . _Text) id
      $ M.lookup (x ^?! _String) slugList
                                                         )

l :: (AsValue t, Applicative f) => (String -> f String) -> t -> f t
l = _Object . at "url" . _Just . _String . _Text


main :: IO ()
main = site $ do
  rawPosts <- sortBy (comparing (^?! l))
          <$> resourceLoader markdownReader ["posts/*.markdown"]

  let urls = fmap (^?! l) rawPosts
      getEm' = getNextAndPrev urls
      posts'' = flip fmap rawPosts $ \x ->
                  let Success pm = fromJSON @PostMeta x
                   in (pm, x)
      slugList = M.fromList $ fmap (first $ T.pack . postMetaSlug) posts'
      posts = fmap (makeRelated slugList . snd) posts'

      posts' =
        flip fmap posts'' $
          \(pm, x) ->
            let url  = x ^?! l
                (fmap toSlug -> prev, fmap toSlug -> next) = getEm' url

             in (pm, ) $ dumpPostMeta x pm
                  & _Object . at "has_prev"   ?~ _Bool # isJust prev
                  & _Object . at "has_next"   ?~ _Bool # isJust next
                  & _Object . at "prev"       .~
                      fmap (review $ _String . _Text) prev
                  & _Object . at "next"       .~
                      fmap (review $ _String . _Text) next


  topPosts <- resourceLoader markdownReader ["top-posts.markdown"]
  writeTemplate' "top-posts.html" . pure . makeRelated slugList
    $ head topPosts
      & _Object . at "url"        ?~ _String # "/top-posts/index.html"
      & _Object . at "slug"       ?~ _String # "top-posts"

  let tags   = getTags makeTagUrl $ reverse posts
      newest = last posts

      feed :: String -> Value
      feed url = object
        [ "posts"        .= take 10 (reverse posts)
        , "domain"       .= ("http://sandymaguire.me" :: String)
        , "url"          .= url
        , "last_updated" .= (newest ^?! _Object . at "zulu" . _Just . _String)
        ]

  let byYear :: [(String, [Value])]
      byYear = reverse
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

  erdos <- sortBy (comparing $ Down
                             . fmap (read @Int . takeWhile (/= '-')
                                               . drop (length $ id @String "/erdos/"))
                             . (^? l))
       <$> resourceLoader markdownReader ["erdos/*.markdown"]

  writeTemplate' "erdos.html" . pure
    $ object
      [ "url" .= ("/erdos/index.html" :: String)
      , "page_title" .= ("Erdos Project" :: String)
      , "posts" .= erdos
      , "slug" .= ("erdos" :: String)
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

  writeStaticStuff
  writeBooks


writeStaticStuff :: SiteM ()
writeStaticStuff = do
  about    <- resourceLoader markdownReader ["about.markdown"]
  writeTemplate' "post.html" . pure
    $ head about
      & _Object . at "url"        ?~ _String # "/about/index.html"
      & _Object . at "slug"       ?~ _String # "about"

  now      <- resourceLoader markdownReader ["now.markdown"]
  writeTemplate' "now.html" . pure
    $ head now
      & _Object . at "url"        ?~ _String # "/now/index.html"
      & _Object . at "slug"       ?~ _String # "now"

  void $ copyFiles
    [ "css"
    , "js"
    , "images"
    ]
  void $ copyFilesWith (drop 7) [ "static/*" ]


writeBooks :: SiteM ()
writeBooks = do
  clipfiles <- fmap (^?! _Object . at "content" . _Just . _String . _Text)
           <$> resourceLoader (runIOorExplode . textReader) ["clippings/*"]
  let clippings = join $ fmap getClippings clipfiles

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

