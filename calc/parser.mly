%{
  open Syntax
%}

/* Lexemes */
%token <int> NUMERAL
%token PLUS
%token MINUS
%token TIMES
%token DIVIDE
%token UMINUS
%token LPAREN
%token RPAREN
%token EOF

/* Precedence and associativity */
%left PLUS MINUS
%left TIMES DIVIDE
%nonassoc UMINUS

/* Top level rule */
%start toplevel
%type <Syntax.expression> toplevel

%%

/* Grammar */

toplevel: e = expression EOF
  { e }
;

expression:
  | n = NUMERAL                             { Numeral n }
  | e1 = expression TIMES  e2 = expression  { Times (e1, e2) }
  | e1 = expression PLUS   e2 = expression  { Plus (e1, e2) }
  | e1 = expression MINUS  e2 = expression  { Minus (e1, e2) }
  | e1 = expression DIVIDE e2 = expression  { Divide (e1, e2) }
  | MINUS e = expression %prec UMINUS       { Negate e }
  | LPAREN e = expression RPAREN            { e }
;
