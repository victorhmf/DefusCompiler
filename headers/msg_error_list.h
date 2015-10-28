#include <stdio.h>
#include <stdlib.h>

typedef struct Line line;
struct Line{
	
	char msg [100];
	int line_number;
	line * next;

};

line * list_error;
line * list_msg_sucess;

line * create_list_msg(line * list);

int is_empty_list(line *list);

void insert_msg(line *list, char msg[100], int line_number);

void print_msg(line *list);

void generate_log(line *list);

void ordena_por_linha(line* list);


