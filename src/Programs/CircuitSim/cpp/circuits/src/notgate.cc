#include <notgate.h>

NotGate::NotGate(Terminal* output, Terminal* input) {
  init(output, vector<Terminal*>(1, input));
}

bool NotGate::get_output(vector<bool> input) {
  return !input[0];
}
