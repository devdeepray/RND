#ifndef _FULL_ADDER_H_
#define _FULL_ADDER_H_

#include <andgate.h>
#include <orgate.h>
#include <xorgate.h>
#include <defs.h>
class FullAdder {
	AndGate andgate1, andgate2;
	OrGate orgate;
	XorGate xorgate1, xorgate2;
	Terminal w1, w2, w3;
public:
	void init(Terminal* sum, Terminal* carry, Terminal* A, Terminal* B, Terminal* C);
};

#endif //_FULL_ADDER_H_
