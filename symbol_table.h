#include <stdio.h>
#include <stdlib.h>

typedef struct Node node;
struct Node {
	
	char symbol [40];
	node *next;

};

node *node_iterator;
node *current_node;
node *next_node;

node * createList (node *list);

int is_empty(node *list);

void insertSymbol (node *list, char symbol [40]);

node * findSymbol (node *list, char symbol [40]);

void destroy_list (node *node);

