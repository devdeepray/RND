#ifndef _GRAPH_NODE_H_
#define _GRAPH_NODE_H_

struct GraphNode {
  int n;
  int numnbrs;
  GraphNode** nbrs;
  bool explored;
  bool temp_marked;
};

#endif
