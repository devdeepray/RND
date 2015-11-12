#include <nandgate.h>
#include <joiner.h>
#include <defs.h>
class RSLatch {
	NandGate nand1, nand2;
public:
	void init(Terminal* Q, Terminal* Qb, Terminal* R, Terminal* S);
};
