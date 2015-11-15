#include <iostream>
#include <vector>
#include <list>
#include <algorithm>
#include <sys/time.h>
#include "graph_node.h"
#include "top_sort.h"

using namespace std;

/**
 * Get the current time from epoch in ms.
 */
long getCurrentTime() {
  struct timeval tp;
  gettimeofday(&tp, NULL);
  long int us = tp.tv_sec * 1000 + tp.tv_usec / 1000;
  return us;
}

/**
 * Generate a dense graph without cycles.
 * Generated graph has O(n^2) edges and node i has edges to
 * nodes < i.
 */
vector<GraphNode *> genGraph(int n, vector<GraphNode> &nodes) {

  vector<GraphNode *> nodeList(n);
  for (int i = 0; i < n; ++i) {
    nodes[i] = GraphNode(i);
    nodeList[i] = &nodes[i];
    for (int j = i + 1; j < n; ++j) {
      nodes[i].addNeighbor(&nodes[j]);
    }
  }

  return nodeList;
}

vector<GraphNode *> genSparseGraph(int n, int deg, vector<GraphNode> &nodes) {
  vector<GraphNode *> nodeList(n);
  for (int i = 0; i < n; ++i) {
    nodes[i] = GraphNode(i);
    nodeList[i] = &nodes[i];
    for (int j = i + 1; j <= min(i + deg, n - 1); ++j) {
      nodes[i].addNeighbor(&nodes[j]);
    }
  }

  return nodeList;
}

int main() {

  int START = 1000, END = 3000, DELTA = 100, NUM_RUN = 10;
  cout << "[DENSE]" << endl;
  for (int size = START; size <= END; size += DELTA) {
    vector<GraphNode> nodes(size);
    vector<GraphNode *> nodeList = genGraph(size, nodes);
    vector<GraphNode *> sorted;
    long start = getCurrentTime();
    for (int i = 0; i < NUM_RUN; ++i)
      sorted = top_sort(nodeList);
    // Uncomment to see sorted list
    /*for (auto node : sorted) {
      cout << node->n << ": " ;
      for (auto node2 : node->getNeighbors()) {
        cout << node2->n << " " ;
      }
      cout << endl;
    }*/
    long end = getCurrentTime();
    long numedges = (size * (size - 1)) / 2 + size;
    cout << size << "," << (double)(end - start) / NUM_RUN << "," << endl;
  }
  NUM_RUN = 100;
  cout << "[SPARSE]" << endl;
  for (int size = START; size <= END; size += DELTA) {
    vector<GraphNode> nodes(size);
    for (int i = 0; i < size; ++i) {
      nodes[i].n = i;
    }
    vector<GraphNode *> nodeList = genSparseGraph(size, 100, nodes);
    vector<GraphNode *> sorted;
    long start = getCurrentTime();
    for (int i = 0; i < NUM_RUN; ++i)
      sorted = top_sort(nodeList);
    // Uncomment to see sorted list
    /*for (auto node : sorted) {
      cout << node->n << ": " ;
      for (auto node2 : node->getNeighbors()) {
        cout << node2->n << " " ;
      }
      cout << endl;
    }*/
    long end = getCurrentTime();
    long numedges = size * 500;
    cout << size << "," << (double)(end - start) / NUM_RUN << "," << endl;
  }
}
