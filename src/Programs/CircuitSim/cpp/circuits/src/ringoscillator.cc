#include <ringoscillator.h>

RingOscillator::RingOscillator() {
	g1.connect(g2.input());
	g2.connect(g3.input());
	g3.connect(g1.input());
}

void RingOscillator::connect(InputTerminal input) {
	g1.connect(input);
}

InputTerminal RingOscillator::input() {
	return g1.input();
}
