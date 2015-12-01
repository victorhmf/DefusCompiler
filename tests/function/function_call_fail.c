#include <stdio.h>
#include <stdlib.h>

//Soma dois números
int soma (int one_parameter, int second_paramater) {

int resultado = 0;
resultado = one_parameter + second_paramater;

return resultado;

}

//Subtrai dois números
int subtracao (int one_parameter, int second_paramater) {

	int resultado = 0;
	resultado = one_parameter - second_paramater;

	return resultado;

}

int main (){

	int one_parameter = 5;
	int second_paramater = 7;

	int resultado_soma = 0;
	resultado_soma = soma ();
}

