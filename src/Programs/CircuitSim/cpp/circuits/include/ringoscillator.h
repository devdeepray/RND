#ifndef _RINGOSCILLATOR_H_
#define _RINGOSCILLATOR_H_

#include <notgate.h>
#include <defs.h>

class RingOscillator {
	NotGate g1, g2, g3;
public:
	RingOscillator();
	void connect(InputTerminal input);
	InputTerminal input();
};

#endif // _RINGOSCILLATOR_H_
