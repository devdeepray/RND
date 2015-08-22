#include "top_sort.h"

bool top_sort(std::list<GraphNode*> &graphNodes) {
  std::list<GraphNode*> sortedNodes;
  std::set<GraphNode*> unmarkedNodes(graphNodes.begin(), graphNodes.end());
  std::set<GraphNode*> seenNodes;

  while (!unmarkedNodes.empty()) {
    GraphNode *node  = *(unmarkedNodes.begin());
    if (!explore(node, unmarkedNodes, seenNodes, sortedNodes)) {
      return false; // Cycle was detected during DFS.
    }
  }

  graphNodes = sortedNodes;
}

bool explore(GraphNode* node,
             std::set<GraphNode*> &unmarkedNodes,
             std::set<GraphNode*> &seenNodes,
             std::list<GraphNode*> &sortedNodes) {
  if (seenNodes.find(node) != seenNodes.end()) {
    return false; // Cycle detected as we saw a back edge.
  }
  if (unmarkedNodes.find(node) == unmarkedNodes.end()) {
    return true; // No need to explore neighbors, already done.
  }

  seenNodes.insert(node); // Add a temporary mark.
  std::list <GraphNode*> nbr_list = node->getNeighbors();
  for (auto it = nbr_list.begin(); it != nbr_list.end(); ++it) {
    if (!explore(*it, unmarkedNodes, seenNodes, sortedNodes)) {
      return false; // Cycle detected.
    }
  }

  seenNodes.erase(node); // Remove temporary mark.
  unmarkedNodes.erase(node); // Add permanent mark.
  sortedNodes.push_front(node); // Add to sorted list.
  return true;
}
