gcc -c stdio.s
gcc -c prueba3.lem.s
gcc stdio.o prueba3.lem.o -o prueba

./prueba
