#include <andgate.h>
#include <orgate.h>
#include <xorgate.h>
#include <joiner.h>
#include <defs.h>
class FullAdder {
	AndGate andgate1, andgate2;
	OrGate orgate;
	XorGate xorgate1, xorgate2;
	Joiner input1joiner, input2joiner, carryjoiner;
public:
	FullAdder();
	void connect_s(InputTerminal input);
	void connect_c(InputTerminal input);
	InputTerminal input1();
	InputTerminal input2();
	InputTerminal carryinput();
};

