#include <component.h>

void Component::init(Terminal* output, vector<Terminal*> inputs) {
	m_input_state = vector<bool>(inputs.size(), false);
	for (int i = 0; i < inputs.size(); ++i) {
		inputs[i]->attach(InputTerminal(this, i));
	}
	m_output = output;
}

vector<Event> Component::trigger_change(int input_index, bool val, float cur_time) {

	m_input_state[input_index] = val;
	bool new_output = get_output(m_input_state);

	vector<Event> newEvents;

  if (m_output != NULL) {
		for (auto conn : m_output->connections()) {
			newEvents.push_back(Event(conn, cur_time + m_delay, new_output));
		}
	}

	return newEvents;
}

void Component::set_delay(float delay) {
	m_delay = delay;
}

bool Component::get_output(vector<bool> input) {
	return false;
}
