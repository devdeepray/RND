unopt: speed_test.cc top_sort.cc
	g++ -std=c++0x -o TopSortSpeedTest.exe speed_test.cc top_sort.cc
opt: speed_test.cc top_sort.cc
	g++ -O3 -std=c++0x -o TopSortSpeedTest.exe speed_test.cc top_sort.cc
profunopt: speed_test.cc top_sort.cc
	g++ -O0 -pg -std=c++0x -o TopSortSpeedTest.exe speed_test.cc top_sort.cc
clean:
	rm TopSortSpeedTest.exe
