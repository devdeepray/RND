#ifndef _GRAPH_NODE_H_
#define _GRAPH_NODE_H_

#include <list>
/**
 * Abstract class representing a node in a directed graph.
 */
class GraphNode {
public:
  virtual typename std::list<GraphNode*>::iterator neighbors_begin();
  virtual typename std::list<GraphNode*>::iterator neighbors_end();
};
#endif // _GRAPH_NODE_H_
