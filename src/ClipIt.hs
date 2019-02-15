{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric  #-}

module ClipIt
    ( Clipping (..)
    , getClippings
    , parseClippings
    , getBooks
    ) where

import Control.Applicative ((<$>), (<|>))
import Control.Arrow ((***))
import Control.Monad (liftM2, join, void)
import Data.Aeson
import Data.DateTime
import Data.List (nub)
import Data.Time.Clock
import Data.Time.LocalTime (localTimeToUTC, utc)
import Data.Time.Parse (strptime)
import GHC.Generics (Generic)
import Text.ParserCombinators.Parsec hiding ((<|>))
import Text.Regex

data Clipping =
    Clipping
    { bookName :: String
    , subtitle :: Maybe String
    , author   :: String
    , added    :: DateTime
    , contents :: String
    } deriving (Show, Eq, Generic, ToJSON, FromJSON)


typeof :: GenParser Char st String
typeof = do
  optional $ string "Your "
  choice $ map string ["Highlight", "Note", "Bookmark"]


getClippings :: String -> [Clipping]
getClippings = filter (("" /=) . author)
             . either (error . show) id
             . parseClippings


onPage :: GenParser Char st ()
onPage = do
    void $ choice [ string "Page"
                  , string "page"
                  ]
    spaces
    void $ many digit
    optional $ do
      spaces
      void $ string "|"
      spaces

parseSubtitle :: String -> (String, Maybe String)
parseSubtitle l =
    case matchRegex regex l of
        Just xs -> (xs !! 0, Nothing)
        Nothing -> (l, Nothing)
  where
      regex = mkRegex "^([^:(]*)"


clipping :: GenParser Char st Clipping
clipping =
    do
        optional $ char '\65279'
        meta <- line
        let regex = mkRegex "^(.*?) \\(([^)]*)\\)$|^(.*?) \\- (.*)$"
            matches = matchRegex regex meta
            ((book, cSub), authorName) =
                case matches of
                    Just xs -> case xs !! 0 of
                        ""    -> (parseSubtitle $ xs !! 2, xs !! 3)
                        name  -> (parseSubtitle name, xs !! 1)
                    Nothing -> (("", Nothing), "")

        eol
        void $ string "- "
        void typeof
        spaces
        optional $ do
          void $ string "on"
          spaces
        optional onPage
        _ <- loc
        void $ string "|"
        void $ string " Added on "
        Just time <- timeParser <$> line
        void $ many eol
        cContents <- line
        eol
        void . many $ char '='
        eol
        return Clipping
            { bookName = book
            , subtitle = cSub
            , author = authorName
            , added = time
            , contents = cContents
            }

timeParser :: String -> Maybe UTCTime
timeParser s = parseTime s <|> parseTime2 s

parseTime :: String -> Maybe UTCTime
parseTime = fmap (localTimeToUTC utc . fst) . strptime "%A, %B %e, %Y, %I:%M %p"

parseTime2 :: String -> Maybe UTCTime
parseTime2 = fmap (localTimeToUTC utc . fst) . strptime "%A, %B %e, %Y %I:%M:%S %p"

loc :: GenParser Char st (Int, Int)
loc = do
  void $ string "Loc"
  void $ choice [ string "."
                , string "ation"
                ]
  spaces
  start <- many digit
  endMaybe <- optionMaybe $ do
    void $ char '-'
    many digit
  spaces
  return . join (***) read $ case endMaybe of
      Just end ->
          let prefix = take (length start - length end) start
           in (start, prefix ++ end)
      Nothing  -> (start, start)


-- The end of line character is \n
eol :: GenParser Char st ()
eol = void $ oneOf "\n"

line :: GenParser Char st String
line = many $ noneOf "\n"

parseFile :: GenParser Char st [Clipping]
parseFile = do
    optional $ string "\xBB\xEF"
    many clipping


parseClippings :: String -> Either ParseError [Clipping]
parseClippings input = parse parseFile "parsing a file" input

getBooks :: Either ParseError [Clipping] -> [(String, String)]
getBooks (Left s) = error $ show s
getBooks (Right bs) = nub $ map (liftM2 (,) bookName author) bs


_oldStyle :: String
_oldStyle = unlines
  [ "Atlas Shrugged: (Centennial Edition) (Ayn Rand)"
  , "- Highlight on Page 1121 | Loc. 17178-79  | Added on Wednesday, November 04, 2015, 07:47 AM"
  , ""
  , "She heard the words; she understood the meaning; she was unable to make it real—to grant the respect of anger, concern, opposition to a nightmare piece of insanity that rested on nothing but people's willingness to pretend to believe that it was sane."
  , "=========="
  ]

_newStyle :: String
_newStyle = unlines
  [ "The Age of Em: Work, Love and Life when Robots Rule the Earth (Hanson, Robin)"
  , "- Your Highlight on Location 2837-2839 | Added on Sunday, June 19, 2016 3:43:11 PM"
  , ""
  , "give stronger incentives for overall performance, compared with rewarding the best performers (Drouvelis and Jamison 2015; Kubanek et al. 2015)."
  , "=========="
  ]
