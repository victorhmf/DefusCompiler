#include <stdio.h>
#include <stdlib.h>

typedef struct Node node;
struct Node {
	
	char symbol [40];
	int initialized;
	int line_number;
	node *next;


};

node *node_iterator;
node *current_node;
node *next_node;
node *list;

node * createList (node *list);

int is_empty(node *list);

void insertSymbol (node *list, char symbol [40], node * new_node);

int findSymbol (node *list, char symbol [40]);

void destroy_list (node *node);

void check_initialized_var (node *list);

void set_initialized_1 (node *list, char symbol[40]);

