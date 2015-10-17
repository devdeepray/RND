#include <twoinput.h>

TwoInput::TwoInput() : Component(2, 1) {
}

InputTerminal TwoInput::input1() {
  return get_input_terminal(0);
}

InputTerminal TwoInput::input2() {
  return get_input_terminal(1);
}

void TwoInput::connect(InputTerminal input_terminal) {
  connect(0, input_terminal);
}

vector<bool> TwoInput::get_output(vector<bool> input) {
  return vector<bool>(1, get_output(input[0], input[1]));
}

bool TwoInput::get_output(bool val1, bool val2) {
  cerr << "Need to override get_output(bool, bool) from TwoInput" << endl;
  return false;
}
