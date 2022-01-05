; An example of importing externa functions
extern printf
extern c_area
extern c_circum
extern r_area
extern r_circum

global pi       ; Pi is declared globally here. This isn't generally a good idea...

section .data
    pi      dq  3.141592654
    radius  dq  10.0
    side1   dq  4
    side2   dq  5

    fmtf    db  "%s %f",10,0
    fmti    db  "%s %d",10,0
    ca      db  "The circle area is ",0
    cc      db  "The circle cicumference is ",0
    ra      db  "The rectangle area is ",0
    rc      db  "The rectangle perimeter is ",0

section .bss

section .text
    global main

main:
    push rbp
    mov rbp, rsp

    ; Circle area
    movsd xmm0, qword [radius]  ; The value to be passed into the function goes into xmm0
    call c_area
    
    mov rdi, fmtf
    mov rsi, ca
    mov rax, 1
    call printf

    ; Circle cicumference
    movsd xmm0, qword [radius]  ; The value to be passed into the function goes into xmm0
    call c_circum

    mov rdi, fmtf
    mov rsi, cc
    mov rax, 1
    call printf

    ; Rectangle area
    mov rdi, [side1]            ; Two values are passed here
    mov rsi, [side2]            ; These go into rdi and rsi
    call r_area                 ; The area is returned to rax

    mov rdi, fmti
    mov rsi, ra
    mov rdx, rax
    mov rax, 0
    call printf

    ; Rectangle perimeter
    mov rdi, [side1]
    mov rsi, [side2]
    call r_circum

    mov rdi, fmti
    mov rsi, rc
    mov rdx, rax
    mov rax, 0
    call printf

    leave
    ret