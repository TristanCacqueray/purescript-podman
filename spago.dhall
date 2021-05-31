{-
Welcome to a Spago project!
You can edit this file as you like.

Need help? See the following resources:
- Spago documentation: https://github.com/purescript/spago
- Dhall language tour: https://docs.dhall-lang.org/tutorials/Language-Tour.html

When creating a new Spago project, you can use
`spago init --no-comments` or `spago init -C`
to generate this file without the comments in this block.
-}
{ name = "my-project"
, dependencies =
  [ "aff"
  , "argonaut-codecs"
  , "argonaut-core"
  , "effect"
  , "either"
  , "foldable-traversable"
  , "gjs"
  , "maybe"
  , "node-buffer"
  , "node-fs"
  , "nonempty"
  , "prelude"
  , "psci-support"
  , "test-unit"
  ]
, packages =
    ./packages.dhall
  with gjs = ../../purescript-gjs/purescript-gjs/spago.dhall as Location
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
