module Lib
    ( containsKeywordInArg
    ) where

import Data.List (isInfixOf)

containsKeywordInArg :: String -> [String] -> [Bool]
containsKeywordInArg arg keywords = map (\keyword -> keyword `isInfixOf` arg) keywords
