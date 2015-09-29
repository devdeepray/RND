speedtest: ../../../Infrastructure/SpeedTest.hs Nqueen.hs nqspeedtest.hs
	ghc -O3 ../../../Infrastructure/SpeedTest.hs nqspeedtest.hs
speedtestunopt:  ../../../Infrastructure/SpeedTest.hs Nqueen.hs nqspeedtest.hs
	ghc ../../../Infrastructure/SpeedTest.hs nqspeedtest.hs	
clean:
	rm -f nqspeedtest *.o *.hi
	rm -f ../../../Infrastructure/*.o ../../../Infrastructure/*.hi
data:	
	./nqspeedtest > times.csv
	
