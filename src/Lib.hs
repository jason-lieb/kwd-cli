module Lib
    ( countKeywords
    , countNonKeywords
    ) where

import Data.Text (Text)

countKeywords :: [Text] -> [Text] -> [(Text, Int)]
countKeywords arg keywords = map (countKeyword arg) keywords

countKeyword :: [Text] -> Text -> (Text, Int)
countKeyword arg keyword = (keyword, count)
    where
    count = length $ filter (== keyword) arg

countNonKeywords :: [Text] -> [Text] -> Int
countNonKeywords arg keywords = length $ filter (flip notElem keywords) arg
