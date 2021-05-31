module Podman.Container (Container(..)) where

import Prelude
import Data.Argonaut.Decode (class DecodeJson, decodeJson, (.:))
import Data.NonEmpty (NonEmpty(..), head)

data Container
  = Container
    { command :: NonEmpty Array String
    , id :: String
    , names :: NonEmpty Array String
    , mounts :: Array String
    }

instance decodeContainer :: DecodeJson Container where
  decodeJson json = do
    obj <- decodeJson json
    command <- obj .: "Command"
    id <- obj .: "Id"
    names <- obj .: "Names"
    mounts <- obj .: "Mounts"
    pure $ Container { command, id, names, mounts }

instance showContainer :: Show Container where
  show (Container container) = "Container {" <> container.id <> ": " <> head container.names <> " [" <> show container.command <> "]}"
