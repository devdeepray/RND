all:
	raco exe TopSortSpeedTest.ss
	mv TopSortSpeedTest TopSortSpeedTest.exe
clean:
	rm -f TopSortSpeedTest.exe
	rm -rf compiled
data:
	./TopSortSpeedTest.exe > topsortdata.csv
