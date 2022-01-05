printf: printf.o
	gcc -o printf printf.o -no-pie
printf.o: printf.asm
	nasm -f elf64 -g -F dwarf printf.asm -l printf.lst