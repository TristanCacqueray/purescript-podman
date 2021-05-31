module Test.Main where

import Prelude
import Data.Argonaut.Decode (decodeJson)
import Data.Argonaut.Parser (jsonParser)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.NonEmpty (NonEmpty(..))
import Effect (Effect)
import Effect.Class (liftEffect)
import Node.Encoding (Encoding(..))
import Node.FS.Sync (readTextFile)
import Podman.Container (Container(..))
import Test.Unit (suite, test)
import Test.Unit.Assert as Assert
import Test.Unit.Main (runTest)

isContainer :: Container -> Maybe String
isContainer (Container c)
  | c.command == NonEmpty "sleep" [ "42" ] = Nothing
  | otherwise = Just "bad decode"

checkContainer :: String -> Maybe String
checkContainer containerText = case jsonParser containerText of
  Right containerJson -> case decodeJson containerJson of
    Right containerObj -> isContainer containerObj
    Left err -> Just (show err)
  Left err -> Just err

main :: Effect Unit
main = do
  runTest do
    suite "Decode" do
      test "Container" do
        containerText <- liftEffect $ readTextFile UTF8 "./test/data/container.json"
        Assert.equal Nothing (checkContainer containerText)
