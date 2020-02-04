{
module Parser ( ID (..), DataType (..), Param (..), ValType (..), Expr (..), parse ) where
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
func	{ L.Func }
','	{ L.Comma }
':'	{ L.Colon }
%%

Exprs : Exprs Expr						{ $2 : $1 }
      | Expr							{ [$1] }


Expr : Func							{ $1 }
     | FuncDecl							{ $1 }
     | Decl							{ $1 }

Func : ID '(' Datum ')'						{ Function $1 $3 }
     | ID '(' ')'						{ Function $1 [] }

FuncDecl : func ID '(' Params ')' DeclType '{' Exprs '}'	{ FunctionDecl $2 $4 $6 $8 }
	 | func ID '(' ')' ValType '{' Exprs '}'		{ FunctionDecl $2 [] $5 $7 }



Params : Params ',' Param					{ $3 : $1 }
       | Param							{ [$1] }

Param : ID ValType						{ Param $1 $2 }

Decl : var ID ValType						{ Var $2 $3 }
    | val ID ValType						{ Val $2 $3 }

ValType : '=' Data						{ Value $2 }
	| DeclType						{ $1 }

DeclType : ':' ID						{ Type $2 }

Datum : Datum ',' Data						{ $3 : $1 }
      | Data							{ [$1] }

Data : ID { VarName $1 } | int { IntLit $1 }

ID : id	{ ID $1 }

{
parseError toks = error "Oh no"

data ID = ID String deriving(Show)
data Param = Param ID ValType deriving(Show)
data DataType = VarName ID | IntLit Int deriving(Show)
data ValType = Type ID | Value DataType deriving(Show)
data Expr = Val ID ValType | Var ID ValType | Function ID [DataType] | FunctionDecl ID [Param] ValType [Expr] deriving(Show)
}
