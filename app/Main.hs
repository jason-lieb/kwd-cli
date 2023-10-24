module Main (main) where

import Lib
import System.Environment

keywords :: [String]
keywords = ["blue", "green", "yellow", "orange", "red", "purple"]

main :: IO ()
main = do
  args <- getArgs
  arg <- checkNumOfArgs args
  let keywordsInArg = containsKeywordInArg arg keywords
  let anyKeywordInArg = elem True keywordsInArg
  returnOutput anyKeywordInArg

checkNumOfArgs :: [String] -> IO String
checkNumOfArgs args
    | length args > 1 = error "Too many arguments provided. Only one argument is allowed."
    | null args = error "Not enough arguments provided. One argument is required."
    | otherwise = return (head args)

returnOutput :: Bool -> IO ()
returnOutput True = putStrLn "At least one keyword found!"
returnOutput False = putStrLn "No keywords found :("