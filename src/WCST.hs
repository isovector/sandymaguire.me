{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE ScopedTypeVariables       #-}
{-# language DuplicateRecordFields     #-}
{-# language OverloadedStrings         #-}

module Main where

import Data.List (sortBy)
import Data.Maybe (isJust)
import Data.Monoid ((<>))
import Data.Ord (comparing)
import Data.Text.Lens (_Text)
import Data.Time.Format (formatTime, defaultTimeLocale)
import Data.Time.Parse (strptime)
import SitePipe hiding (getTags)
import Utils


postFormat :: String
postFormat = "/[0-9]{4}-[0-9]{2}-[0-9]{2}-"


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
                tagsOf = x ^? _Object . at "tags" . _Just . _String . _Text
                slug = replaceAll ("/posts" <> postFormat) (const "")
                     . replaceAll "\\.html"  (const "")
                     $ url
             in x & l .~ "blog/" <> slug
                  & _Object . at "html_tags" .~ fmap (\y -> _String . _Text # makeTags y) tagsOf
                  & _Object . at "page_title" .~ x ^?! _Object . at "title"
                  & _Object . at "canonical_url" ?~ _String . _Text # url
                  & _Object . at "slug" ?~ _String . _Text # slug
                  & _Object . at "prev" .~ fmap (review $ _String . _Text) prev
                  & _Object . at "next" .~ fmap (review $ _String . _Text) next
                  & _Object . at "has_prev" ?~ _Bool # isJust prev
                  & _Object . at "has_next" ?~ _Bool # isJust next
                  & _Object . at "date" . _Just . _String . _Text %~
                      formatTime defaultTimeLocale "%B %e, %Y" . fst . (^?! _Just) . strptime "%Y-%m-%d %H:%M"


  let tags = getTags makeTagUrl posts
      -- Create an object with the needed context for a table of contents
      indexContext :: Value
      indexContext =
        last posts
          & _Object . at "url"        ?~ _String # "/index.html"
          & _Object . at "page_title" ?~ _String # "Home"

      rssContext :: Value
      rssContext = object [ "posts" .= take 10 posts
                          , "domain" .= ("http://sandymaguire.me" :: String)
                          , "url" .= ("/rss.xml" :: String)
                          ]

  -- Render index page, posts and tags respectively
  writeTemplate "templates/post.html" [indexContext]
  writeTemplate "templates/post.html" posts
    -- posts & _List . values . _Object . at "tags" . _Just . _String . _Text %~ makeTags
  writeTemplate "templates/tag.html" tags
  writeTemplate "templates/rss.xml" [rssContext]
  staticAssets




staticAssets :: SiteM ()
staticAssets = copyFiles
    [ "css/"
    , "js/"
    , "images/"
    ]
