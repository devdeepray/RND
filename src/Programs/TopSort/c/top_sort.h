#ifndef _TOP_SORT_H_
#define _TOP_SORT_H_

#include "graph_node.h"

void top_sort(int size, GraphNode** nodes, GraphNode** sorted);

bool explore(GraphNode* node, GraphNode** sorted, int* index);

#endif // _TOP_SORT_H_
