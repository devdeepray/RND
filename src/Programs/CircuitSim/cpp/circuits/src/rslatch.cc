#include <halfadder.h>

void RSLatch::init(Terminal* Q, Terminal* Qb, Terminal* R, Terminal* S) {
	nand1.init(Q, S, Qb);
	nand2.init(Qb, R, Q);
}
