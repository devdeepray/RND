#include <vector>
#include <iostream>
#include <sys/time.h>
using namespace std;
/**
 * Get the current time from epoch in ms.
 */
long getCurrentTimeUS() {
  struct timeval tp;
  gettimeofday(&tp, NULL);
  long int us = tp.tv_sec * 1000000 + tp.tv_usec;
  return us;
}

struct tmp {
  int x;
  int y;
  int z;
};

int main() {

  // Test for array on the stack
  int arr[2048]; // fits in cache on AMD FX6300
  for (int n = 0; n < 1000; ++n) {
  for (int i = 0; i < 2048; ++i) {
    arr[i] = i; // FOrce into cache.
  }
  }
  // Test case 1: basic iteration idiom with for loop
  long total_time = 0;
  for (int c = 0; c < 100; ++c) {
    int k = 0;
    total_time -= getCurrentTimeUS();
    for (int i = 0; i < 2048; ++i) {
      arr[i] = k;
      ++k;
    }
    total_time += getCurrentTimeUS();
  }
  cout << "Case 1: " << total_time << endl;

  // Test case 2: iteration with pointer
  total_time = 0;
  for (int c = 0; c < 100; ++c) {
    int *ptr;
    int *lim = arr + 2048;
    int k = 0;
    total_time -= getCurrentTimeUS();
    for (int *ptr = arr; ptr < lim; ++ptr) {
      *ptr = k;
      ++k;
    }
    total_time += getCurrentTimeUS();
  }
  cout << "Case 2: " << total_time << endl;

  // Test case 3: iteration on vector
  vector<int> varr(2048);
  for (int n = 0; n < 1000; ++n) {
  for (int i = 0; i < 2048; ++i) {
    varr[i] = i; // FOrce into cache.
  }
  }

  total_time = 0;
  for (int c = 0; c < 100; ++c) {
    int k = 0;
    total_time -= getCurrentTimeUS();
    for (int i = 0; i < 2048; ++i) {
      varr[i] = k;
      ++k;
    }
    total_time += getCurrentTimeUS();
  }
  cout << "Case 3: " << total_time << endl;
  
  // Test case 4: iteration on vector with auto variable
  total_time = 0;
  for (int c = 0; c < 100; ++c) {
    total_time -= getCurrentTimeUS();
    int k = 0;
    for (auto &it : varr) {
      it = k;
      ++k;
    }
    total_time += getCurrentTimeUS();
  }
  cout << "Case 4: " << total_time << endl;

  long sum = 0;
  for (int i = 0; i < 2048; ++i) {
    sum += arr[i];
  }
  cout << sum << endl;
}
