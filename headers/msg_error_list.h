#include <stdio.h>
#include <stdlib.h>

typedef struct Node node;
struct Node{
	
	char msg [100];
	int line_number;
	node * next;

};

node * list_error;

node * createList(node * list);

int is_empty(node *list);

void insert_msg(node *list, char msg[100], int line_number);

void print_msg(node *list);

