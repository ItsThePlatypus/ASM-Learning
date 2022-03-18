; An example program that shows how to interact with command line arguments
extern printf

section .data
    msg     db  "The command and arguments: ",10,0
    fmt     db  "%s",10,0

section .bss

section .text
    global main

main:
    push rbp
    mov rbp, rsp

    mov r12, rdi                    ; Move the number of arguments to r12
    mov r13, rsi                    ; Move the address of the arguments array to r13

    mov rdi, msg                    ; Print out the string
    call printf     
    mov r14, 0                      ; Prepare for the loop 

ploop:
    mov rdi, fmt                    ; Move the string format
    mov rsi, qword[r13 + r14 * 8]   ; Pass the first argument of the argument array to rsi.
    call printf                     ; Print the argument
    
    inc r14                         ; Increment
    cmp r14, r12                    ; Have we reached the number of arguments?
    jl ploop                        ; Loop if we haven't

    leave
    ret

;************************************************************************************************
; INFORMATION
;
;   -> RDI stores the number of arguments, including the name of the program
;   -> RSI stores an address of an array containing the addresses of the command line arguments
;
;   -> The above program is designed for Linux
;       - Windows systems will use a different calling convention
;   -> When referencing the arguments, we have to increment by a certain amount
;       - This increment value refers to the length of the address pointed to
;       - 8 Bytes * 8 bits = 64-Bit address 
;************************************************************************************************