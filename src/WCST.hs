{-# LANGUAGE NoMonomorphismRestriction #-}
{-# language DuplicateRecordFields     #-}
{-# language OverloadedStrings         #-}

module Main where

import           Data.List (sortBy)
import           Data.Maybe (isJust, fromJust)
import           Data.Monoid ((<>))
import           Data.Ord (comparing)
import           Data.Text.Lens (_Text)
import           SitePipe
import           Utils


postFormat :: String
postFormat = "/[0-9]{4}-[0-9]{2}-[0-9]{2}-"


getNextAndPrev :: Eq a => [a] -> a -> (Maybe a, Maybe a)
getNextAndPrev as a =
  let mas = fmap Just as
   in fromJust . lookup a
               $ zipWith3 (\b c d -> (b, (c, d)))
                          as
                          (Nothing : mas)
                          (tail mas ++ [Nothing])


main :: IO ()
main = site $ do
  let l = _Object . at "url" . _Just . _String . _Text

  rawPosts <- sortBy (comparing (^?! l))
          <$> resourceLoader markdownReader ["posts/*.markdown"]
  let urls = fmap (^?! l) rawPosts
      getEm' = getNextAndPrev urls
      posts =
        flip fmap rawPosts $
          \x ->
            let url  = x ^?! l
                (prev, next) = getEm' url
                slug = replaceAll ("/posts" <> postFormat) (const "")
                     . replaceAll "\\.html"  (const "")
                     $ url
             in x & l                   .~ "blog/" <> slug
                  & _Object . at "slug" ?~ _String . _Text # slug
                  & _Object . at "prev" .~ fmap (review $ _String . _Text) prev
                  & _Object . at "next" .~ fmap (review $ _String . _Text) next
                  & _Object . at "has_prev" ?~ _Bool # isJust prev
                  & _Object . at "has_next" ?~ _Bool # isJust next


  let tags = getTags makeTagUrl posts
      -- Create an object with the needed context for a table of contents
      indexContext :: Value
      indexContext =
        last posts
          & _Object . at "url"   ?~ _String # "/index.html"
          & _Object . at "title" ?~ _String # "Home"

--       rssContext :: Value
--       rssContext = object [ "posts" .= take 10 posts
--                           , "domain" .= ("http://sandymaguire.me" :: String)
--                           , "url" .= ("/rss.xml" :: String)
--                           ]

  -- Render index page, posts and tags respectively
  writeTemplate "templates/index.html" [indexContext]
  writeTemplate "templates/post.html" posts
  writeTemplate "templates/tag.html" tags
  -- writeTemplate "templates/rss.xml" [rssContext]
  staticAssets


makeTagUrl :: String -> String
makeTagUrl tagName = "/tags/" ++ tagName ++ ".html"


staticAssets :: SiteM ()
staticAssets = copyFiles
    [ "css/"
    , "js/"
    , "images/"
    ]
