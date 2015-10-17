#ifndef _DEFS_H_
#define _DEFS_H_

#include <component.h>
#include <iostream>
using namespace std;

struct Component;

struct InputTerminal {
	Component* component;
	int input_index;

	InputTerminal(Component* _component, int _input_index);
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
