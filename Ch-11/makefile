floats: floats.o
	gcc -o floats floats.o -no-pie
floats.o: floats.asm
	nasm -f elf64 -g -F dwarf floats.asm -l floats.lst