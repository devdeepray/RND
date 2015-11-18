#include <iostream>
#include <vector>
#include <cmath>
#include <queue>
#include <sys/time.h>
#include <pthread.h>

using namespace std;

double getCurrentTime() {
  struct timeval tp;
  gettimeofday(&tp, NULL);
  double ms = tp.tv_sec * 1000 + tp.tv_usec / 1000.0;
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

struct thread_info {
  int count;
  int start;
  int n;
};

void* countThread(void* vtinfo) {
  thread_info* tinfo = (thread_info*) vtinfo;
  int &count = tinfo->count;
  int start = tinfo->start;
  int n = tinfo->n;
  count = 0;
  vector<int> sol;
  queue<int> pos;
  sol.push_back(start);
  for (int i = 0; i < n; ++i) {
    if (i != start) {
      pos.push(i);
    }
  }
  genSolutions(sol, count, pos);
}


int countNQueen(int n) {

  pthread_t *threads = new pthread_t[n];
  thread_info *tinfo = new thread_info[n];
  pthread_attr_t attr;
  pthread_attr_init(&attr);
  pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

  for (int i = 0; i < n; ++i) {
    tinfo[i].start = i;
    tinfo[i].n = n;
    int rc = pthread_create(&threads[i], NULL, countThread, (void*)&tinfo[i]);
    if (rc) {
      cout << "Fatal error" << endl;
      pthread_exit(NULL);
    }
  }
  pthread_attr_destroy(&attr);
  for (int i = 0; i < n; ++i) {
    void* status;
    int rc = pthread_join (threads[i], &status);
    if (rc) {
      cout << "Unable to join" << endl;
      pthread_exit(NULL);
    }
  }
  int count = 0;
  for (int i = 0; i < n; ++i) {
    count += tinfo[i].count;
  }
  delete[] threads;
  delete[] tinfo;
  return count;
}

int main() {
  for (int i = 4; i <= 15; ++i) {
    double start = getCurrentTime();
    countNQueen(i);
    double end = getCurrentTime();
    cout << i << ", " << log(end - start) << endl;
  }
}

 
