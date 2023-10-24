module Lib
    ( containsKeywordInArg
    ) where

import Data.List (isInfixOf)

containsKeywordInArg :: String -> [String] -> [Bool]
containsKeywordInArg arg keywords = map (contains arg) keywords

contains :: String -> String -> Bool
contains arg keyword = keyword `isInfixOf` arg
