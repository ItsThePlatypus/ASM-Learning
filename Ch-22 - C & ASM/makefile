main: main.c rect.o circ.o reverse.o sum.o double.o
	gcc -o main main.c rect.o circ.o reverse.o sum.o double.o -no-pie
rect.o: rect.asm
	nasm -f elf64 -g -F dwarf rect.asm -l rect.lst
circ.o: circ.asm
	nasm -f elf64 -g -F dwarf circ.asm -l circ.lst
reverse.o: reverse.asm
	nasm -f elf64 -g -F dwarf reverse.asm -l reverse.lst
sum.o: sum.asm
	nasm -f elf64 -g -F dwarf sum.asm -l sum.lst
double.o: double.asm
	nasm -f elf64 -g -F dwarf double.asm -l double.lst