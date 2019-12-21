build:
	stack build

run:
	stack exec compiler-exe

test:
	stack test

.PHONY: build run test
