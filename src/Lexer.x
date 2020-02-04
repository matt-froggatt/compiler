{
module Lexer (Token (..), alexScanTokens ) where
}

%wrapper "basic"

$digit = 0-9			-- digits
$alpha = [a-zA-Z]		-- alphabetic characters

tokens :-

  $white+				;
  "//".*				;
  "false"				{ \s -> TokFalse }
  "true"				{ \s -> TokTrue }
  "val"					{ \s -> Val }
  "var"					{ \s -> Var }
  "func"				{ \s -> Func }
  "("					{ \s -> LParen }
  ")"					{ \s -> RParen }
  "{"					{ \s -> LBracket }
  "}"					{ \s -> RBracket }
  "="					{ \s -> Eq }
  ":"					{ \s -> Colon }
  ","					{ \s -> Comma }
  $digit+				{ \s -> TInt (read s) }
  $alpha [$alpha $digit \_ \']*		{ \s -> ID s }
{
-- Each action has type :: String -> Token

-- The token type:
data Token =
    Return  		|
    TokTrue		|
    TokFalse		|
    Val			|
    Var			|
    Func		|
    LParen		|
    RParen		|
    LBracket		|
    RBracket		|
    Eq			|
    Colon		|
    Comma		|
    ID String		|
    TString String	|
    TInt Int	
    deriving (Eq,Show)

}
