
#include "top_sort.h"
#include <iostream>
using namespace std;

bool explore(GraphNode* node, GraphNode** sorted, int* index, bool* tempMarked, bool* seen) {
  int nodeInd = node->ind;
  if (tempMarked[nodeInd]) {
    return false; // Cycle detected as we saw a back edge.
  }
  if (seen[nodeInd]) {
    return true; // No need to explore neighbors, already done.
  }

  tempMarked[nodeInd] = true; // Add a temporary mark.

  GraphNode** nbrs = node->nbrs;
  for (int i = 0; i < node->numnbrs; ++i) {
    if (!explore(nbrs[i], sorted, index, tempMarked, seen)) {
      return false; // Cycle detected.
    }
  }

  tempMarked[nodeInd] = false;; // Remove temporary mark.
  seen[nodeInd] = true; // Add permanent mark.
  sorted[*index] = node; // Add to sorted vector.
  ++(*index);
  return true;
}

bool top_sort(int size, GraphNode** nodes, GraphNode** sorted) {
  int curindex = 0; // Index of sorted node position
  bool *tempMarked = (bool*)malloc(size * sizeof(bool));
  bool *seen = (bool*)malloc(size * sizeof(bool));
  for (int i = 0; i < size; ++i) {
    tempMarked[i] = false;
    seen[i] = false;
  }
  for (int i = 0; i < size; ++i) {
    if (!explore(nodes[i], sorted, &curindex, tempMarked, seen)) {
      free(tempMarked); // Quick return needs freeing.
      free(seen);
      return false;
    }
  }
  // Reverse the nodes.
  for (int i = 0; i < size / 2; ++i) {
	GraphNode* tmp = sorted[i];
	sorted[i] = sorted[size - i - 1];
	sorted[size - i - 1] = tmp;
  }
  free(tempMarked);
  free(seen);
  return true;
}
