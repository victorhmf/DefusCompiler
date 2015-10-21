#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "msg_error_list.h"

line * create_list_msg(line * list){

list = (line*) malloc(sizeof(line));

	if(list == NULL){
		printf("Mémoria Indisponível\n");
		exit(1);
	}

	list->next = NULL;
}

int is_empty_list(line *list){
	if(list->next == NULL){
		return 1;
	}
	else
	{
		return 0;
	}
}


void insert_msg(line * list , char msg[100], int line_number){

	line * new_node = (line*) malloc(sizeof(line));

	if(new_node == NULL){
		printf("Memória Indisponível");
		exit(1);
	}
	else
	{

		if (is_empty_list(list)){
			list->next = new_node;
			new_node->next = NULL;
		}
		else{
			
			line * iterator = list->next;

			while(iterator->next != NULL){
				iterator = iterator->next;
			}
			iterator->next = new_node;
			new_node->next = NULL;
		}
		strcpy(new_node->msg , msg);
		new_node->line_number = line_number;
	}
}

void print_msg(line *list) {

	if(is_empty_list(list)){
		printf("Lista Vazia\n");

	}
	else 
	{
		line * iterator;
		iterator = list->next;

		while(iterator != NULL){
			printf("%s , linha: %d\n" , iterator->msg , iterator->line_number);
			iterator = iterator->next;
		}
	}
}

void generate_log(line *list) {

	if(is_empty_list(list)){
		printf("Lista Vazia\n");

	}
	else 
	{
	
		FILE * f_pont;

		f_pont = fopen ("output/log.txt" , "a");
	
		line * iterator;
	
		iterator = list->next;

		while(iterator != NULL){
			fprintf(f_pont , "%s , linha: %d\n" , iterator->msg , iterator->line_number);
			iterator = iterator->next;
		}

		fclose(f_pont);

	}

}