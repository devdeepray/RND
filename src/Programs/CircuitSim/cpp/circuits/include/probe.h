#ifndef _PROBE_H_
#define _PROBE_H_

#include <component.h>
#include <defs.h>
#include <vector>
#include <iostream>
using namespace std;

class Probe : private Component {
	vector<pair<float, bool> > probe_data;
public:
	void init(Terminal* terminal);
  vector<Event> trigger_change(int input_index, bool val, float cur_time);
	vector<pair<float, bool> > get_probe_data();
	void clear_probe();
};


#endif // _PROBE_H_
