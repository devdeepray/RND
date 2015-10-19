#include <halfadder.h>

RSLatch::RSLatch() {
	nand1.connect(nand2.input1());
	nand2.connect(nand1.input1());
}

void RSLatch::connect_q(InputTerminal input) {
	nand1.connect(input);
}

void RSLatch::connect_qbar(InputTerminal input) {
	nand2.connect(input);
}

InputTerminal RSLatch::input_r() {
	return nand2.input2();
}

InputTerminal RSLatch::input_s() {
	return nand1.input1();
}
	
