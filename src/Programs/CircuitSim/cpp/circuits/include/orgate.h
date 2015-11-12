#ifndef _ORGATE_H_
#define _ORGATE_H_

#include <twoinput.h>

class OrGate : public TwoInput {
  bool get_output(bool val1, bool val2);
  using TwoInput::TwoInput;
};

#endif // _ORGATE_H_
