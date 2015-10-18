#include "andgate.h"
#include <map>
#include <iostream>
using namespace std;

AndGate::AndGate(string _input1, string _input2, string _output, float _delay) {
	input1 = _input1;
	input2 = _input2;
	output = _output;
	input_state[_input1] = false;
	input_state[_input2] = false;
	output_connections[_output];
	delay = _delay;
}

map<string, bool> AndGate::get_output(map<string, bool> input) {
	map<string, bool> op;
	op[output] = input[input1] && input[input2];
	return op;
}
	
