#include <iostream>
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
list<GraphNode*> genGraph(int n) {

  list <GraphNode*> nodeList;
  nodeList.push_back(new GraphNode(1));

  for (int i = 1; i < n; ++i) {
    GraphNode* last = (*nodeList.begin());
    GraphNode* newNode = new GraphNode(i+1);
    std::list<GraphNode*> last_neighbors = last->getNeighbors();
    for (std::list<GraphNode*>::reverse_iterator it = last_neighbors.rbegin();
         it != last_neighbors.rend();
         ++it) {
      newNode->addNeighbor(*it);
    }
    newNode->addNeighbor(last);
    nodeList.push_front(newNode);
    nodeList.reverse();
  }
  return nodeList;
}

/**
 * Free memory allocated for the graph.
 */
void deleteGraph(list<GraphNode*> nodeList) {
  for (auto iter = nodeList.begin(); iter != nodeList.end(); ++iter) {
    delete (*iter);
  }
}

int main() {

  int NUM_RUNS = 1;
  for (int size = 1000; size <= 5000; size += 100) {
    list<GraphNode*> nodeList = genGraph(size);
    long start = getCurrentTime();
    for (int i = 0; i < NUM_RUNS; ++i) {
      top_sort(nodeList);
    } 
    long end = getCurrentTime();
    deleteGraph(nodeList);
    cout << size << "," << (double) (end - start) / NUM_RUNS << "," << endl;
  }
}
