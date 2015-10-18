#include "component.h"
#include "andgate.h"
#include "defs.h"
#include <queue>
#include <map>
#include <iostream>
using namespace std;

int main() {
	AndGate g1("g1i1", "g1i2", "g1o", 1.5), 
					g2("g2i1", "g2i2", "g2o", 1.1), 
					g3("g3i1", "g3i2", "g3o", 1.7);
	g1.connect("g1o", &g3, "g3i1");
	g2.connect("g2o", &g3, "g3i2");
	priority_queue<Event> pq;

	pq.push(Event(InputTerminal(&g1, "g1i1"), 0, true));
	pq.push(Event(InputTerminal(&g1, "g1i2"), 0, true));
	pq.push(Event(InputTerminal(&g2, "g2i1"), 0, true));
	pq.push(Event(InputTerminal(&g2, "g2i2"), 0, true));

	while(!pq.empty()) {
		Event ev = pq.top();
		pq.pop();
		cout << "Time: " << ev.timestamp << " Terminal: " << ev.affected_input.input_id << " New value " << ev.new_val << endl;
		list<Event> newevents = ev.affected_input.component->trigger_change(ev.affected_input.input_id, ev.new_val, ev.timestamp);
		for (auto event : newevents) {
			pq.push(event);
		}
	}
}


