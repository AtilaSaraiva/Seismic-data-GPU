host=$(shell hostname)
ifeq ($(host),JurosComposto)
    LDFLAGS= -I$(RSFROOT)/include -L$(RSFROOT)/lib -lrsf++ -lrsf -lm -ltirpc -lfftw3f -lfftw3 -O3
endif
ifeq ($(host),marreca)
    LDFLAGS= -I$(RSFROOT)/include -L$(RSFROOT)/lib -lrsf++ -lrsf -lm -lfftw3f -lfftw3 -O3
endif

CULIBS= -L /opt/cuda/lib -I /opt/cuda/include -lcudart -lcuda -lstdc++ -lcufft

dFold=testData
data=seismicData.rsf
OD=directwave.rsf
comOD=seismicDataWithDirectWave.rsf
vel=vel.rsf


mod: main.cu cuwaveprop2d.cu cudaKernels.cu
	nvcc main.cu $(LDFLAGS) -o mod

run: mod
	#./mod nr=400 nshots=2 incShots=100 isrc=0 jsrc=200 gxbeg=0 vel=$(dFold)/$(vel) data=$(dFold)/$(data) OD=$(dFold)/$(OD) comOD=$(dFold)/$(comOD)
	#./mod nr=300 nshots=1 incShots=100 incRec=100 isrc=0 jsrc=150 gxbeg=0 vel=$(dFold)/$(vel) data=$(dFold)/$(data) OD=$(dFold)/$(OD) comOD=$(dFold)/$(comOD)
	./mod nr=368 nshots=1 incShots=60 incRec=0 isrc=0 jsrc=100 gxbeg=0 vel=$(dFold)/$(vel) data=$(dFold)/$(data) OD=$(dFold)/$(OD) comOD=$(dFold)/$(comOD)

	#sfimage <$(dFold)/$(data)
	sfgrey <$(dFold)/$(data) | sfpen &
	#ximage n1=780 <snap/snap_u3_s0_0_780_980 &
	#ximage n1=780 <snap/snap_u3_s1_0_780_980 &

profile: mod
	nvprof ./mod nr=400 nshots=2 incShots=100 isrc=0 jsrc=200 gxbeg=0 vel=$(dFold)/$(vel) data=$(dFold)/$(data) OD=$(dFold)/$(OD) comOD=$(dFold)/$(comOD)
