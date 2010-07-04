gcc -c stdio_llemuza.s
gcc -c prueba$1.lem.s
gcc stdio_llemuza.o prueba$1.lem.o -o prueba

./prueba
