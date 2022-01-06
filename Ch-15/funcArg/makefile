funcArgs: funcArgs.o
	gcc -o funcArgs funcArgs.o -no-pie
funcArgs.o: funcArgs.asm
	nasm -f elf64 -g -F dwarf funcArgs.asm -l funcArgs.lst