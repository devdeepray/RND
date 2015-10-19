#include <defs.h>
#include <component.h>
#include <iostream>
#include <queue>
#include <vector>
using namespace std;

class Simulator {
	priority_queue<Event> pq;
public:
	Simulator(vector<InputTerminal> inputs);
	void simulate(vector<Event> events, float max_t);
};
