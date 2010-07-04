gcc -c -m32 stdio.s
gcc -c -m32 prueba$1.lem.s
gcc stdio.o prueba$1.lem.o -o prueba

./prueba
