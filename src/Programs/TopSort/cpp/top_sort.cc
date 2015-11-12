#include "top_sort.h"

bool explore(GraphNode* node, std::vector<GraphNode*> &sorted,
             std::vector<bool> &tempMarked, std::vector<bool> &seen) {
  
	int nodeInd = node->getInd();
  if (tempMarked[nodeInd]) {
    return false; // Cycle detected as we saw a back edge.
  }
  if (seen[nodeInd]) {
    return true; // No need to explore neighbors, already done.
  }

  tempMarked[nodeInd] = true; // Add a temporary mark.
  for (auto nbr : node->getNeighbors()) {
    if (!explore(nbr, sorted, tempMarked, seen)) {
      return false; // Cycle detected.
    }
  }

  tempMarked[nodeInd] = false; // Remove temporary mark.
  seen[nodeInd] = true; // Add permanent mark.
  sorted.push_back(node); // Add to sorted vector.
  return true;
}

std::vector<GraphNode*> top_sort(const std::vector<GraphNode*> &graphNodes) {
  std::vector<GraphNode*> sorted;
  std::vector<bool> tempMarked(graphNodes.size(), false), seen(graphNodes.size(), false);
  for (auto node : graphNodes) {
    if (!explore(node, sorted, tempMarked, seen)) {
      return std::vector<GraphNode*>(); // Cycle was detected during DFS.
    }
  }
  reverse(sorted.begin(), sorted.end());
  return sorted;
}
