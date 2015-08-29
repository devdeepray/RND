#include "top_sort.h"
#include <algorithm>

bool top_sort(std::vector<GraphNode*> &graphNodes) {

  std::vector<GraphNode*> sorted;
  for (auto node : graphNodes) {
    if (!explore(node, sorted)) {
      return false; // Cycle was detected during DFS.
    }
  }

  graphNodes = sorted;
  for (auto node : graphNodes) {
    node->setExplored(false);
  }
  reverse(graphNodes.begin(), graphNodes.end());
}

bool explore(GraphNode* node, std::vector<GraphNode*> &sorted) {
  if (node->getTemp()) {
    return false; // Cycle detected as we saw a back edge.
  }
  if (node->getExplored()) {
    return true; // No need to explore neighbors, already done.
  }

  node->setTemp(true); // Add a temporary mark.
  for (auto nbr : node->getNeighbors()) {
    if (!explore(nbr, sorted)) {
      return false; // Cycle detected.
    }
  }

  node->setTemp(false); // Remove temporary mark.
  node->setExplored(true); // Add permanent mark.
  sorted.push_back(node); // Add to sorted vector.
  return true;
}
