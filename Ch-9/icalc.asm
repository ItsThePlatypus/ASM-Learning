; A program to demonstrate integer calculations
extern printf

section .data
    number1     dq  128
    number2     dq  19
    negNum      dq  -12

    fmt         db  "The numbers are %ld and %ld",10,0
    fmtint      db  "%s %ld",10,0
    sumi        db  "The sum is",0
    difi        db  "The difference is",0
    inci        db  "Number 1 incremented:",0
    deci        db  "Number 1 decremented:",0
    sali        db  "Number 1 shift left 2 (x4):",0
    sari        db  "Number 1 shift right 2 (/4):",0
    sariex      db  "Number 1 shift right 2 (/4) with sign extension:",0
    muli        db  "The product is",0
    divi        db  "The integer quotient is",0
    remi        db  "The modulo is",0

section .bss
    resulti     resq    1
    modulo      resq    1

section .text
    global main

main:
    push rbp
    mov rbp, rsp

    ; Display numbers
    mov rdi, fmt
    mov rsi, [number1]
    mov rdx, [number2]
    mov rax, 0
    call printf

    ; Adding
    mov rax, [number1]
    add rax, [number2]      ; Add the second operand to the first (rax = [number2] + rax)
    mov [resulti], rax

    mov rdi, fmtint
    mov rsi, sumi
    mov rdx, [resulti]
    mov rax, 0
    call printf

    ; Subtracting
    mov rax, [number1]
    sub rax, [number2]      ; Subtract the second operand to the first (rax = [number2] - rax)
    mov [resulti], rax

    mov rdi, fmtint
    mov rsi, difi
    mov rdx, [resulti]
    mov rax, 0
    call printf

    ; Incrementing
    mov rax, [number1]
    inc rax                 ; Increment the value stored here by 1
    mov [resulti], rax

    mov rdi, fmtint
    mov rsi, inci
    mov rdx, [resulti]
    mov rax, 0
    call printf

    ; Decrementing
    mov rax, [number1]
    dec rax                 ; Decrement the value stored here by 1
    mov [resulti], rax

    mov rdi, fmtint
    mov rsi, deci
    mov rdx, [resulti]
    mov rax, 0
    call printf

    ; Shift arithmetic left
    mov rax, [number1]
    sal rax, 2              ; Shift the bits left by the number in the second operand
    mov [resulti], rax

    mov rdi, fmtint
    mov rsi, sali
    mov rdx, [resulti]
    mov rax, 0
    call printf

    ; Shift arithmetic right
    mov rax, [number1]
    sar rax, 2              ; Shift the bits right by the number in the second operand
    mov [resulti], rax

    mov rdi, fmtint
    mov rsi, sari
    mov rdx, [resulti]
    mov rax, 0
    call printf

    ; Shift arithmetic right with sign extension
    mov rax, [negNum]
    sar rax, 2
    mov [resulti], rax

    mov rdi, fmtint
    mov rsi, sariex
    mov rdx, [resulti]
    mov rax, 0
    call printf

    ; Mulitply 
    mov rax, [number1]
    imul qword [number2]    ; imul is used for signed integers. It multiplies the input by the value in rax
    mov [resulti], rax

    mov rdi, fmtint
    mov rsi, muli
    mov rdx, [resulti]
    mov rax, 0
    call printf  

    ; Divide
    mov rax, [number1]
    mov rdx, 0
    idiv qword [number2]    ; idiv is used for signed integers. It divides the input by the value in rax
    mov [resulti], rax      ; The remainder (modulo) is stored in rdx!

    mov rdi, fmtint
    mov rsi, divi
    mov rdx, [resulti]
    mov rax, 0
    call printf
    mov rdi, fmtint
    mov rsi, remi
    mov rdx, [modulo]
    mov rax, 0
    call printf

    mov rsp, rbp
    pop rbp
    ret