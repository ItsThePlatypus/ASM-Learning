command: command.o
	gcc -o command command.o -no-pie
command.o: command.asm
	nasm -f elf64 -g -F dwarf command.asm -l command.lst