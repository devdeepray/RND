speedtest: ../../../Infrastructure/SpeedTest.hs TopSort.hs TopSortSpeedTest.hs
	ghc -XFlexibleContexts -O3 ../../../Infrastructure/SpeedTest.hs TopSortSpeedTest.hs
speedtestunopt:  ../../../Infrastructure/SpeedTest.hs TopSort.hs TopSortSpeedTest.hs
	ghc -XFlexibleContexts ../../../Infrastructure/SpeedTest.hs TopSortSpeedTest.hs	
prof: ../../../Infrastructure/SpeedTest.hs TopSort.hs TopSortSpeedTest.hs
	ghc -O3 -XFlexibleContexts -prof -fprof-auto -rtsopts ../../../Infrastructure/SpeedTest.hs ./TopSortSpeedTest.hs
clean:
	rm -f TopSortSpeedTest *.o *.hi
	rm -f ../../../Infrastructure/*.o ../../../Infrastructure/*.hi
data:	
	./TopSortSpeedTest > times.csv
	
