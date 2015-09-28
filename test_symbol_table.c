#include <stdio.h>
#include <stdlib.h>
#include "symbol_table.h"
#include "symbol_table.c"

int main (){

	node *list;

		list = createList(list);

		node *SymbolTeste;
		insertSymbol(list, "TESTE");

		SymbolTeste = findSymbol(list, "TESTE");

		destroyList(list);

}