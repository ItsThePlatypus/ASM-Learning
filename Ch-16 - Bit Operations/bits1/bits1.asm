; bits.asm 
extern printb
extern printf
section .data
    msgn1   db  "Number 1",10,0
    msgn2   db  "Number 2",10,0
    msg1    db  "XOR",10,0
    msg2    db  "OR",10,0
    msg3    db  "AND",10,0
    msg4    db  "NOT",10,0
    msg5    db  "SHL 2 lower byte of number 1",10,0
    msg6    db  "SHR 2 lower byte of number 1",10,0
    msg7    db  "SAL 2 lower byte of number 1",10,0
    msg8    db  "SAR 2 lower byte of number 1",10,0
    msg9    db  "ROL 2 lower byte of number 1",10,0  
    msg10   db  "ROL 2 lower byte of number 2",10,0
    msg11   db  "ROR 2 lower byte of number 1",10,0
    msg12   db  "ROR 2 lower byte of number 2",10,0
    number1 dq  -72
    number2 dq  1064

section .bss

section .text
    global main

main:
    push rbp
    mov rbp, rsp

    ;Print Number 1
    mov rsi, msgn1
    call printmsg
    mov rdi, [number1]
    call printb

    ;Print Number 2
    mov rsi, msgn2
    call printmsg
    mov rdi, [number2]
    call printb

    ;Print XOR
    mov rsi, msg1
    call printmsg

    mov rax, [number1]
    xor rax, [number2]
    mov rdi, rax
    call printb

    ;Print OR
    mov rsi, msg2
    call printmsg

    mov rax, [number1]
    or rax, [number2]
    mov rdi, rax
    call printb

    ;Print AND
    mov rsi, msg3
    call printmsg

    mov rax, [number1]
    and rax, [number2]
    mov rdi, rax
    call printb

    ;Print NOT
    mov rsi, msg4
    call printmsg

    mov rax, [number1]
    not rax
    mov rdi, rax
    call printb

    ;Print SHL
    mov rsi, msg5 
    call printmsg

    mov rax, [number1]
    shl al, 2
    mov rdi, rax
    call printb

    ;Print SHR
    mov rsi, msg6 
    call printmsg

    mov rax, [number1]
    shr al, 2
    mov rdi, rax
    call printb

    ;Print SAL
    mov rsi, msg7 
    call printmsg

    mov rax, [number1]
    sal al, 2
    mov rdi, rax
    call printb

    ;Print SAR
    mov rsi, msg7 
    call printmsg

    mov rax, [number1]
    sar al, 2
    mov rdi, rax
    call printb

    ;Print ROL (Rotate Left)
    mov rsi, msg9 
    call printmsg

    mov rax, [number1]
    rol al, 2
    mov rdi, rax
    call printb

    mov rsi, msg10 
    call printmsg

    mov rax, [number2]
    rol al, 2
    mov rdi, rax
    call printb

    ;Print ROR (Rotate Right)
    mov rsi, msg11 
    call printmsg

    mov rax, [number1]
    ror al, 2
    mov rdi, rax
    call printb

    mov rsi, msg12 
    call printmsg

    mov rax, [number2]
    ror al, 2
    mov rdi, rax
    call printb

    leave
    ret 

printmsg:
    section .data
        .fmtstr     db  "%s",0
    
    section .text
        mov rdi, .fmtstr
        mov rax, 0
        call printf
        ret

;----------------------------------------------------------------------------------------------------
;   - Rotate instructions are like a bit-shift, except the values roll over to the other side
;   - Arithmetic shifts right maintain the sign extension, meaning you can divide negative numbers
;
;   - Example:
;       ROL 2 lower byte of number 1
;       11111111 11111111 11111111 11111111 11111111 11111111 11111111 1110001
;
;       SAL 2 lower byte of number 1
;       11111111 11111111 11111111 11111111 11111111 11111111 11111111 1110000
;
;       SHL 2 lower byte of number 1
;       11111111 11111111 11111111 11111111 11111111 11111111 11111111 1110000
;
;----------------------------------------------------------------------------------------------------