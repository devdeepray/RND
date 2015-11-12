#ifndef _COMPONENT_H_
#define _COMPONENT_H_

#include <vector>
#include <iostream>
#include <defs.h>
using namespace std;

struct InputTerminal;
struct Event;
struct Terminal;

class Component {

protected:
	float m_delay = 1;
  vector<bool> m_input_state;
  Terminal *m_output;
public:
	virtual void init(Terminal* output, vector<Terminal*> inputs);

  virtual bool get_output(vector<bool> input);

  virtual vector<Event> trigger_change(int input_index, bool val, float cur_time);

	void set_delay(float delay);
};

#endif // _COMPONENT_H_
