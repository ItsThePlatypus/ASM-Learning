; A better way of looping

extern printf

section .data
    number      dq  5
    fmt         db  "The sum from 0 to %ld is %ld",10,0

section .bss

section .text
    global main

main:
    push rbp
    mov rbp, rsp

    mov rcx, [number]       ; Note that the number is put into rcx
    mov rax, 0

bloop:
    add rax, rcx            ; Add the numbers as before
    loop bloop              ; With every pass through the loop, rcx is decremented automatically by 1

    mov rdi, fmt            ; The rest is the same 
    mov rsi, [number]
    mov rdx, rax
    mov rax, 0
    call printf

    mov rsp, rbp
    pop rbp
    ret