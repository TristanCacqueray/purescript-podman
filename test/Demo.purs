module Test.Demo where

import Prelude

import Data.Foldable (traverse_)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import GJS (print)
import GLib.MainLoop as GLib.MainLoop
import Gio.Async as Async
import Podman.Gio as Podman.Gio

main :: Effect Unit
main = do
  Async.init
  loop <- GLib.MainLoop.new
  launchAff_ do
    containers <- Podman.Gio.list
    liftEffect do
      traverse_ (print <<< show) containers
      GLib.MainLoop.quit loop
  GLib.MainLoop.run loop
