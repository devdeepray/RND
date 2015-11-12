#include <ringoscillator.h>

void RingOscillator::init(Terminal* w3) {
	g1.init(w1, w2);
	g2.init(w2, w3);
	g3.init(w3, w1);

}
