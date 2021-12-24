; Hello.asm
; A simple assembly program

section .data
    msg     db  "Hello, world!",10,0
    msgLen  equ $-msg 
section .bss
section .text
    global main
main:
    mov rax, 1          ; 1 = Write
    mov rdi, 1          ; 1 = To stdout
    mov rsi, msg        ; Text to print
    mov rdx, msgLen     ; Number of characters
    syscall             ; Syscall - Runs the above code

    mov rax, 60         ; Exit 
    mov rbx, 0          ; Exit code
    syscall             ; Syscall - Runs the above code

;****************************************************************************************
; INFORMATION
;
; - There are three main sections to an assembly program
;    -> section .data
;    -> section .bss
;    -> section .text
;
; - In section .data, initialised data is declared
;    -> It is done in the format <variable name> <type> <value>
;    -> Constants can also be declared with the format <variable name> equ <value>
; 
; - In section .bss, unitialised variables are declared
;    -> It is done in the format <variable name> <type> <number>
;    -> BSS stands for Block Started by Symbol
;
; - Section .txt is where the main program code is stored
;****************************************************************************************
; DATA TYPES
;
; section .txt
;  ____________________________________
; | Type | Length (Bits) |     Name    |
; |------------------------------------|
; |  db  |        8      | Byte        |
; |  dw  |       16      | Word        |
; |  dd  |       32      | Double Word |
; |  dq  |       64      | Quadword    |
;  ------------------------------------
;
; section .bss
;  ______________________________________
; |  Type  | Length (Bits) |     Name    |
; |--------------------------------------|
; |  resb  |        8      | Byte        |
; |  resw  |       16      | Word        |
; |  resd  |       32      | Double Word |
; |  resq  |       64      | Quadword    |
;  --------------------------------------
;****************************************************************************************