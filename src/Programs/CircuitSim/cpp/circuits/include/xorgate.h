#ifndef _XORGATE_H_
#define _XORGATE_H_

#include <twoinput.h>

class XorGate : public TwoInput {
  bool get_output(bool val1, bool val2);
  using TwoInput::TwoInput;
};

#endif // _XORGATE_H_
