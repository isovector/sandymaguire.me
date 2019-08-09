module SitePipeUtils where

import           Control.Monad.Reader.Class (asks)
import           Data.Monoid ((<>))
import           Meta
import           SitePipe hiding (getTags, reviews)
import qualified System.FilePath.Glob as G


writeTemplate' :: String -> [Value] -> SiteM ()
writeTemplate' a = writeTemplate ("templates/" <> a) . fmap assembleMeta


loadFiles :: (String -> a) -> [GlobPattern] -> SiteM [a]
loadFiles fileReader patterns = do
  filenames <- concat <$> traverse srcGlob patterns
  traverse (fmap fileReader . liftIO . readFile) filenames


srcGlob :: GlobPattern -> SiteM [FilePath]
srcGlob pattern = do
  srcD <- asks srcDir
  liftIO $ G.glob (srcD </> pattern)

