{
module Lexer (Token (..), alexScanTokens ) where
}

%wrapper "basic"

$digit = 0-9			-- digits
$alpha = [a-zA-Z]		-- alphabetic characters

tokens :-

  $white+				;
  "//".*				;
  "asm"					{ \s -> Asm }
  "false"				{ \s -> TokFalse }
  "true"				{ \s -> TokTrue }
  "val"					{ \s -> Val }
  "var"					{ \s -> Var }
  "("					{ \s -> LParen }
  ")"					{ \s -> RParen }
  "{"					{ \s -> LBracket }
  "}"					{ \s -> RBracket }
  "="					{ \s -> Eq }
  ":"					{ \s -> Colon }
  ","					{ \s -> Comma }
  $digit+				{ \s -> Int (read s) }
  $alpha [$alpha $digit \_ \']*		{ \s -> ID s }

{
-- Each action has type :: String -> Token

-- The token type:
data Token =
    Asm 	|
    Return  	|
    TokTrue	|
    TokFalse	|
    Val		|
    Var		|
    LParen	|
    RParen	|
    LBracket	|
    RBracket	|
    Eq		|
    Colon	|
    Comma	|
    ID String	|
    Int Int
    deriving (Eq,Show)

}
