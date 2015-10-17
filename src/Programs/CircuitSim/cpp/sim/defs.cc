#include <defs.h>

Event::Event(InputTerminal _affected_input, float _timestamp, bool _new_val) {
	affected_input = _affected_input;
	timestamp = _timestamp;
	new_val = _new_val;
}

Event::Event() {
}

bool Event::operator<(const Event &e2) const {
	return timestamp > e2.timestamp;
}

InputTerminal::InputTerminal(Component* _component, int _input_index) {
	component = _component;
	input_index = _input_index;
}

InputTerminal::InputTerminal() {
}
