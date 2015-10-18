#ifndef _DEFS_H_
#define _DEFS_H_

#include "component.h"
#include <iostream>
using namespace std;

struct Component;

struct InputTerminal {
	Component* component;
	string input_id;
	
	InputTerminal(Component* _component, string _input_id);
	InputTerminal();
};

struct Event {
	float timestamp;
	InputTerminal affected_input;
	bool new_val;

	Event(InputTerminal _affected_input, float _timestamp, bool _new_val);
	Event();

	bool operator<(const Event &e2) const;
};
#endif
