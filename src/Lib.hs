module Lib
    ( countKeywords
    , countKeyword
    , countNonKeywords
    , splitOnWhitespaceAndPunctuation
    , formatArg
    , removeUnusedKeywords
    , sortKeywordCount
    ) where

import qualified Data.Text as T
import Data.Text (Text)
import Data.List (sortBy)
import Data.Ord (comparing)

countKeywords :: [Text] -> [Text] -> [(Text, Int)]
countKeywords arg keywords = map (countKeyword arg) keywords

countKeyword :: [Text] -> Text -> (Text, Int)
countKeyword arg keyword = (keyword, count)
    where
    count = length $ filter (== keyword) arg

countNonKeywords :: [Text] -> [Text] -> Int
countNonKeywords arg keywords = length $ filter (flip notElem keywords) arg

formatArg :: String -> [Text]
formatArg = splitOnWhitespaceAndPunctuation . T.toLower . T.pack

splitOnWhitespaceAndPunctuation :: Text -> [Text]
splitOnWhitespaceAndPunctuation = T.split $ flip elem (" .,;!?" :: String)

removeUnusedKeywords :: [(Text, Int)] -> [(Text, Int)]
removeUnusedKeywords = filter ((/= 0) . snd)

sortKeywordCount :: [(Text, Int)] -> [(Text, Int)]
sortKeywordCount = sortBy (flip $ comparing snd)
