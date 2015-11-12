#include <sys/time.h>
#include "graph_node.h"
#include "top_sort.h"
#include <cmath>
#include <iostream>
using namespace std;

long getCurrentTime() {
  struct timeval tp;
  gettimeofday(&tp, NULL);
  long int ms = tp.tv_sec * 1000 + tp.tv_usec / 1000;
  return ms;
}

void genGraph(int n, GraphNode** nodeList, GraphNode* nodes) {

  for (int i = 0; i < n; ++i) {
    nodeList[i] = &nodes[i];
    nodes[i].ind = i;
    nodes[i].numnbrs = n - i - 1;
    nodes[i].nbrs = (GraphNode**) malloc (sizeof(GraphNode**) * ( n - i - 1));
    for (int j = 0; j < n - i - 1; ++j) {
      nodes[i].nbrs[j] = &nodes[j + i + 1];
    }
  }
}

void cleanup(GraphNode* nodes, int n) {
  for (int i = 1; i < n; ++i) {
    delete [] nodes[i].nbrs;
  }
}

void genSparseGraph(int n, int deg, GraphNode** nodeList, GraphNode* nodes) {
  for (int i = 0; i < n; ++i) {
    nodeList[i] = &nodes[i];
    nodes[i].ind = i;
    nodes[i].numnbrs = min(deg, n - i - 1);
    nodes[i].nbrs = (GraphNode**) malloc (sizeof(GraphNode**) * nodes[i].numnbrs);
    for (int j = 0; j < nodes[i].numnbrs; ++j) {
      nodes[i].nbrs[j] = &nodes[j + i + 1];
    }
  }
}

int main() {
  int NUM_RUNS = 10, START = 1000, END = 3000, DELTA = 100;
  cout << "[DENSE]" << endl;
  for (int size = START; size <= END; size += DELTA) {
	  GraphNode* nodes = new GraphNode[size];
    GraphNode** nodeList = new GraphNode*[size];
    genGraph(size, nodeList, nodes);
    long start = getCurrentTime();
    GraphNode** sorted = new GraphNode*[size];
    for (int i = 0; i < NUM_RUNS; ++i) {
      top_sort(size, nodeList, sorted);
    }
    // Uncomment to see sorted list
    /*for (auto node : sorted) {
      cout << node->n << ": " ;
      for (auto node2 : node->getNeighbors()) {
        cout << node2->n << " " ;
      }
      cout << endl;
    }*/
    long end = getCurrentTime();
    cleanup(nodes, size);
    delete [] nodes;
    delete [] nodeList;
    delete [] sorted;
    long numedges = (size * (size - 1)) / 2 + size;
    cout << size << "," << (double) (end - start) / NUM_RUNS << "," << endl;
  }
	NUM_RUNS = 100;
  cout << "[SPARSE]" << endl;
  for (int size = START; size <= END; size += DELTA) {
    GraphNode* nodes = new GraphNode[size];
    GraphNode** nodeList = new GraphNode*[size];
    genSparseGraph(size, 100, nodeList, nodes);
    long start = getCurrentTime();
    GraphNode** sorted = new GraphNode*[size];
    for (int i = 0; i < NUM_RUNS; ++i) {
      top_sort(size, nodeList, sorted);
    }
    long end = getCurrentTime();
    cleanup(nodes, size);
    delete [] nodes;
    delete [] nodeList;
    delete [] sorted;
    long numedges = size * 500;
    cout << size << "," << (double) (end - start) / NUM_RUNS << "," << endl;
  }

}
