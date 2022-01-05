; alive.asm
extern printf

section .data
    msg1    db  "Hello, world!",10,0
    msg2    db  "Alive and kicking!",10,0
    radius  dq 357
    pi      dq 3.14

    fmtstr  db  "String is: %s",0       ; For all strings
    fmtflt  db  "Float is: %lf",10,0    ; For long floats
    fmtint  db  "Int is: %d",10,0       ; For integers

section .bss

section .text
    global main

main:
    push rbp
    mov rbp, rsp

    mov rax, 0          ; rax holds the number of floating point numbers used
    mov rdi, fmtstr
    mov rsi, msg1
    call printf

    mov rax, 0
    mov rdi, fmtstr
    mov rsi, msg2
    call printf

    mov rax, 0
    mov rdi, fmtint
    mov rsi, [radius]   ; printf expects a value for anything other than a string, not a memory address!
    call printf         ; Think how it's done in C: printf("%d", &someVar) <-> printf("%s", someArr)

    mov rax, 1          ; One XMM register is used to hold one float
    mov rdi, fmtflt     
    movq xmm0, [pi]     ; Move 8 bytes instead of 1, to move the whole float
    call printf

    mov rsp, rbp
    pop rbp

ret     ; ret can be used instead of syscall + values....