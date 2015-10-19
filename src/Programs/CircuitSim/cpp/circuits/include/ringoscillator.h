#include <notgate.h>
#include <defs.h>

class RingOscillator {
	NotGate g1, g2, g3;
public:
	RingOscillator();
	void connect(InputTerminal input);
	InputTerminal input();
};
