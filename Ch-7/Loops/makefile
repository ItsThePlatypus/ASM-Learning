loop: loop.o
	gcc -o loop loop.o -no-pie
loop.o: loop.asm
	nasm -f elf64 -g -F dwarf loop.asm -l loop.lst