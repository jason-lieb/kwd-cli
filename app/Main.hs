{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import System.Environment
import Lib
    ( countKeywords
    , countNonKeywords
    , formatArg
    , removeUnusedKeywords
    , sortKeywordCount
    )
import qualified Data.Text as T
import Data.Text (Text)

keywords :: [Text]
keywords = ["blue", "green", "yellow", "orange", "red", "purple"]

main :: IO ()
main = do
  args <- getArgs
  stringArg <- checkNumOfArgs args
  let formattedArg = formatArg stringArg
      keywordCount = sortKeywordCount . removeUnusedKeywords $ countKeywords formattedArg keywords
      nonKeywordCount = countNonKeywords formattedArg keywords
  returnOutput keywordCount nonKeywordCount

checkNumOfArgs :: [String] -> IO String
checkNumOfArgs args
  | length args > 1 = error "Too many arguments provided. Only one argument is allowed."
  | null args = error "Not enough arguments provided. One argument is required."
  | otherwise = return $ head args

returnOutput :: [(Text, Int)] -> Int -> IO ()
returnOutput keywordCount nonKeywordCount = do
  putStrLn "Found keywords:"
  mapM_ outputKeyword keywordCount
  putStrLn ""
  putStrLn $ "Non-keyword count: " ++ show nonKeywordCount

outputKeyword :: (Text, Int) -> IO ()
outputKeyword (keyword, count) = putStrLn $ T.unpack keyword ++ ": " ++ show count
