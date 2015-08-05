#ifndef _TOP_SORT_H_
#define _TOP_SORT_H_

#include <list>
#include <set>
#include "graph_node.h"

std::list<GraphNode*> top_sort(std::list<GraphNode*> graphNodes);

bool explore(GraphNode* node,
             std::set<GraphNode*> &unmarkedNodes,
             std::set<GraphNode*> &seenNodes,
             std::list<GraphNode*> &sortedNodes);
#endif // _TOP_SORT_H_
