#include <andgate.h>
#include <xorgate.h>
#include <joiner.h>
#include <defs.h>
class HalfAdder {
	AndGate andgate;
	XorGate xorgate;
	Joiner input1joiner;
	Joiner input2joiner;
public:
	HalfAdder();
	void connect_s(InputTerminal input);
	void connect_c(InputTerminal input);
	InputTerminal input1();
	InputTerminal input2();
};

