#include <probe.h>

Probe::Probe() : Component(1, 0) {
}

InputTerminal Probe::input() {
  return get_input_terminal(0);
}

vector<Event> Probe::trigger_change(int input_index, bool val, float cur_time) {
	cout << "Probe trigger" << endl;
	probe_data.push_back(pair<float, bool>(cur_time, val));
	return vector<Event>();
}

vector<pair<float, bool> > Probe::get_probe_data() {
	return probe_data;
}
