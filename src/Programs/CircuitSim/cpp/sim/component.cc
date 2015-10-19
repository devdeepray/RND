#include <map>
#include <iostream>
#include <queue>
#include <list>
#include <defs.h>
#include <component.h>
using namespace std;

Component::Component(int num_inputs, int num_outputs) {
	m_input_state = vector<bool>(num_inputs, false);
	m_output_connections = vector<vector<InputTerminal> >(num_outputs);
}

vector<Event> Component::trigger_change(int input_index, bool val, float cur_time) {
	cerr << "Component trigger" << endl;
	auto old_output = get_output(m_input_state);
	m_input_state[input_index] = val;
	auto new_output = get_output(m_input_state);

	vector<Event> newEvents;

	for (int op_index = 0; op_index < old_output.size(); ++op_index) {
		//if (old_output[op_index] != new_output[op_index]) {
			for (auto conn : m_output_connections[op_index]) {
				newEvents.push_back(Event(conn, cur_time + m_delay, new_output[op_index]));
			}
		//}
	}

	return newEvents;
}

void Component::connect(int output_index, InputTerminal input_terminal) {
	m_output_connections[output_index].push_back(input_terminal);
}

void Component::set_delay(float delay) {
	m_delay = delay;
}

vector<bool> Component::get_output(vector<bool> input) {
	return vector<bool>();
}

InputTerminal Component::get_input_terminal(int input_index) {
	return InputTerminal(this, input_index);
}
