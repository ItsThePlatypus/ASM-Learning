; Integrating C functions into asm code

extern printf   ; Externals are imported in exactly the same way as C

section .data
    msg     db "Hello, World!",10,0     ; Message to print is as normal
    fmtstr  db "The string is: %s",0    ; This is just like how you would print a string in C

section .bss

section .text
    global main

main:
    push rbp
    mov rbp, rsp

    mov rax, 0
    mov rdi, fmtstr     ; RDI now holds the first argument for printf [printf(<argument 1>, <argument 2>)]
    mov rsi, msg        ; RDI now holds the second argument for printf [printf(<argument 1>, <argument 2>)]
    call printf         ; This runs printf  

    mov rsp, rbp        ; Same cleanup as before 
    mov rax, 60
    mov rdi, 0
    syscall

;***********************************************************************************
; - printf, and any imported functions from C, are used in similar ways in assembly
; - For example, with printf....
;       -> char msg[] = "Hello, world!\n";
;       -> printf("The string is: %s", msg);
;
;       This becomes:
;       -> mov rax, 0
;       -> mov rdi, <"The string is: %s">
;       -> mov rsi, msg
;       -> call printf
;***********************************************************************************