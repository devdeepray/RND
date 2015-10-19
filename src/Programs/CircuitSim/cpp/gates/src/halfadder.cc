#include <halfadder.h>

HalfAdder::HalfAdder() {
	input1joiner.connect(xorgate.input1());
	input1joiner.connect(andgate.input1());
	input2joiner.connect(xorgate.input2());
	input2joiner.connect(andgate.input2());
}

void HalfAdder::connect_s(InputTerminal input) {
	xorgate.connect(input);
}

void HalfAdder::connect_c(InputTerminal input) {
	andgate.connect(input);
}

InputTerminal HalfAdder::input1() {
	return input1joiner.input();
}

InputTerminal HalfAdder::input2() {
	return input2joiner.input();
}
	
