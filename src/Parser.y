{
module Parser ( parse ) where
import qualified Lexer as L
}

%name parse
%tokentype { L.Token }
%error { parseError }

%token
return	{ L.Return }
true	{ L.TokTrue }
false	{ L.TokFalse }
val	{ L.Val }
var	{ L.Var }
'('	{ L.LParen }
')'	{ L.RParen }
'{'	{ L.LBracket }
'}'	{ L.RBracket }
int	{ L.TInt $$ }
'='	{ L.Eq }
id	{ L.ID $$ }
','	{ L.Comma }
':'	{ L.Colon }
%%

Exprs : Exprs Expr				{ $2 : $1 }
      | Expr					{ [$1] }


Expr : Func					{ $1 }
     | FuncDecl					{ $1 }
     | Decl					{ $1 }

Func : id '(' Ids ')'				{ Func $1 $3 }
     | id '(' ')'				{ Func $1 [] }

FuncDecl : id id '(' Params ')' '{' Exprs '}'	{ FuncDecl $1 $2 $4 $7 }
	 | id id '(' ')' '{' Exprs '}'		{ FuncDecl $1 $2 [] $6 }



Params : Params ',' Param			{ $3 : $1 }
       | Param					{ [$1] }

Param : id ValType				{ Param $1 $2 }

Decl : var id ValType				{ Var $2 $3 }
    | val id ValType				{ Val $2 $3 }

ValType : '=' id				{ Value $2 }
	| ':' id				{ Type $2 }

Ids : Ids ',' id				{ $3 : $1 }
	| id					{ [$1] }



{
parseError toks = error "Oh no"

data Param = Param String ValType deriving(Show)
data ValType = Type String | Value String deriving(Show)
data Expr = Val String ValType | Var String ValType | Func String [String] | FuncDecl String String [Param] [Expr] deriving(Show)
}
