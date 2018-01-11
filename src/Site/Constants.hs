{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}
module Site.Constants where

import Hakyll (Pattern, FeedConfiguration (..), fromGlob)


dateFormat = "%B %e, %Y"

postsDir :: String -> Pattern
postsDir = fromGlob . (++ "posts/*")

bookDir :: String -> Pattern
bookDir = fromGlob . (++ "httw/*")

postFormat :: String
postFormat = "/[0-9]{4}-[0-9]{2}-[0-9]{2}-"

