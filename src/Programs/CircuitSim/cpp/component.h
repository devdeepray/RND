#ifndef _COMPONENT_H_
#define _COMPONENT_H_

#include <map>
#include <iostream>
#include "defs.h"
#include <queue>
#include <list>
using namespace std;

struct InputTerminal;
struct Event;

class Component {
protected:
	float delay = 1;
  map <string, bool> input_state;
  map<string, vector<InputTerminal> > output_connections;

public:
  virtual map<string, bool> get_output(map<string, bool> input);

  list<Event> trigger_change(string input_id, bool val, float cur_time);

	void connect(string output_name, Component* component, string input_name);
};

#endif // _COMPONENT_H_
