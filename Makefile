.PHONY: demo
demo:
	spago bundle-app -m Test.Demo --to build/test.js --then "gjs build/test.js"
