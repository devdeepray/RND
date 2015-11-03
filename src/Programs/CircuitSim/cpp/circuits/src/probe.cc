#include <probe.h>

void Probe::init(Terminal* terminal) {
  Component::init(NULL, vector<Terminal*>(1, terminal));
}

vector<Event> Probe::trigger_change(int input_index, bool val, float cur_time) {
	cout << "Probe trigger" << endl;
	probe_data.push_back(pair<float, bool>(cur_time, val));
	return vector<Event>();
}

vector<pair<float, bool> > Probe::get_probe_data() {
	return probe_data;
}

void clear_probe() {
  probe_data.clear();
}
