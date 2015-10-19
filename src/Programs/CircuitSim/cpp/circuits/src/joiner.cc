#include <joiner.h>

Joiner::Joiner() : Component(1, 1) {
	set_delay(0);
}

InputTerminal Joiner::input() {
  return get_input_terminal(0);
}

void Joiner::connect(InputTerminal input_terminal) {
  connect(0, input_terminal);
}

vector<bool> Joiner::get_output(vector<bool> input) {
  return vector<bool>(1, input[0]);
}
