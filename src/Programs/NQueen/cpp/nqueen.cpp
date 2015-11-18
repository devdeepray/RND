#include <iostream>
#include <vector>
#include <cmath>
#include <sys/time.h>
using namespace std;

double getCurrentTime() {
  struct timeval tp;
  gettimeofday(&tp, NULL);
  double ms = tp.tv_sec * 1000.0 + tp.tv_usec / 1000.0;
  return ms;
}


bool validAddition(vector<int> &sol, int newpos) {
  int oldsize = sol.size();
  for (int i = 0; i < oldsize; ++i) {
    if (newpos == sol[i]) { // Same column
      return false;
    }
    if (abs(newpos - sol[i]) == (oldsize - i)) { // Same diag
      return false;
    }
  }
  return true;
}

void genSolutions(vector<int> &currentSol, int n, int &numsols, int maxn) {
  if (n == 0) {
    // Found solution 
    numsols++;
  }

  for (int i = 0; i < maxn; ++i) {
    if (validAddition(currentSol, i)) {
      currentSol.push_back(i);
      genSolutions(currentSol, n - 1, numsols, maxn);
      currentSol.pop_back();
    }
  }
}

int countNQueen(int n) {
  int count = 0;
  vector<int> sol;
  genSolutions(sol, n, count, n);
  return count;
}

int main() {
  for (int i = 4; i <= 14; ++i) {
    double start = getCurrentTime();
    countNQueen(i);
    double end = getCurrentTime();
    cout << i << ", " << log(end - start) << endl;
  }
}

 
