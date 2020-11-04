host=$(shell hostname)
ifeq ($(host),JurosComposto)
    LDFLAGS= -I$(RSFROOT)/include -L$(RSFROOT)/lib -lrsf++ -lrsf -lm -ltirpc -lfftw3f -lfftw3 -O3
endif
ifeq ($(host),marreca)
    LDFLAGS= -I$(RSFROOT)/include -L$(RSFROOT)/lib -lrsf++ -lrsf -lm -lfftw3f -lfftw3 -O3
endif


pad: verticalPad.cpp
	g++ verticalPad.cpp $(LDFLAGS) -o pad

run: pad
	./pad padding=50 <../testData/vel.rsf >velPadded.rsf
	sfimage padding=50 <velPadded.rsf
