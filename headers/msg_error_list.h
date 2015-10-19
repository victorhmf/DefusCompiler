#include <stdio.h>
#include <stdlib.h>

typedef struct Line line;
struct Line{
	
	char msg [100];
	int line_number;
	line * next;

};

line * list_error;

line * create_list_error(line * list);

int is_empty_list(line *list);

void insert_msg(line *list, char msg[100], int line_number);

void print_msg(line *list);

