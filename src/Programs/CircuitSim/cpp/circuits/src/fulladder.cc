#include <fulladder.h>

void FullAdder::init(Terminal* sum, Terminal* carry, Terminal* A, Terminal* B, Terminal* C) {
	andgate1.init(&w1, A, B);
	andgate2.init(&w2, C, &w3);
	orgate.init(carry, &w1, &w2);
	xorgate1.init(&w3, A, B);
	xorgate2.init(sum, &w3, carry);
}
