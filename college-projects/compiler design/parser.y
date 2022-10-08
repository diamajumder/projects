%{
	#include <stdio.h>
	#include <stdlib.h>
	int yylex();
	int yyerror();
	extern FILE *yyin;
%}
%token ID NUM OB CB SB SCB TRANSPOSE NCTRANSPOSE COL COM NOT MULOP ADDOP RELOP EQUOP LOGOP EQ SEMICOL NL GLOBAL CLEAR IF ELSE ELSEIF END FOR WHILE BREAK RETURN FUNCTION
%%
translation_unit: statlist
				| FUNCTION func_decl eostmt statlist
				;
statlist: stat
		| statlist stat
		;
stat: globalstat
	| clearstat
	| assgstat
	| expnstat
	| selection
	| iteration
	| jump
	;
globalstat: GLOBAL idlist eostmt
			;		
idlist: ID
		| idlist ID
		;
eostmt: COM
		| SEMICOL
		| NL
		;	
clearstat: CLEAR idlist eostmt
		;
assgstat: assg_exp eostmt
		;
assg_exp: postfix EQ expn
		;
postfix: primary_exp
		| array_exp
		| postfix TRANSPOSE
		| postfix NCTRANSPOSE
		;
expn: log_exp
	| expn COL log_exp
	;
log_exp: equ_exp
		| log_exp LOGOP equ_exp
		;
equ_exp: rel_exp
		| equ_exp EQUOP rel_exp
		;
rel_exp: add_exp
		| rel_exp RELOP add_exp
		;
add_exp: mul_exp
		| add_exp ADDOP mul_exp
		;
mul_exp: unary_exp
		| mul_exp MULOP unary_exp
		;
unary_exp: postfix
		| NOT postfix
		;
primary_exp: ID
			| NUM
			| OB expn CB
			| SB SCB
			| SB arraylist SCB
			;
arraylist: arrayelement
		| arraylist arrayelement
		;
arrayelement: expn
			| expnstat
			;
expnstat: eostmt
		| expn eostmt
		;
array_exp: ID OB index_exp_list CB
				;
index_exp_list: index_exp
				| index_exp_list COM index_exp
				;
index_exp: COL
		| expn
		;
selection: IF expn statlist END eostmt
		| IF expn statlist ELSE statlist END eostmt
		| IF expn statlist elseif END eostmt
		| IF expn statlist elseif ELSE statlist END eostmt
		;
elseif: ELSEIF expn statlist 
		| elseif ELSEIF expn statlist
		;
iteration: WHILE expn statlist END
		| FOR ID EQ expn statlist END eostmt
		| FOR OB ID EQ expn CB statlist END eostmt
		;
jump: BREAK eostmt
	| RETURN eostmt
	;
func_decl: func_decl_lhs
		| func_return_list EQ func_decl_lhs
		;
func_decl_lhs: ID
			| ID OB CB
			| ID OB func_ident_list CB
			;
func_return_list: ID
				| SB func_ident_list SCB
				;
func_ident_list: ID
				| func_ident_list COM ID
				;


%%
int yyerror()
{
	printf("failed\n");
	return 1;
}
void main()
{
//project.txt
	yyin=fopen("project.txt","r");
	do{
	if(yyparse())
	{
		printf("failure\n");
		print();
		exit(1);
	}
	}while(!feof(yyin));
	printf("success\n");
	print();
}
