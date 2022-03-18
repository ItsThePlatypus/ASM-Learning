; Definition of functions for the rectangle

section .data

section .bss

section .text
global rArea
    rArea:
        section .text
            push rbp
            mov rbp, rsp

            mov rax, rdi
            imul rsi
            
            leave
            ret 

global rCircum
    rCircum:
        section .text
            push rbp
            mov rbp, rsp

            mov rax, rdi
            add rax, rsi 
            imul rax, 2

            leave
            ret