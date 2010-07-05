gcc -m32 -c stdio.s -o stdio.o
gcc -m32 -c prova$1.lem.s
gcc -m32 stdio.o prova$1.lem.o -o prova

./prova