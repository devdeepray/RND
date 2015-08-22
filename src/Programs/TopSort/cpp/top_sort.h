#ifndef _TOP_SORT_H_
#define _TOP_SORT_H_

#include <list>
#include <set>
#include "graph_node.h"

/**
 * Takes in a list of nodes in the graph and topologically sorts
 * the list of nodes.
 * Returns true iff a topological sort is possible.
 */
bool top_sort(std::list<GraphNode*> &graphNodes);

/**
 * Runs DFS on a node, topologically sorting the nodes in the induced
 * subgraph.
 * Returns true iff no cycles were found.
 */
bool explore(GraphNode* node,
             std::set<GraphNode*> &unmarkedNodes,
             std::set<GraphNode*> &seenNodes,
             std::list<GraphNode*> &sortedNodes);

#endif // _TOP_SORT_H_
