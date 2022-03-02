func: func.o
	gcc -o func func.o -no-pie
func.o: func.asm
	nasm -f elf64 -g -F dwarf func.asm -l func.lst