#include <notgate.h>

NotGate::NotGate() : Component(1, 1) {
}

InputTerminal NotGate::input() {
  return get_input_terminal(0);
}

void NotGate::connect(InputTerminal input_terminal) {
  connect(0, input_terminal);
}

vector<bool> NotGate::get_output(vector<bool> input) {
  return vector<bool>(1, !input[0]);
}
