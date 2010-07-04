gcc -m32 -c stdio.s -o stdio.o
gcc -m32 -c prueba$1.lem.s
gcc -m32 stdio.o prueba$1.lem.o -o prueba

./prueba