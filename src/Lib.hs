module Lib
    ( containsKeywordInArg
    ) where

import Data.List (isInfixOf)

containsKeywordInArg :: String -> [String] -> Bool
containsKeywordInArg arg keywords = any (\keyword -> keyword `isInfixOf` arg) keywords
