#include <fulladder.h>

FullAdder::FullAdder() {

	input1joiner.connect(xorgate1.input1());
	input2joiner.connect(xorgate1.input2());
	xorgate1.connect(xorgate2.input1());
	carryjoiner.connect(xorgate2.input2());
	carryjoiner.connect(andgate1.input1());
	xorgate1.connect(andgate1.input2());
	input1joiner.connect(andgate2.input1());
	input2joiner.connect(andgate2.input2());
	andgate2.connect(orgate.input1());
	andgate2.connect(orgate.input2());
}

void FullAdder::connect_s(InputTerminal input) {
	xorgate2.connect(input);
}

void FullAdder::connect_c(InputTerminal input) {
	orgate.connect(input);
}

InputTerminal FullAdder::input1() {
	return input1joiner.input();
}

InputTerminal FullAdder::input2() {
	return input2joiner.input();
}

InputTerminal FullAdder::carryinput() {
	return carryjoiner.input();
}
	
