#include <stdio.h>
#include <stdlib.h>

typedef struct Node node;
struct Node {
	
	char symbol [40];
	int initialized;
	int utilized;
	int line_number;
	char scope [40];
	int num_params;
	node *next;


};

node *node_iterator;
node *current_node;
node *next_node;
node *list;

node * createList (node *list);

int is_empty(node *list);

void insertSymbol (node *list, char symbol [40], node * new_node);

int findSymbol (node *list, char symbol [40], char scope[40]);

void destroy_list (node *node);

void check_initialized_var (node *list);

void set_initialized_1 (node *list, char symbol[40]);

void set_utilized_1 (node *list, char symbol[40]);

void set_num_params_function(node *list, char symbol[40], int num_params);

void check_num_params_function(node *list, char symbol[40], int num_params, int line_number);

