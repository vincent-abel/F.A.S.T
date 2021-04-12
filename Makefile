###########################
# Created by Vincent ABEL #
###########################
CC=gdc -g
#CFLAGS=-W -Wall -pedantic
LDFLAGS=
EXEC=fast
SRC= $(wildcard *.d)
OBJ= $(SRC:.d=.o)

all: $(EXEC) clean

fast: $(OBJ)
	$(CC) -o $@ $^ $(LDFLAGS)

main.o: 

%.o: %.d
	$(CC) -o $@ -c $< $(CFLAGS)

.PHONY: clean mrproper

clean:
	rm -rf *.o
	rm -rf .*.swp

mrproper: clean
	rm -rf $(EXEC)
	rm -rf *~ 
