#ifndef _TWOINPUT_H_
#define _TWOINPUT_H_

#include <component.h>
#include <defs.h>
#include <vector>
#include <iostream>
using namespace std;

class TwoInput : private Component {
protected:
  TwoInput();
public:
  InputTerminal input1();
  InputTerminal input2();
  using Component::connect;
  void connect(InputTerminal input_terminal);
  using Component::get_output;
  vector<bool> get_output(vector<bool> input);
  virtual bool get_output(bool val1, bool val2);
};


#endif // _TWOINPUT_H_
