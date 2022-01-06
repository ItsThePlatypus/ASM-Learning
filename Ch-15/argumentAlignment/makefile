align: align.o
	gcc -o align align.o -no-pie
align.o: align.asm
	nasm -f elf64 -g -F dwarf align.asm -l align.lst