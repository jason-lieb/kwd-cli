module Lib
    ( containsKeywordInArg
    ) where

import Data.Text (Text)

containsKeywordInArg :: [Text] -> [Text] -> Bool
containsKeywordInArg = any . flip elem
