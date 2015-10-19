#include <component.h>
#include <andgate.h>
#include <probe.h>
#include <notgate.h>
#include <defs.h>
#include <ringoscillator.h>
#include <simulator.h>
#include <queue>
#include <vector>
#include <iostream>
using namespace std;

int main() {
	Probe probe;
	RingOscillator osc;
	osc.connect(probe.input());
	vector<InputTerminal> inputs;
	inputs.push_back(osc.input());
	vector<Event> events;

	Simulator sim(inputs);
	sim.simulate(events, 30);
	for (auto v : probe.get_probe_data()) {
		cout << v.first << " " << v.second << endl;
	}
}
