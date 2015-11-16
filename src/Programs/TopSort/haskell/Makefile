speedtest: ../../../Infrastructure/SpeedTest.hs TopSort.hs TopSortSpeedTest.hs
	ghc -XFlexibleContexts -O3 ../../../Infrastructure/SpeedTest.hs TopSortSpeedTest.hs -o TopSortSpeedTest.exe
speedtestunopt:  ../../../Infrastructure/SpeedTest.hs TopSort.hs TopSortSpeedTest.hs
	ghc -XFlexibleContexts ../../../Infrastructure/SpeedTest.hs TopSortSpeedTest.hs	-o TopSortSpeedTest.exe
prof: ../../../Infrastructure/SpeedTest.hs TopSort.hs TopSortSpeedTest.hs
	ghc -O3 -XFlexibleContexts -prof -fprof-auto -rtsopts ../../../Infrastructure/SpeedTest.hs ./TopSortSpeedTest.hs -o TopSortSpeedTest.exe
clean:
	rm -f TopSortSpeedTest.exe *.o *.hi
	rm -f ../../../Infrastructure/*.o ../../../Infrastructure/*.hi
data:	
	./TopSortSpeedTest.exe > times.csv
	
