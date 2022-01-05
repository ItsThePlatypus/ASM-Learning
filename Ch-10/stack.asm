; Using the stack to reverse a string

extern printf
section .data
    string      db  "ABCDE",0
    strLen      equ $-string-1      ; We subtract 1 in order to remove the null character

    fmt1        db  "The original string: %s",10,0
    fmt2        db  "The new string: %s",10,0

section .bss

section .text
    global main

main:
    push rbp
    mov rbp, rsp

    mov rdi, fmt1       ; Print the original string out
    mov rsi, string
    mov rax, 0
    call printf

    xor rax, rax        ; Clear rax to initialise it properly
    mov rbx, string     ; Move the address of the string into rbx
    mov rcx, strLen     ; Move the length of the string into rcx
    mov r12, 0          ; We will use r12 as a pointer

    pushLoop:
        mov al, byte [rbx + r12]    ; Move a character into al
        push rax                    ; Push the whole of rax onto the stack. Push moves 8 bytes onto the stack
        inc r12                     ; Increment the character pointer with 1
        loop pushLoop               ; Loop through the whole string (Remember rcx auto-decrements when loop is used!)

    mov rbx, string     ; Move the address of string into rbx again
    mov rcx, strLen     ; Counter reset
    mov r12, 0          ; Pointer reset

    popLoop:
        pop rax                     ; Pop a character from stack into rax
        mov byte [rbx + r12], al    ; Move a character back into the string
        inc r12                     ; Increment pointer value
        loop popLoop                ; Loop through the whole string (Remember rcx auto-decrements when loop is used!)
    mov byte [rbx, + r12], 0        ; Cap with a 0 byte to signify new line

    mov rdi, fmt2       ; Print out the reversed string
    mov rsi, string
    mov rax, 0
    call printf

    mov rsp, rbp        ; Cleanup
    pop rbp
    ret