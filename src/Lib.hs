module Lib
    ( containsKeywordInArg
    ) where

import qualified Data.Text as Text

containsKeywordInArg :: [Text.Text] -> [Text.Text] -> Bool
containsKeywordInArg = any . flip elem
