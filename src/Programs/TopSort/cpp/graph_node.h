#ifndef _GRAPH_NODE_H_
#define _GRAPH_NODE_H_

#include <vector>
/**
 * Class representing a node in a directed graph.
 */
class GraphNode {
private:
  std::vector<GraphNode*> neighbors;
  int ind;
public:
  int n; // Placeholder for data to be stored in the node.

  GraphNode(int _ind) {
    ind = _ind;
  }

  GraphNode() {
    GraphNode(0);
  }

  void addNeighbor(GraphNode* node) {
    neighbors.push_back(node);
  }

  std::vector<GraphNode*> getNeighbors() {
    return neighbors;
  }

  int getInd() {
    return ind;
  }
};

#endif // _GRAPH_NODE_H_
