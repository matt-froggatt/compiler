module Main where

import Prelude 
import Lexer
import Parser

main = do
    x <- getContents
    print (parse (alexScanTokens x))
