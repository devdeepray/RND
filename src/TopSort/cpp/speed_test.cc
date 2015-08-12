#include <iostream>
#include <list>
#include <sys/time.h>
#include "graph_node.h"
#include "top_sort.h"

#define DAG_SIZE 50000
#define NUM_RUNS 10
using namespace std;

long getCurrentTime() {
  struct timeval tp;
  gettimeofday(&tp, NULL);
  long int ms = tp.tv_sec * 1000 + tp.tv_usec / 1000;
  return ms;
}

int main() {
  // Construct graph.
  list <GraphNode*> nodeList;
  nodeList.push_back(new GraphNode(1));
  for (int i = 1; i < DAG_SIZE; ++i) {
    GraphNode* last = (*nodeList.begin());
    GraphNode* newNode = new GraphNode(i+1);
    std::list<GraphNode*> last_neighbors = last->getNeighbors();
    for (std::list<GraphNode*>::reverse_iterator it = last_neighbors.rbegin();
         it != last_neighbors.rend();
         ++it) {
      newNode->addNeighbor(*it);
    }
    nodeList.push_back(newNode);
    nodeList.reverse();
  }

  long start = getCurrentTime();
  for (int i = 0; i < NUM_RUNS; ++i) {
    cout << top_sort(nodeList) << endl;
  }
  long end = getCurrentTime();
  cout << "Time elapsed to sort: \n";
  cout << (end - start) / NUM_RUNS <<  endl;
} 
