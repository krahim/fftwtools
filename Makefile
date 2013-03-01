HEADERS = fft.h
SOURCES = fft.c

OBJS = $(SOURCES:.c=.o)
FOBJS = $(FSOURCES:.f=.o)
LIBS = -lfftw3
FLAGS = -O2 -funroll-loops -fPIC 
WARNINGS = -Wall
SHOBJ = fft.so
#SHOBJ = dpss1.dll 

all: $(OBJS) 
	gcc --shared $(OBJS) -o $(SHOBJ) $(LIBS) 
	cp $(SHOBJ) ~/RLibs

.c.o: $(SOURCES) $(HEADERS)
	gcc  $(WARNINGS) $(FLAGS) -c $(SOURCES)

clean:
	rm $(SHOBJ) *.o