module Lexer ( Lexer.lex, Token, Lexeme ) where

import Prelude
import Data.Text
import Data.Text.Internal

data Token = ID deriving (Eq, Enum, Show)
data Lexeme = Lexeme Token Text deriving (Eq)

instance Show Lexeme where
    show (Lexeme tok text) = "(" ++ show tok ++ ", " ++ show text ++ ")"

lex :: IO Data.Text.Internal.Text -> IO Lexeme

lex x = do
    y <- x
    return (Lexeme ID y)
