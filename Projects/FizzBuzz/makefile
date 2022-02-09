fizz: fizz.o
	gcc -o fizz fizz.o -no-pie
fizz.o: fizz.asm
	nasm -f elf64 -g -F dwarf fizz.asm -l fizz.lst