#include <iostream>
#include <vector>
#include <cmath>
#include <queue>
#include <sys/time.h>
using namespace std;

long getCurrentTime() {
  struct timeval tp;
  gettimeofday(&tp, NULL);
  long int ms = tp.tv_sec * 1000 + tp.tv_usec / 1000;
  return ms;
}


bool validAddition(vector<int> &sol, int newpos) {
  int oldsize = sol.size();
  for (int i = 0; i < oldsize; ++i) {
    if (abs(newpos - sol[i]) == (oldsize - i)) { // Same diag
      return false;
    }
  }
  return true;
}

void genSolutions(vector<int> &currentSol, int &numsols, queue<int> &pos) {
  if (pos.size() == 0) {
    // Found solution 
    numsols++;
  }

  for (int i = 0; i < pos.size(); ++i) {
    int pn = pos.front();
    pos.pop();
    if (validAddition(currentSol, pn)) {
      currentSol.push_back(pn);
      genSolutions(currentSol, numsols, pos);
      currentSol.pop_back();
    }
    pos.push(pn);
  }
}

int countNQueen(int n) {
  int count = 0;
  vector<int> sol;
  queue<int> pos;
  for (int i = 0; i < n; ++i) {
    pos.push(i);
  }
  genSolutions(sol, count, pos);
  return count;
}

int main() {
  for (int i = 4; i <= 14; ++i) {
    long start = getCurrentTime();
    countNQueen(i);
    long end = getCurrentTime();
    cout << i << ", " << (end - start) << endl;
  }
}

 
