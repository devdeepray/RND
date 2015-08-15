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
  int n;
  GraphNode(int _n) {
    n = _n;
  }
  std::list<GraphNode*> getNeighbors() {
    return neighbors;
  }

  void addNeighbor(GraphNode* node) {
    neighbors.push_back(node);
  }
};
#endif // _GRAPH_NODE_H_
