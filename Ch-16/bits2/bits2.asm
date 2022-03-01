; An example to demonstrate the properties of arithmetic shifts
extern printf
section .data
    msgn1       db  "Number 1 = %d",0
    msgn2       db  "Number 2 = %d",0
    msg1        db  "SHL 2 = OK multiply by 4",0
    msg2        db  "SHR 2 = WRONG divide by 4",0
    msg3        db  "SAL 2 = OK multiply by 4",0
    msg4        db  "SAR 2 = OK divide by 4",0
    msg5        db  "SHR 2 = OK divide by 4",0

    number1     dq  8
    number2     dq  -8
    result      dq  0

section .bss

section .text
    global main

main:
    push rbp
    mov rbp, rsp

;SHL-------------------------------------------------------
    ;Positive number
    mov rsi, msg1 
    call printmsg
    mov rsi, [number1]
    call printnbr
    mov rax, [number1]
    shl rax, 2
    mov rsi, rax
    call printres

    ;Negative number
    mov rsi, msg1 
    call printmsg
    mov rsi, [number2]
    call printnbr
    mov rax, [number2]
    shl rax, 2
    mov rsi, rax
    call printres

;SAL-------------------------------------------------------
    ;Positive number
    mov rsi, msg3 
    call printmsg
    mov rsi, [number1]
    call printnbr
    mov rax, [number1]
    sal rax, 2
    mov rsi, rax
    call printres

    ;Negative number
    mov rsi, msg3 
    call printmsg
    mov rsi, [number2]
    call printnbr
    mov rax, [number2]
    sal rax, 2
    mov rsi, rax
    call printres

;SHR-------------------------------------------------------
    ;Positive number
    mov rsi, msg2 
    call printmsg
    mov rsi, [number1]
    call printnbr
    mov rax, [number1]
    shr rax, 2
    mov rsi, rax
    call printres

    ;Negative number
    mov rsi, msg2 
    call printmsg
    mov rsi, [number2]
    call printnbr
    mov rax, [number2]
    shr rax, 2
    mov rsi, rax
    call printres

;SAR-------------------------------------------------------
    ;Positive number
    mov rsi, msg4 
    call printmsg
    mov rsi, [number1]
    call printnbr
    mov rax, [number1]
    sar rax, 2
    mov rsi, rax
    call printres

    ;Negative number
    mov rsi, msg4 
    call printmsg
    mov rsi, [number2]
    call printnbr
    mov rax, [number2]
    sar rax, 2
    mov rsi, rax
    call printres

    leave
    ret 

printmsg:
    section .data
        .fmtstr     db  10,"%s",10,0
    section .text 
        mov rdi, .fmtstr
        mov rax, 0
        call printf
    
        ret

printnbr:
    section .data
        .fmtstr     db  "The original number is %lld",10,0
    section .text
        mov rdi, .fmtstr
        mov rax, 0
        call printf
    
    ret

printres:
    section .data
       .fmtstr     db  "The resulting number is %lld",10,0
    section .text
        mov rdi, .fmtstr
        mov rax, 0
        call printf

        ret