#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "msg_error_list.h"

node * createList(node * list){
	
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

void insert_msg(node * list , char msg[100], int line_number){

	node * new_node = (node*) malloc(sizeof(node));

	if(new_node == NULL){
		printf("Memória Indisponível");
		exit(1);
	}
	else
	{
		new_node->next = list->next;
		list->next = new_node;

		strcpy(new_node->msg , msg);
		new_node->line_number = line_number;

		printf("Mensagem '%s' inserida!\n", new_node->msg);
	}
}

void print_msg(node *list) {

	if(is_empty(list)){
		printf("Lista Vazia\n");

	}
	else 
	{
		node * iterator;
		iterator = list->next;

		while(iterator != NULL){
			printf("%s , linha: %d\n" , iterator->msg , iterator->line_number);
			iterator = iterator->next;
		}
	}
}

