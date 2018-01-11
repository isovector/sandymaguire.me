{-# LANGUAGE NoMonomorphismRestriction #-}
{-# language DuplicateRecordFields     #-}
{-# language OverloadedStrings         #-}

module Main where

import           Data.Foldable (for_)
import           Data.List (sortBy)
import           Data.Maybe (listToMaybe, isJust)
import           Data.Monoid ((<>))
import           Data.Ord (comparing)
import qualified Data.Text as T
import           Data.Text.Lens (_Text)
import           SitePipe
import qualified Text.Mustache as MT
import qualified Text.Mustache.Types as MT
import           Text.Regex.TDFA ((=~~))


-- import Data.Aeson.Lens

postFormat :: String
postFormat = "/[0-9]{4}-[0-9]{2}-[0-9]{2}-"

getNext :: Eq a => [a] -> a -> Maybe a
getNext as = flip lookup . zip as $ tail as

main :: IO ()
main = siteWithGlobals templateFuncs $ do
  let l = _Object . at "url" . _Just . _String . _Text

  rawPosts <- sortBy (comparing (^?! l))
          <$> resourceLoader markdownReader ["posts/*.markdown"]
  let urls = fmap (^?! l) rawPosts
      posts =
        flip fmap rawPosts $
          \x ->
            let url  = x ^?! l
                next = getNext urls url
                prev = getNext (reverse urls) url
                slug = replaceAll ("/posts" <> postFormat) (const "")
                     . replaceAll "\\.html"  (const "")
                     $ url
             in x & l                   .~ "blog/" <> slug
                  & _Object . at "slug" ?~ _String . _Text # slug
                  & _Object . at "next" .~ fmap (review $ _String . _Text) next
                  & _Object . at "has_next" ?~ _Bool # isJust next
                  & _Object . at "prev" .~ fmap (review $ _String . _Text) prev
                  & _Object . at "has_prev" ?~ _Bool # isJust prev


  -- getTags will return a list of all tags from the posts,
  -- each tag has a 'tag' and a 'posts' property
  let tags = getTags makeTagUrl posts
      -- Create an object with the needed context for a table of contents
      indexContext :: Value
      indexContext = object [ "posts" .= posts
                            , "tags" .= tags
                            , "url" .= ("/index.html" :: String)
                            ]
      rssContext :: Value
      rssContext = object [ "posts" .= posts
                          , "domain" .= ("http://chrispenner.ca" :: String)
                          , "url" .= ("/rss.xml" :: String)
                          ]

  -- Render index page, posts and tags respectively
  writeTemplate "templates/index.html" [indexContext]
  writeTemplate "templates/post.html" posts
  writeTemplate "templates/tag.html" tags
  -- writeTemplate "templates/rss.xml" [rssContext]
  staticAssets


--------------------------------------------------------------------------------
-- | A simple (but inefficient) regex replace funcion
replaceAll :: String              -- ^ Pattern
           -> (String -> String)  -- ^ Replacement (called on capture)
           -> String              -- ^ Source string
           -> String              -- ^ Result
replaceAll pattern f source = replaceAll' source
  where
    replaceAll' src = case listToMaybe (src =~~ pattern) of
        Nothing     -> src
        Just (o, l) ->
            let (before, tmp) = splitAt o src
                (capture, after) = splitAt l tmp
            in before ++ f capture ++ replaceAll' after


-- We can provide a list of functions to be availabe in our mustache templates
templateFuncs :: MT.Value
templateFuncs = MT.object
  [ "tagUrl" MT.~> MT.overText (T.pack . makeTagUrl . T.unpack)
  ]

makeTagUrl :: String -> String
makeTagUrl tagName = "/tags/" ++ tagName ++ ".html"

-- | All the static assets can just be copied over from our site's source
staticAssets :: SiteM ()
staticAssets = copyFiles
    -- We can copy a glob
    [ "css/"
    -- Or just copy the whole folder!
    , "js/"
    , "images/"
    ]
