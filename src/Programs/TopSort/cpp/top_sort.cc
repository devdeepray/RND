#include "top_sort.h"
#include <algorithm>

std::vector<GraphNode*> top_sort(std::vector<GraphNode*> &graphNodes) {

  std::vector<GraphNode*> sorted;
  for (auto node : graphNodes) {
    if (!explore(node, sorted)) {
      return std::vector<GraphNode*>(); // Cycle was detected during DFS.
    }
  }

  for (auto node : graphNodes) {
    node->setExplored(false);
  }
  reverse(sorted.begin(), sorted.end());
  return sorted;
}

bool explore(GraphNode* node, std::vector<GraphNode*> &sorted) {
  if (node->getTemp()) {
    return false; // Cycle detected as we saw a back edge.
  }
  if (node->getExplored()) {
    return true; // No need to explore neighbors, already done.
  }

  node->setTemp(true); // Add a temporary mark.
//  const std::vector<GraphNode*> &tmp = node->getNeighbors(); // Leads to slow down
//  for (int i = 0; i < tmp.size(); ++i) {
//    if (!explore(tmp[i], sorted)) {
//      return false;
//    }
//  }
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
