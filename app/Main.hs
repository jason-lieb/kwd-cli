{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import System.Environment
import Lib (containsKeywordInArg)
import qualified Data.Text as T
import Data.Text (Text)

keywords :: [Text]
keywords = ["blue", "green", "yellow", "orange", "red", "purple"]

main :: IO ()
main = do
  args <- getArgs
  stringArg <- checkNumOfArgs args
  let formattedArg = formatArg stringArg
  let anyKeywordsInArg = containsKeywordInArg formattedArg keywords
  returnOutput anyKeywordsInArg

checkNumOfArgs :: [String] -> IO String
checkNumOfArgs args
  | length args > 1 = error "Too many arguments provided. Only one argument is allowed."
  | null args = error "Not enough arguments provided. One argument is required."
  | otherwise = return $ head args

splitOnWhitespaceAndPunctuation :: Text -> [Text]
splitOnWhitespaceAndPunctuation = T.split $ flip elem (" .,;!?" :: String)

formatArg :: String -> [Text]
formatArg = splitOnWhitespaceAndPunctuation . T.toLower . T.pack

returnOutput :: Bool -> IO ()
returnOutput True = putStrLn "At least one keyword found!"
returnOutput False = putStrLn "No keywords found :("
