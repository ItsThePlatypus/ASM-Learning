; Example of basic I/O using assembly
; This program doesn't take into account buffer overflow though...

section .data
    msg1        db  "Hello, world!",10,0
    msg1len     equ $-msg1 
    msg2        db  "Your turn, type something: ",0
    msg2len     equ $-msg2 
    msg3        db  "Your response: ",0
    msg3len     equ $-msg3 

    inputLen    equ 10              ; Input length buffer

section .bss
    input   resb    inputLen + 1    ; Remember the null character!

section .text
    global main

main:
    push rbp
    mov rbp, rsp 

    mov rsi, msg1           ; Message to print
    mov rdx, msg1len        ; Length of message

    call prints

    mov rsi, msg2
    mov rdx, msg2len

    call prints

    mov rsi, input          ; Address of input buffer
    mov rdx, inputLen       ; Length of input buffer

    call reads

    mov rsi, msg3
    mov rdx, msg3len

    call prints

    mov rsi, input
    mov rdx, inputLen

    call prints

    leave
    ret

prints:
    push rbp
    mov rbp, rsp

    ; RSI = Address of string
    ; RDX = Length of string

    mov rax, 1          ; RAX = 1 = Write...
    mov rdi, 1          ; RDI = 1 = ...to Standard Input/Ouput
    syscall

    leave
    ret

reads:
    push rbp
    mov rbp, rsp

    ; RSI = Address of input buffer
    ; RDX = Length of input buffer

    mov rax, 0          ; RAX = Read...
    mov rdi, 1          ; RDI = ...to Standard Input/Ouput
    syscall

    leave 
    ret