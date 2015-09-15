
#include "top_sort.h"
#include <iostream>
using namespace std;
void restoreFlags(int size, GraphNode** nodes) {
  for(int i = 0; i < size; ++i) {
    nodes[i]->explored = false;
    nodes[i]->temp_marked = false;
  }
}

void top_sort(int size, GraphNode** nodes, GraphNode** sorted) {

  int curindex = 0;
  for (int i = 0; i < size; ++i) {
    if (!explore(nodes[i], sorted, &curindex)) {
      restoreFlags(size, nodes);
      return;
    }
  }
  restoreFlags(size, nodes);
  for (int i = 0; i < size / 2; ++i) {
	GraphNode* tmp = sorted[i];
	sorted[i] = sorted[size - i - 1];
	sorted[size - i - 1] = tmp;
  }
  return;
}

bool explore(GraphNode* node, GraphNode** sorted, int* index) {
  if (node->temp_marked) {
    return false; // Cycle detected as we saw a back edge.
  }
  if (node->explored) {
    return true; // No need to explore neighbors, already done.
  }

  node->temp_marked = true; // Add a temporary mark.
  
  GraphNode** nbrs = node->nbrs;
  for (int i = 0; i < node->numnbrs; ++i) {
    if (!explore(nbrs[i], sorted, index)) {
      return false; // Cycle detected.
    }
  }

  node->temp_marked = false;; // Remove temporary mark.
  node->explored = true; // Add permanent mark.
  sorted[*index] = node; // Add to sorted vector.
  ++(*index);
  return true;
}
