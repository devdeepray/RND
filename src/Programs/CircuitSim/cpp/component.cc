#include <map>
#include <iostream>
#include <queue>
#include <list>
#include "defs.h"
#include "component.h"
using namespace std;

list<Event> Component::trigger_change(string input_id, bool val, float cur_time) {
	auto old_output = get_output(input_state);
	if (input_state[input_id] == val) return list<Event>();
	input_state[input_id] = val;
	auto new_output = get_output(input_state);

	list<Event> newEvents;
	for (auto &op : old_output) {
		if (op.second != new_output[op.first]) {
			for (auto &conn : output_connections[op.first]) {
				newEvents.push_back(Event(conn, cur_time + delay, new_output[op.first]));
			}
		}
	}

	return newEvents;
}

void Component::connect(string output_name, Component* component, string input_name) {
	output_connections[output_name];
	output_connections[output_name].push_back(InputTerminal(component, input_name));
}

map<string, bool> Component::get_output(map<string, bool> input) {
	return map<string, bool>();
}
