#include <probe.h>

Probe::Probe() : Component(1, 0) {
}

InputTerminal Probe::input() {
  return get_input_terminal(0);
}

vector<Event> Probe::trigger_change(int input_index, bool val, float cur_time) {
	probe_data.push_back(pair<bool, float>(val, cur_time));
	return vector<Event>();
}
