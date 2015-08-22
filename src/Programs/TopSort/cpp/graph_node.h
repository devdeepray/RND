#ifndef _GRAPH_NODE_H_
#define _GRAPH_NODE_H_

#include <list>
/**
 * Class representing a node in a directed graph.
 */
class GraphNode {
private:
  std::list<GraphNode*> neighbors;

public:
  int n; // Placeholder for data to be stored in the node.

  GraphNode(int _n) {
    n = _n;
  }

  void addNeighbor(GraphNode* node) {
    neighbors.push_back(node);
  }

  std::list<GraphNode*> getNeighbors() {
    return neighbors;
  }
};
#endif // _GRAPH_NODE_H_
