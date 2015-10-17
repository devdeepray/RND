#ifndef _COMPONENT_H_
#define _COMPONENT_H_

#include <vector>
#include <iostream>
#include <defs.h>
using namespace std;

struct InputTerminal;
struct Event;

class Component {
protected:
	float m_delay = 1;
  vector<bool> m_input_state;
  vector<vector<InputTerminal> > m_output_connections;

	Component(int num_inputs, int num_outputs);

public:
  virtual vector<bool> get_output(vector<bool> input);

  vector<Event> trigger_change(int input_index, bool val, float cur_time);

	void connect(int output_index, InputTerminal input_terminal);

	void set_delay(float delay);

	InputTerminal get_input_terminal(int input_index);
};

#endif // _COMPONENT_H_
