#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol_table.h"

#define TRUE 1
#define FALSE 0

node * createList(node *list){
	list = (node*) malloc(sizeof(node));

	if(list == NULL){
		printf("Mémoria Indisponível\n");
		exit(1);
	}

	list->next = NULL;
}

int is_empty(node *list)
{
	if(list->next == NULL){
		return 1;
	}
	else
	{
		return 0;
	}
}

void insertSymbol (node *list, char symbol [40]) 
{
	node *new_node = (node*) malloc(sizeof(node));

	if(new_node == NULL){
		printf("Memória Indisponível");
		exit(1);
	}
	else
	{
		new_node->next = list->next;
		list->next = new_node;

		strcpy(new_node->symbol , symbol);
	}
}

node * findSymbol (node *list, char symbol [40]) {
	int search_completed = FALSE;

	if(is_empty(list)){
		printf("Lista Vazia\n");
		return 0;
	}

	node_iterator = list->next;

	while(node_iterator != NULL){

		if(strcmp(symbol, node_iterator->symbol) == 0){
			search_completed = TRUE;
			printf("Simbolo : %s encontrado \n", node_iterator->symbol);

			return node_iterator;
		}
		node_iterator = node_iterator->next;

	}

	if(search_completed == FALSE){
		printf("Simbolo nao encontado! \n");
	}
}

void destroyList (node *list){

		if(!is_empty(list))
		{
			current_node = list->next;

			while(current_node != NULL){
				next_node = current_node->next;
				free(current_node);
				current_node = next_node;
			}

		}
		printf("Destruindo Lista\n");
}

