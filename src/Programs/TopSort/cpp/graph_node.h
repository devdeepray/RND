#ifndef _GRAPH_NODE_H_
#define _GRAPH_NODE_H_

#include <vector>
/**
 * Class representing a node in a directed graph.
 */
class GraphNode {
private:
  std::vector<GraphNode*> neighbors;
  bool explored;
  bool temp_marked;
public:
  int n; // Placeholder for data to be stored in the node.

  GraphNode() {
    explored = false;
    temp_marked = false;
  }

  GraphNode(int _n) {
    GraphNode();
    n = _n;
  }

  void addNeighbor(GraphNode* node) {
    neighbors.push_back(node);
  }

  std::vector<GraphNode*> getNeighbors() {
    return neighbors;
  }

  void setExplored(bool val) {
    explored = val;
  }
  
  bool getExplored() {
    return explored;
  }

  void setTemp(bool val) {
    temp_marked = val;
  }

  bool getTemp() {
    return temp_marked;
  }
};
#endif // _GRAPH_NODE_H_
