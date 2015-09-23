#include <stdio.h>
#include <stdlib.h>
#include "symbol_table.h"
#include "symbol_table.c"

int main (){

	node *list = (node *) malloc (sizeof(node));

	if(list == NULL){
		printf("Mémoria Indisponível\n");
		exit(1);
	}
	else
	{	
		createList(list);

		node *SymbolTeste;
		insertSymbol(list, "TESTE");

		SymbolTeste = findSymbol(list, "TESTE");

		destroyList(list);
	}
}