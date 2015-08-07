#include "top_sort.h"

/**
 * Tries to topologically sort the nodes. Modifies original list.
 * returns false if no sorted order is possible.
 */
bool top_sort(std::list<GraphNode*> &graphNodes) {
  std::list<GraphNode*> sortedNodes;
  std::set<GraphNode*> unmarkedNodes(graphNodes.begin(), graphNodes.end());
  std::set<GraphNode*> seenNodes;
  while (!unmarkedNodes.empty()) {
    GraphNode *node  = *(unmarkedNodes.begin());
    if (!explore(node, unmarkedNodes, seenNodes, sortedNodes)) {
      return false;
    }
  }
  graphNodes = sortedNodes;
}

bool explore(GraphNode* node,
             std::set<GraphNode*> &unmarkedNodes,
             std::set<GraphNode*> &seenNodes,
             std::list<GraphNode*> &sortedNodes) {
  if (seenNodes.find(node) != seenNodes.end()) { // Temp marked. Cycle present.
    return false;
  }
  if (unmarkedNodes.find(node) == unmarkedNodes.end()) { // Already visited.
    return true;
  }
  seenNodes.insert(node);
  for (std::list<GraphNode*>::iterator it = node->neighbors_begin();
        it != node->neighbors_end(); ++it) {
    if (!explore(*it, unmarkedNodes, seenNodes, sortedNodes)) {
      return false;
    }
  }
  seenNodes.erase(node);
  unmarkedNodes.erase(node);
  sortedNodes.push_front(node);
  return true;
}
