SAMPLES = samples/testbasic.cc samples/ring.cc
EXE_OBJS = $(patsubst samples/%.cc, exe/%.out, $(SAMPLES))

build: $(EXE_OBJS)

exe/%.out: samples/%.cc
	g++ -std=c++0x -I circuits/include -I sim -o $@ circuits/src/*.cc sim/*.cc $^

clean:
	rm exe/*;
