#ifndef _ANDGATE_H_
#define _ANDGATE_H_

#include "component.h"
#include "defs.h"
#include <iostream>
#include <map>
using namespace std;

class AndGate : public Component {
	string input1, input2, output;
	public:
		AndGate(string _input1, string _input2, string _output, float delay);
		map<string, bool> get_output(map<string, bool> input);
};


#endif // _ANDGATE_H_
