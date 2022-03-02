; A program to explore memory in asm
; Best viewed in a debugger...

section .data
    bNum        db  123
    wNum        dw  12345
    wArray      times 5 dw 0

    dNum        dd  12345
    qNum1       dq  12345
    text1       db  "abc",0
    qNum2       dq  3.141592654
    text2       db  "cde",0

section .bss
    bvar    resb    1
    dvar    resd    1
    wvar    resw    10
    qvar    resq    3

section .text
    global main

main:
    push rbp
    mov rbp, rsp

    lea rax, [bNum]     ; lea = Load Effective Address. Loads address of bNum in rax
    mov rax, bNum
    mov rax, [bNum]     ; Load value in bNum into rax
    
    mov [bvar], rax     ; Load from rax at address bvar
    lea rax, [bvar]     ; Then load the address of bvar into rax

    lea rax, [wNum]     ; Load address of wNum into rax
    mov rax, [wNum]     ; Then load the content of wNum into rax

    lea rax, [text1]    ; Load address of text1 into rax
    mov rax, text1      ; Load address again
    mov rax, text1 + 1  ; Load second character into rax

    lea rax, [text1 + 1]
    mov rax, [text1]
    mov rax, [text1 + 1]

    mov rsp, rbp
    pop rbp
    ret