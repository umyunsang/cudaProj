test.exe: main.o test1.o test2.o
	gcc -o test.exe main.o test1.o test2.o

main.o: main.c test.h
	gcc -c main.c

test1.o: test1.c test.h
	gcc -c test1.c

test2.o: test2.c test.h
	gcc -c test2.c

