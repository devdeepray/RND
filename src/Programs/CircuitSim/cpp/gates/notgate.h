#ifndef _NOTGATE_H_
#define _NOTGATE_H_

#include <component.h>
#include <defs.h>
#include <vector>
#include <iostream>
using namespace std;

class NotGate : private Component {
public:
	NotGate();
  InputTerminal input();
  using Component::connect;
  void connect(InputTerminal input_terminal);
  using Component::get_output;
  vector<bool> get_output(vector<bool> input);
};


#endif // _NOTGATE_H_
