speedtest: ../../../Infrastructure/SpeedTest.hs TopSort.hs TopSortSpeedTest.hs
	ghc -O3 ../../../Infrastructure/SpeedTest.hs TopSortSpeedTest.hs
clean:
	rm TopSortSpeedTest *.o *.hi
data:	
	./TopSortSpeedTest > times.csv
	
