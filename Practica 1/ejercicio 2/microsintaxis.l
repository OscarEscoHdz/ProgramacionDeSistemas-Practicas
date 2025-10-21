%{
#include<stdio.h>

int num_reservadas = 0;
	int num_variables = 0;
	int num_desconocidas = 0;
	int num_enteros = 0;
	int num_flotantes = 0;
	int num_cientificos = 0;
	int num_operadores = 0;
	int num_comentariosLinea = 0;
	int num_comentariosBloque = 0;
	int num_constante = 0;
	int num_cadenas = 0;
%}
COMENTARIO \/pikachu\/[^\n\r]*

COMENTARIO_BLOQUE \/pikachu\*([^*]|\*+[^*/])*\*+\/pikachu\/

ENTERO inteleon:-?[0-9]+

FLOTANTE floatzel:-?([0-9]+\.[0-9]*|\.[0-9]+)

NUMCIENTIFICO ({FLOTANTE}|{ENTERO})(xerneas|XERNEAS){FLOTANTE}

CADENA \@\@([^@]|@[^@])*\@\@

CONSTANTE metapod#[a-zA-Z_][a-zA-Z_]*:-?[0-9]+(\.[0-9]+)?

VARIABLE poke-[a-z][a-z0-9_]*


%%
{COMENTARIO_BLOQUE}   { num_comentariosBloque++; printf("\n%s es un comentario de bloque",yytext); }

{COMENTARIO}           { num_comentariosLinea++; printf("\n%s es un comentario de linea",yytext); }

{CADENA}    { num_cadenas++; printf("\n%s es una cadena",yytext); }

superball|evolucion|pocion|hiperball|megapiedra|repelente|pokedex|pokeball   { num_reservadas++; printf("\n%s es una palabra reservada",yytext); }

{CONSTANTE}  { num_constante++; printf("\n%s es una constante Pokémon", yytext); }

{VARIABLE}  { num_variables++; printf("\n%s es una variable Pokémon", yytext); }

{NUMCIENTIFICO}   { num_cientificos++; printf("\n%s es un numero cientifico",yytext); }

{FLOTANTE} { num_flotantes++; printf("\n%s es un flotante",yytext); }

{ENTERO} { num_enteros++; printf("\n%s es un entero",yytext); }

pluser|reuniclus|minum|ditto|tangela { num_operadores++; printf("\n%s es un operador",yytext); }

[a-zA-Z][a-zA-Z0-9_]*    { num_desconocidas++; printf("\n%s es una palabra desconocida", yytext);}


[^ \r\t\n]+   { printf("\n%s TIENE SÍMBOLOS DESCONOCIDOS\n",yytext); }



%%

int main(int argc, char **argv){
    ++argv, --argc;

    if(argc > 0){
      yyin = fopen (argv[0], "r");
    }else{
      yyin = stdin;
    }
    yylex();

    printf("\n=== RESUMEN FINAL ===");
    printf("\nPalabras reservadas: %d", num_reservadas);
    printf("\nVariables: %d", num_variables);
    printf("\nConstantes: %d", num_constante);
    printf("\nEnteros: %d", num_enteros);
    printf("\nFlotantes: %d", num_flotantes);
    printf("\nCientíficos: %d", num_cientificos);
    printf("\nOperadores: %d", num_operadores);
    printf("\nCadenas: %d", num_cadenas);
    printf("\nComentarios línea: %d", num_comentariosLinea);
    printf("\nComentarios bloque: %d", num_comentariosBloque);
    printf("\nDesconocidos: %d", num_desconocidas);
    return 0;
}

int yywrap(){
    return 1;
}
