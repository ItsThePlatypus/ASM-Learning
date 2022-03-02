; Program to demonstrate individual bit operations
extern printb
extern printf

section .data
    msg1        db  "No bits are set:",10,0
    msg2        db  10,"Set bit #4, that is the 5th bit",10,0
    msg3        db  10,"Set bit #7, that is the 8th bit",10,0
    msg4        db  10,"Set bit #8, that is the 9th bit",10,0
    msg5        db  10,"Set bit #61, that is the 62nd bit",10,0
    msg6        db  10,"Clear bit #8, that is the 9th bit",10,0
    msg7        db  10,"Test bit #61 and display rdi",10,0
    bitflags    dq  0

section .bss

section .text
    global main

main:
    push rbp
    mov rbp, rsp

    ; Print title
    mov rdi, msg2
    xor rax, rax
    call printf

    mov rdi, [bitflags]
    call printb

    ; Set bit 4 (The 5th bit)
    mov rdi, msg2
    xor rax, rax
    call printf

    bts qword [bitflags], 4
    mov rdi, [bitflags]
    call printb

    ; Set bit 7 (The 8th bit)
    mov rdi, msg3
    xor rax, rax
    call printf

    bts qword [bitflags], 7
    mov rdi, [bitflags]
    call printb

    ; Set bit 8 (The 9th bit)
    mov rdi, msg4
    xor rax, rax
    call printf

    bts qword [bitflags], 8
    mov rdi, [bitflags]
    call printb

    ; Set bit 61 (The 62nd bit)
    mov rdi, msg5
    xor rax, rax
    call printf

    bts qword [bitflags], 61
    mov rdi, [bitflags]
    call printb

    ; Clear bit 8
    mov rdi, msg6
    xor rax, rax
    call printf

    btr qword [bitflags], 8
    mov rdi, [bitflags]
    call printb

    ; Test bit 61 (Sets carry flag to 1 if passed)
    mov rdi, msg7 
    xor rax, rax
    call printf
    xor rdi, rdi
    
    mov rax, 61         ; Bit number to test
    xor rdi, rdi        ; Make sure that rdi is cleared
    bt [bitflags], rax  ; Bit test operation
    setc dil            ; dil = low rdi. Set this value to 1 if the carry flag is set
    call printb         ; Display rdi

    leave 
    ret 