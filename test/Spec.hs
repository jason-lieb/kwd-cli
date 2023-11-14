{-# LANGUAGE OverloadedStrings #-}

import Test.Hspec
import Lib

main :: IO ()
main = hspec $ do
  describe "test name 1" $ do
    it "description" $ do
      function "input" `shouldBe` True
