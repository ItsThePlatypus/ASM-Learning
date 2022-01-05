stackAlign: stackAlign.o
	gcc -o stackAlign stackAlign.o -no-pie
stackAlign.o: stackAlign.asm
	nasm -f elf64 -g -F dwarf stackAlign.asm -l stackAlign.lst