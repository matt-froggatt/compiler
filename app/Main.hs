module Main where

import Prelude hiding(lex, getContents, putStr)
import Data.Text.IO
import Lexer
import Parser

main = (lex getContents) >>= print
