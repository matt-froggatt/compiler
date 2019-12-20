module Lexer ( Lexer.lex, Token ) where

import Prelude
import Data.Text
import Data.Text.Internal

data Type = ID deriving (Eq, Enum, Show) -- TODO need to add new tokens
data Token = Token Type Text deriving (Eq)

-- Formatted print for 
instance Show Token where
    show (Token tok text) = "(" ++ show tok ++ ", " ++ show text ++ ")"

lex x = x >>= (\y -> return (Token ID y))
