{-# LANGUAGE OverloadedStrings #-}

import Test.Hspec
import Lib
    ( countKeywords
    , countKeyword
    , countNonKeywords
    , splitOnWhitespaceAndPunctuation
    , formatArg
    , removeUnusedKeywords
    , sortKeywordCount
    )

main :: IO ()
main = hspec $ do
  describe "Counting Functions" $ do
    it "countKeywords 1" $ do
      countKeywords ["this", "is", "the", "blue", "input"] ["blue", "green"] `shouldBe` [("blue", 1), ("green", 0)]
    it "countKeywords 2" $ do
      countKeywords ["blue", "is", "green", "blue", "input"] ["blue", "green"] `shouldBe` [("blue", 2), ("green", 1)]
    it "countKeyword 1" $ do
      countKeyword ["this", "is", "the", "blue", "input"] "blue" `shouldBe` ("blue", 1)
    it "countKeyword 2" $ do
      countKeyword ["blue", "is", "green", "blue", "input"] "green" `shouldBe` ("green", 1)
    it "countNonKeywords 1" $ do
      countNonKeywords ["this", "is", "the", "blue", "input"] ["blue", "green"] `shouldBe` 4
    it "countNonKeywords 2" $ do
      countNonKeywords ["blue", "is", "green", "blue", "input"] ["blue", "green"] `shouldBe` 2

  describe "Formatting Functions" $ do
    it "formatArg 1" $ do
      formatArg ("This is the BLUE inpuT" :: String) `shouldBe` ["this", "is", "the", "blue", "input"]
    it "formatArg 2" $ do
      formatArg ("teSt;BluE.grEen red!teSt" :: String) `shouldBe` ["test", "blue", "green", "red", "test"]
    it "splitOnWhitespaceAndPunctuation 1" $ do
      splitOnWhitespaceAndPunctuation "this is the blue input" `shouldBe` ["this", "is", "the", "blue", "input"]
    it "splitOnWhitespaceAndPunctuation 2" $ do
      splitOnWhitespaceAndPunctuation "test;blue.green red!test" `shouldBe` ["test", "blue", "green", "red", "test"]
    it "removeUnusedKeywords 1" $ do
      removeUnusedKeywords [("blue", 1), ("green", 0)] `shouldBe` [("blue", 1)]
    it "removeUnusedKeywords 2" $ do
      removeUnusedKeywords [("blue", 2), ("green", 1)] `shouldBe` [("blue", 2), ("green", 1)]
    it "sortKeywordCount 1" $ do
      sortKeywordCount [("blue", 1), ("green", 2)] `shouldBe` [("green", 2), ("blue", 1)]
    it "sortKeywordCount 2" $ do
      sortKeywordCount [("blue", 1), ("red", 5), ("green", 2), ("yellow", 3)] `shouldBe` [("red", 5), ("yellow", 3), ("green", 2), ("blue", 1)]
