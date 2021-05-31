module Podman.Gio where

import Prelude
import Data.Argonaut.Decode (decodeJson, printJsonDecodeError)
import Data.Argonaut.Parser (jsonParser)
import Data.Either (Either(..))
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import GJS (log)
import Gio.Subprocess (cmd)
import Podman.Container (Container)

list :: Aff (Array Container)
list = do
  jsonStr <- cmd [ "podman", "ps", "--format", "json" ]
  case jsonParser jsonStr of
    Right jsonObj -> case decodeJson jsonObj of
      Right res -> pure res
      Left err -> fail (printJsonDecodeError err)
    Left err -> fail (err)
  where
  fail e = do
    liftEffect $ log $ "Could not read podman ps: " <> e
    pure []
