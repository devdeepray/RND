#include <component.h>
#include <andgate.h>
#include <probe.h>
#include <notgate.h>
#include <defs.h>
#include <simulator.h>
#include <queue>
#include <vector>
#include <iostream>
using namespace std;

int main() {
	AndGate g1, g2, g3;
	NotGate g4, g5;
	Probe probe;
	g1.connect(g3.input1());
	g2.connect(g3.input2());
	g3.connect(g4.input());
	g4.connect(g5.input());
	g5.connect(probe.input());
	vector<InputTerminal> inputs;
	inputs.push_back(g1.input1());
 	inputs.push_back(g1.input2());
	inputs.push_back(g2.input1());
	inputs.push_back(g2.input2());
	vector<Event> events;
	events.push_back(Event(g1.input1(), 0, true));
	events.push_back(Event(g1.input2(), 0.3, true));
	events.push_back(Event(g2.input1(), 0.1, true));
	events.push_back(Event(g2.input2(), 0.5, true));

	Simulator sim(inputs);
	sim.simulate(events, 10);
	for (auto v : probe.get_probe_data()) {
		cout << v.first << " " << v.second << endl;
	}
}
