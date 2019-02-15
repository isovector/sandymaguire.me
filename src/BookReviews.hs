{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TupleSections     #-}
{-# LANGUAGE TypeApplications  #-}

module BookReviews where

import Utils
import Data.Text (Text, unpack)
import SitePipe hiding (getTags, review)

-- change this in the goodreads generator if you change it here
-- https://github.com/isovector/goodreads
data Book = Book
  { title :: Text
  , author :: Maybe Text
  , rating :: Maybe Text
  , review :: Maybe Text
  } deriving (Show, Read)

mkBookReview :: Book -> (String, Value)
mkBookReview Book{..} = (canonicalName (unpack author') $ unpack title,) $ object
  [ "title"  .= title
  , "author" .= author'
  , "stars"      .= fmap (read @Int . unpack) rating
  , "review" .= maybe "" id review
  ]
    where
      author' = maybe "" id author

