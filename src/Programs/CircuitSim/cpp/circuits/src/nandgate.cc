#include <nandgate.h>

bool NandGate::get_output(bool val1, bool val2) {
  return !(val1 && val2);
}
