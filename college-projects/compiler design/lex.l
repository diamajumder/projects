%{
	#include "symtab.c"
	#include "parser.tab.h"
	int j=0;
	token t[len];
%}
%%
"%".*"\n"	{;}
\n { printf("\n"); return NL;}
\t {;}
"("	{ printf("%s ",yytext); return OB;}
")"	{ printf("%s ",yytext); return CB;}
"["	{ printf("%s ",yytext); return SB;}
"]"	{ printf("%s ",yytext); return SCB;}
"transpose"	{ printf("%s ",yytext); return TRANSPOSE;}
".\'"	{ printf("%s ",yytext); strcpy(t[j].name,yytext); strcpy(t[j].type,"op"); 
			insert(t[j]); j++; return NCTRANSPOSE;}
":"	{ printf("%s ",yytext); return COL;}
","	{ printf("%s ",yytext); return COM;}
"~"	{ printf("%s ",yytext); strcpy(t[j].name,yytext); strcpy(t[j].type,"op"); insert(t[j]); j++; return NOT;}
"*"|"/"|"\\"|"^"|".*"|"./"|".\\"|".^"	{ printf("%s ",yytext); strcpy(t[j].name,yytext); strcpy(t[j].type,"op");
										insert(t[j]); j++; return MULOP;}
"+"|"-" { printf("%s ",yytext); strcpy(t[j].name,yytext); strcpy(t[j].type,"op"); insert(t[j]); j++; return ADDOP;}
"<"|">"|"<="|">="	{ printf("%s ",yytext); strcpy(t[j].name,yytext); strcpy(t[j].type,"op"); 
						insert(t[j]); j++; return RELOP;}
"=="|"~="	{ printf("%s ",yytext); strcpy(t[j].name,yytext); strcpy(t[j].type,"op"); insert(t[j]); j++; return EQUOP;}
"&"|"|"	{ printf("%s ",yytext); strcpy(t[j].name,yytext); strcpy(t[j].type,"op"); insert(t[j]); j++; return LOGOP;}
"="	{ printf("%s ",yytext); strcpy(t[j].name,yytext); strcpy(t[j].type,"op"); insert(t[j]); j++; return EQ;}
";"	{ printf("%s ",yytext); return SEMICOL;}
"global" { printf("%s ",yytext);  return GLOBAL;}
"clear" { printf("%s ",yytext); return CLEAR;}
"if" { printf("%s ",yytext); return IF;}
"else" { printf("%s ",yytext); return ELSE;}
"elseif" { printf("%s ",yytext); return ELSEIF;}
"end" { printf("%s ",yytext); return END;}
"for" { printf("%s ",yytext); return FOR;}
"while" { printf("%s ",yytext); return WHILE;}
"break" { printf("%s ",yytext); return BREAK;}
"return" { printf("%s ",yytext); return RETURN;}
"function" { printf("%s ",yytext); return FUNCTION;}

[0-9]+	{printf("%s ",yytext); strcpy(t[j].name,yytext); strcpy(t[j].type,"num"); insert(t[j]); j++; return NUM;}
[a-z][a-zA-z_0-9]*	{ printf("%s ",yytext); strcpy(t[j].name,yytext); strcpy(t[j].type,"id"); 
						insert(t[j]), j++; return ID;}
.	{ printf("%s ",yytext);}
%%
int yywrap()
{
	return 1;
}
