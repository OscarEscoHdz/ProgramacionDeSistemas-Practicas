%{
#include <stdio.h>
int num_hexadecimales = 0;
int num_binarios = 0;
int num_aleatorios = 0;
%}

%%

0x[0-9a-fA-F]+    { num_hexadecimales++;  printf("%s es un número hexadecimal\n", yytext); }

0b[01]+           { num_binarios++;   printf("%s es un número binario\n", yytext); }

[ \r\t\n]+        { /* ignorar espacios y saltos */ }

[A-Za-z0-9]+      { num_aleatorios++; printf("%s cadena desconocida\n", yytext); }

.                 { num_aleatorios++; printf("%s cadena desconocida\n", yytext); }

%%

int main(int argc, char **argv){
    ++argv, --argc;

    if(argc > 0){
      yyin = fopen(argv[0], "r");
      if(!yyin){
        perror("No se pudo abrir el archivo");
        return 1;
      }
    }else{
      yyin = stdin;
    }

    yylex();

    printf("\nResumen:\n");
    printf("Números hexadecimales encontrados: %d\n", num_hexadecimales);
    printf("Números binarios encontrados: %d\n", num_binarios);
    printf("Cadenas aleatorias encontradas: %d\n", num_aleatorios);

    return 0;
}

int yywrap(){
    return 1;
}
