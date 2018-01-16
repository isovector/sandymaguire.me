{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE ScopedTypeVariables       #-}
{-# language DuplicateRecordFields     #-}
{-# language OverloadedStrings         #-}

module Main where

import           Data.List (sortBy)
import           Data.Maybe (isJust)
import           Data.Monoid ((<>))
import           Data.Ord (comparing)
import           Data.Text.Lens (_Text)
import           Data.Time.Format (formatTime, defaultTimeLocale)
import           Data.Time.Parse (strptime)
import           SitePipe hiding (getTags)
import           Utils


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
                date = fst . (^?! _Just) . strptime "%Y-%m-%d %H:%M"
                     $ x ^?! _Object . at "date" . _Just . _String . _Text
                slug = replaceAll ("/posts" <> postFormat) (const "")
                     . replaceAll "\\.html"  (const "")
                     $ url

             in x & l                         .~ "blog/" <> slug
                  & _Object . at "page_title" .~ x ^?! _Object . at "title"
                  & _Object . at "canonical_url" ?~ _String . _Text # url
                  & _Object . at "slug"       ?~ _String . _Text # slug
                  & _Object . at "has_prev"   ?~ _Bool # isJust prev
                  & _Object . at "has_next"   ?~ _Bool # isJust next
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

  let tags   = getTags makeTagUrl posts
      newest = last posts

      feed :: String -> Value
      feed url = object
        [ "posts"        .= take 10 (reverse posts)
        , "domain"       .= ("http://sandymaguire.me" :: String)
        , "url"          .= ("/" <> url)
        , "last_updated" .= (newest ^?! _Object . at "zulu" . _Just . _String)
        ]

  writeTemplate' "post.html" . pure
    $ newest
      & _Object . at "url"        ?~ _String # "/index.html"
      & _Object . at "page_title" ?~ _String # "Home"

  let byYear = reverse
              . flip groupOnKey (reverse posts)
              $ \x -> reverse . take 4
                              . reverse
                              $ x ^?! _Object . at "date" . _Just . _String . _Text

  writeTemplate' "archive.html" . pure
    $ object
      [ "url" .= ("/blog/archives/index.html" :: String)
      , "page_title" .= ("Archives" :: String)
      , "years" .= (
        flip fmap byYear $ \(year, ps) ->
          object
            [ "posts" .= ps
            , "year"  .= year
            ]
       )
      ]

  writeTemplate' "post.html" posts
  writeTemplate' "tag.html" tags

  writeTemplate' "rss.xml" . pure $ feed "feed.rss"
  writeTemplate' "atom.xml" . pure $ feed "atom.xml"

  copyFiles
    [ "css"
    , "js"
    , "images"
    ]

writeTemplate' :: ToJSON a => String -> [a] -> SiteM ()
writeTemplate' a = writeTemplate ("templates/" <> a)

