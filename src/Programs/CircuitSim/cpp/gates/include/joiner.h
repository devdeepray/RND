#ifndef _JOINER_H_
#define _JOINER_H_

#include <component.h>
#include <defs.h>
#include <vector>
#include <iostream>
using namespace std;

class Joiner : private Component {
public:
	Joiner();
  InputTerminal input();
  using Component::connect;
  void connect(InputTerminal input_terminal);
  using Component::get_output;
  vector<bool> get_output(vector<bool> input);
};


#endif // _JOINER_H_
