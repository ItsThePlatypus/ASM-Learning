# Makefile for the three programs
func4: func4.o circle.o rect.o
	gcc -g -o func4 func4.o circle.o rect.o -no-pie
func4.o: func4.asm
	nasm -f elf64 -g -F dwarf func4.asm -l func4.lst
circle.o: circle.asm
	nasm -f elf64 -g -F dwarf circle.asm -l circle.lst
rect.o: rect.asm
	nasm -f elf64 -g -F dwarf rect.asm -l rect.lst