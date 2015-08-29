#include <iostream>
#include <vector>
#include <list>
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
  long int ms = tp.tv_sec * 1000 + tp.tv_usec / 1000;
  return ms;
}

/**
 * Generate a dense graph without cycles.
 * Generated graph has O(n^2) edges and node i has edges to 
 * nodes < i.
 */
vector<GraphNode*> genGraph(int n) {

  vector <GraphNode*> nodeList;
  nodeList.push_back(new GraphNode(0));

  for (int i = 1; i < n; ++i) {
    GraphNode* last = nodeList[i - 1];
    GraphNode* newNode = new GraphNode(i);
    std::vector<GraphNode*> last_neighbors = last->getNeighbors();
    for (auto it = last_neighbors.rbegin();
         it != last_neighbors.rend();
         ++it) {
      newNode->addNeighbor(*it);
    }
    newNode->addNeighbor(last);
    nodeList.push_back(newNode);
  }
  return nodeList;
}

/**
 * Free memory allocated for the graph.
 */
void deleteGraph(vector<GraphNode*> nodeList) {
  for (auto iter = nodeList.begin(); iter != nodeList.end(); ++iter) {
    delete (*iter);
  }
}

int main() {

  int NUM_RUNS = 5;
  for (int size = 1000; size <= 20000; size += 500) {
    vector<GraphNode*> nodeList = genGraph(size);
    long start = getCurrentTime();
    for (int i = 0; i < NUM_RUNS; ++i) {
      auto old = nodeList;
      top_sort(nodeList);
      nodeList = old;
    }
    // Uncomment to see sorted list
    /*for (auto node : nodeList) {
      cout << node->n << ": " ;
      for (auto node2 : node->getNeighbors()) {
        cout << node2->n << " " ;
      }
      cout << endl;
    } */
    long end = getCurrentTime();
    deleteGraph(nodeList);
    long lsize = size;
    long numedges = (lsize * lsize) / 4;
    cout << numedges << "," << (double) (end - start) / NUM_RUNS << "," << endl;
  }
}
