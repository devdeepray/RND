#include <twoinput.h>

void TwoInput::init(Terminal* output, Terminal* input1, Terminal* input2) {
	vector<Terminal*> tmp;
	tmp.push_back(input1);
	tmp.push_back(input2);
	Component::init(output, tmp);
}

bool TwoInput::get_output(vector<bool> input) {
  return get_output(input[0], input[1]);
}

bool TwoInput::get_output(bool val1, bool val2) {
  cerr << "Need to override get_output(bool, bool) from TwoInput" << endl;
  return false;
}
