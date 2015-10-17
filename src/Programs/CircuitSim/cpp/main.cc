#include <component.h>
#include <andgate.h>
#include <defs.h>
#include <queue>
#include <vector>
#include <iostream>
using namespace std;

int main() {
	AndGate g1, g2, g3;
	g1.connect(g3.input1());
	g2.connect(g3.input2());
	priority_queue<Event> pq;

	pq.push(Event(g1.input1(), 0, true));
	pq.push(Event(g1.input2(), 0.3, true));
	pq.push(Event(g2.input1(), 0.1, true));
	pq.push(Event(g2.input2(), 0.5, true));

	while(!pq.empty()) {
		Event ev = pq.top();
		pq.pop();
		cout << "Time: " << ev.timestamp << " Terminal: " << ev.affected_input.input_index << " New value " << ev.new_val << endl;
		vector<Event> newevents = ev.affected_input.component->trigger_change(ev.affected_input.input_index, ev.new_val, ev.timestamp);
		for (auto event : newevents) {
			pq.push(event);
		}
	}
}
