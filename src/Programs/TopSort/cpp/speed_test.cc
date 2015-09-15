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
vector<GraphNode*> genGraph(int n, vector<GraphNode> &nodes) {

  vector<GraphNode*> nodeList(n);
  
  nodeList[0] = &(nodes[0]);

  for (int i = 1; i < n; ++i) {
    GraphNode* last = nodeList[i - 1];
    GraphNode* newNode = &(nodes[i]);
    std::vector<GraphNode*> last_neighbors = last->getNeighbors();
    for (auto it = last_neighbors.begin();
         it != last_neighbors.end();
         ++it) {
      newNode->addNeighbor(*it);
    }
    newNode->addNeighbor(last);
    nodeList[i] = newNode;
  }
  return nodeList;
}

vector<GraphNode*> genSparseGraph(int n, int deg, vector<GraphNode> &nodes) {
  vector<GraphNode*> nodeList(n);

  nodeList[0] = &(nodes[0]);

  for (int i = 1; i < n; ++i) {
    GraphNode* last = nodeList[i - 1];
    GraphNode* newNode = &(nodes[i]);
    std::vector<GraphNode*> last_neighbors = last->getNeighbors();
    int k = 0;
    for (int k = max(0, (int)last_neighbors.size() - deg); k < last_neighbors.size(); ++k) {
      newNode->addNeighbor(last_neighbors[k]);
    }
    newNode->addNeighbor(last);
    nodeList[i] = newNode;
  }
  return nodeList;
}  

int main() {

  int NUM_RUNS = 10;
  cout << "[DENSE]" << endl;
  for (int size = 1000; size <= 10000; size += 200) {
    vector<GraphNode> nodes(size);
    for (int i = 0; i < size; ++i) {
      nodes[i].n = i;
    }
    vector<GraphNode*> nodeList = genGraph(size, nodes);
    vector<GraphNode*> sorted;
    long start = getCurrentTime();
    for (int i = 0; i < NUM_RUNS; ++i) {
      sorted = top_sort(nodeList);
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
    long numedges = (size * (size - 1)) / 2 + size; 
    cout << numedges << "," << (double) (end - start) / NUM_RUNS << "," << endl;
  }
  NUM_RUNS = 100;
  cout << "[SPARSE]" << endl;
  for (int size = 1000; size <= 10000; size += 200) {
    vector<GraphNode> nodes(size);
    for (int i = 0; i < size; ++i) {
      nodes[i].n = i;
    }
    vector<GraphNode*> nodeList = genSparseGraph(size, 500, nodes);
    vector<GraphNode*> sorted;
    long start = getCurrentTime();
    for (int i = 0; i < NUM_RUNS; ++i) {
      sorted = top_sort(nodeList);
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
    long numedges = size * 500;
    cout << numedges << "," << (double) (end - start) / NUM_RUNS << "," << endl;
  }


}
