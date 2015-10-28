#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol_table.h"
#include "msg_error_list.h"

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

void insertSymbol (node *list, char symbol [40], node * new_node) 
{

	if(new_node == NULL){
		printf("Memória Indisponível");
		exit(1);
	}
	else
	{
		new_node->next = list->next;
		list->next = new_node;

		strcpy(new_node->symbol , symbol);
		
		char msg [100];
		snprintf(msg, 100, "Simbolo %s inserido!\n", new_node->symbol);
		
		insert_msg(list_msg_sucess, msg , 0);
	}
}

int findSymbol (node *list, char symbol [40]) {
	int search_completed = FALSE;

	if(is_empty(list)){
		char msg[100];
		snprintf(msg, 100 , "Lista Vazia");
		insert_msg(list_msg_sucess, msg, 0	);
		return 0;
	}

	node_iterator = list->next;

	while(node_iterator != NULL){

		if(strcmp(symbol, node_iterator->symbol) == 0){
			search_completed = TRUE;

			char msg [100];
			snprintf(msg, 100, "Simbolo %s encontrado ", node_iterator->symbol);
			
			insert_msg(list_msg_sucess, msg , 0);
			
			return 1;
		}
		node_iterator = node_iterator->next;

	}

	if(search_completed == FALSE){
		char msg [100];
		snprintf(msg, 100, "Simbolo %s nao encontado", symbol);
		
		insert_msg(list_msg_sucess, msg , 0);

		return 0;
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

void check_initialized_var (node *list){

	if(is_empty(list)){
		char msg[100];
		snprintf(msg, 100 , "Lista Vazia");
		insert_msg(list_msg_sucess, msg, 0	);
	}
	else {
		node_iterator = list->next;

		while(node_iterator !=NULL){

			if(node_iterator->initialized == 0){
				char msg[100];
				snprintf(msg ,100, "Variável '%s' não inicializada" , node_iterator->symbol);
				insert_msg(list_error, msg, node_iterator->line_number);
			}
			else{

			}

			node_iterator = node_iterator->next;
		}
	}
}

void set_initialized_1 (node *list, char symbol[40]){

	if(is_empty(list)){
		char msg[100];
		snprintf(msg, 100 , "Lista Vazia");
		insert_msg(list_msg_sucess, msg, 0	);
	}
	else{
		node_iterator = list->next;

		while(node_iterator != NULL){

			if(strcmp(symbol, node_iterator->symbol) == 0){

				char msg [100];
				snprintf(msg, 100, "Simbolo %s encontrado ", node_iterator->symbol);
			
				insert_msg(list_msg_sucess, msg ,0);

				node_iterator->initialized = 1;	
			}
			node_iterator = node_iterator->next;
		}

	}
}