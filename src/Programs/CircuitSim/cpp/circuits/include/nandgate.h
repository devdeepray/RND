#ifndef _NANDGATE_H_
#define _NANDGATE_H_

#include <twoinput.h>

class NandGate : public TwoInput {
  bool get_output(bool val1, bool val2);
};

#endif // _NANDGATE_H_
