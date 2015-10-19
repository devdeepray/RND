#include <simulator.h>

void Simulator::simulate(vector<Event> events, float max_t) {
	for (auto event : events) {
		pq.push(event);
	}
	cerr << "starting simulation..." << endl;
	while (!pq.empty() || pq.top().timestamp > max_t) {
		Event ev = pq.top();
		cout << "ev: " << ev.affected_input.input_index << " " << ev.new_val << " " << ev.timestamp << endl;
		pq.pop();
		vector<Event> new_events = 
			ev.affected_input.component
			->trigger_change(ev.affected_input.input_index, 
					ev.new_val, 
					ev.timestamp);
		for (Event event : new_events) {
			pq.push(event);
		}
	}
	cerr << "simulation done..." << endl;
}

Simulator::Simulator(vector<InputTerminal> inputs) {
	for (auto input : inputs) {
		pq.push(Event(input, false, 0));
	}
}


