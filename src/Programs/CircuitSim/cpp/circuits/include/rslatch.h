#include <nandgate.h>
#include <joiner.h>
#include <defs.h>
class RSLatch {
	NandGate nand1, nand2;
public:
	RSLatch();
	void connect_q(InputTerminal input);
	void connect_qbar(InputTerminal input);
	InputTerminal input_r();
	InputTerminal input_s();
};

