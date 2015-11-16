.PHONY: unopt opt clean profunopt
unopt:
	g++ -std=c++0x -o TopSortSpeedTest.exe speed_test.cc top_sort.cc
opt:
	g++ -O3 -std=c++0x -o TopSortSpeedTest.exe speed_test.cc top_sort.cc
profunopt:
	g++ -O0 -pg -std=c++0x -o TopSortSpeedTest.exe speed_test.cc top_sort.cc
clean:
	rm TopSortSpeedTest.exe
