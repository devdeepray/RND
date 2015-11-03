#ifndef _RINGOSCILLATOR_H_
#define _RINGOSCILLATOR_H_

#include <notgate.h>
#include <defs.h>

class RingOscillator {
	NotGate g1, g2, g3;
	Terminal w1, w2;
public:
	void init(Terminal* w3);
};

#endif // _RINGOSCILLATOR_H_
