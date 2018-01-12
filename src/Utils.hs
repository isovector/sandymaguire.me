module Utils where

import           Data.Maybe (listToMaybe)
import           Text.Regex.TDFA ((=~~))


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
