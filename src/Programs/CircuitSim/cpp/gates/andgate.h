#ifndef _ANDGATE_H_
#define _ANDGATE_H_

#include <twoinput.h>

class AndGate : public TwoInput {
  bool get_output(bool val1, bool val2);
};

#endif // _ANDGATE_H_
