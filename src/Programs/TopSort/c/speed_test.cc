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
  nodeList[0] = &(nodes[0]);
  nodeList[0]->n = 0;
  nodeList[0]->numnbrs = 0;
  nodeList[0]->explored = false;
  nodeList[0]->temp_marked = false;
  for (int i = 1; i < n; ++i) {
    GraphNode* last = nodeList[i - 1];
    GraphNode* newNode = &(nodes[i]);
    newNode->n = i;
    newNode->nbrs = new GraphNode*[i];
    newNode->numnbrs = i;
    newNode->explored = false;
    newNode->temp_marked = false;
    for (int j = 0; j < i - 1; ++j) {
      newNode->nbrs[j] = last->nbrs[j];
    }
    newNode->nbrs[i-1] = last;
    nodeList[i] = newNode;
  }
}

void cleanup(GraphNode* nodes, int n) {
  for (int i = 1; i < n; ++i) {
    delete [] nodes[i].nbrs;
  }
}

void genSparseGraph(int n, int deg, GraphNode** nodeList, GraphNode* nodes) {
  nodeList[0] = &(nodes[0]);
  nodeList[0]->n = 0;
  nodeList[0]->numnbrs = 0;
  nodeList[0]->explored = false;
  nodeList[0]->temp_marked = false;
  for (int i = 1; i < n; ++i) {
    GraphNode* last = nodeList[i - 1];
    GraphNode* newNode = &(nodes[i]);
    newNode->n = i;
    newNode->nbrs = new GraphNode*[min(i, deg + 1)];
    newNode->explored = false;
    newNode->temp_marked = false;
      
    int numnr = 0;
    int j;
    for (j = max(0, last->numnbrs - deg); j < last->numnbrs; ++j) {
      newNode->nbrs[numnr] = last->nbrs[j];
      numnr++;
    }
    newNode->nbrs[numnr] = last;
    newNode->numnbrs = numnr + 1;
    nodeList[i] = newNode;
  }
  /*cout << "Printing graph" << endl;
  for (int i = 0;  i < n; ++i) {
    cout << nodeList[i]->n << ": ";
    for (int j = 0; j < nodeList[i]->numnbrs; ++j) {
      //cout << nodeList[i]->nbrs[j]->n << " ";
    }
    cout << endl;
  }*/
}

int main() {
  int NUM_RUNS = 10;
  cout << "[DENSE]" << endl;
  for (int size = 1000; size <= 10000; size += 200) {
	GraphNode* nodes = new GraphNode[size];
    for (int i = 0; i < size; ++i) {
      nodes[i].n = i;
    }
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
    cout << numedges << "," << (double) (end - start) / NUM_RUNS << "," << endl;
  }
  NUM_RUNS = 100;
  cout << "[SPARSE]" << endl;
  for (int size = 1000; size <= 10000; size += 200) {
    GraphNode* nodes = new GraphNode[size];
    for (int i = 0; i < size; ++i) {
      nodes[i].n = i;
    }
    GraphNode** nodeList = new GraphNode*[size];
    genSparseGraph(size, 500, nodeList, nodes);
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
    long numedges = size * 500;
    cout << numedges << "," << (double) (end - start) / NUM_RUNS << "," << endl;
  }

}
