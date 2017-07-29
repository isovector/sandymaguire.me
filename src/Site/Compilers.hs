{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Site.Compilers where

import           Control.Monad
import           Data.ByteString (ByteString)
import qualified Data.ByteString as B
import           Data.IORef
import           Data.Map (Map)
import qualified Data.Map as M
import           Data.Set (insert)
import           Data.String.Conv
import           Hakyll
import           System.Directory
import           System.FilePath
import           System.IO
import qualified Text.Pandoc as P
import           Text.Pandoc.Options


contentCompiler :: String -> Identifier -> Context String -> Compiler (Item String)
contentCompiler prefix t c =
    makeItem ""
    >>= loadAndApplyTemplate t c
    >>= loadAndApplyTemplate (fromFilePath $ prefix ++ "templates/default.html") c
    >>= relativizeUrls

pandocMathCompiler :: Compiler (Item String)
pandocMathCompiler = do
    let mathExtensions =
            [ Ext_tex_math_dollars
            , Ext_tex_math_double_backslash
            , Ext_latex_macros
            ]
        defaultExtensions = writerExtensions defaultHakyllWriterOptions
        newExtensions = foldr insert defaultExtensions mathExtensions
        writerOptions = defaultHakyllWriterOptions
            { writerExtensions = newExtensions
            , writerHTMLMathMethod = MathJax ""
            }
    ref <- unsafeCompiler $ newIORef M.empty
    pandocCompilerWith defaultHakyllReaderOptions writerOptions

