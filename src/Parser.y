{
module Parser ( parse ) where
import qualified Lexer as L
}

%name parse
%tokentype { L.Token }
%error { parseError }

%token
asm	{ L.Asm }
return	{ L.Return }
true	{ L.TokTrue }
false	{ L.TokFalse }
val	{ L.Val }
var	{ L.Var}
lparen	{ L.LParen }
rparen	{ L.RParen }
lbrack	{ L.LBracket }
rbrack	{ L.RBracket }
int	{ L.Int $$ }
eq	{ L.Eq }
id	{ L.ID $$ }
comma	{ L.Comma }
%%

Program : Exprs			{}

Exprs : Expr			{}
	| Expr Exprs		{}

Ids : id comma Ids		{id $1}
	| id			{id $1}

Expr : id lparen Ids rparen	{id $1}

{
parseError toks = error "Oh no"
}
