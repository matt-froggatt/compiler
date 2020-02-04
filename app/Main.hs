module Main where

import Prelude 
import Lexer
import Parser
import Interpreter

main = do
    x <- getContents
    interpret(parse (alexScanTokens x))
