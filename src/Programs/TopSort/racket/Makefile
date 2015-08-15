all:
	raco exe TopSortMutableSpeedTest.ss
	raco exe TopSortSpeedTest.ss
clean:
	rm -f TopSortMutableSpeedTest
	rm -f TopSortSpeedTest
	rm -rf compiled
data:
	./TopSortSpeedTest > topsortdata.csv
	./TopSortMutableSpeedTest > topsortmutabledata.csv
