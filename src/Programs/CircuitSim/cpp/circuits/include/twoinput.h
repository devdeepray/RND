#ifndef _TWOINPUT_H_
#define _TWOINPUT_H_

#include <component.h>
#include <defs.h>
#include <vector>
#include <iostream>
using namespace std;

class TwoInput : private Component {
public:
  void init(Terminal* output, Terminal* input1, Terminal* input2);
  using Component::get_output;
  bool get_output(vector<bool> input);
protected:
  virtual bool get_output(bool val1, bool val2);
};
#endif // _TWOINPUT_H_
