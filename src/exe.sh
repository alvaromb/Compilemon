gcc -c stdio.s
gcc -c prueba$1.lem.s
gcc stdio.o prueba$1.lem.o -o prueba

./prueba
