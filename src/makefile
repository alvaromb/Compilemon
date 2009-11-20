#MAKEFILE DE COMPILADORES, v1.0

#VARIABLES:
CC = gnatmake
CH = gnatchop

#FUNCIÓN PRINCIPAL:
all	:	$(CH) -w *.a
		$(CC) compilemon.adb -largs -L/Developer/SDKs/MacOSX10.5.sdk/usr/lib -mmacosx-version-min=10.5.0 -shared-libgcc


clean: 
	rm *.o *.ali ./compilemon u_lexica.adb u_lexica.ads compilemon_* *.a ./aflex
