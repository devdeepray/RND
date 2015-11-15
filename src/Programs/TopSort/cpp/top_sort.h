#ifndef _TOP_SORT_H_
#define _TOP_SORT_H_

#include <vector>
#include <algorithm>
#include "graph_node.h"
using namespace std;

/**
 * Takes in a vector of nodes in the graph and topologically sorts
 * the vector of nodes, returning a list of integers in the sorted order.
 * Returns empty list if topsort not possible.
 */
vector<GraphNode *> top_sort(const vector<GraphNode *> &graphNodes);

#endif // _TOP_SORT_H_
