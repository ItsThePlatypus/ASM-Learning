; Program to show how function arguments are passed in assembly
extern printf

section .data
    first       db  "A",0
    second      db  "B",0
    third       db  "C",0
    fourth      db  "D",0
    fifth       db  "E",0
    sixth       db  "F",0
    seveth      db  "G",0
    eigth       db  "H",0
    ninth       db  "I",0
    tenth       db  "J",0
    pi          dq  3.14

    fmt1        db  "The string is %s%s%s%s%s%s%s%s%s%s",10,0
    fmt2        db  "Pi = %f",10,0

section .bss

section .text
    global main

main:
    push rbp
    mov rbp, rsp

    mov rdi, fmt1       ; The first 6 arguments a function takes go in the register
    mov rsi, first
    mov rdx, second
    mov rcx, third
    mov r8, fourth
    mov r9, fifth

    push tenth          ; Any other arguments are pushed to stack in REVERSE ORDER
    push ninth
    push eigth
    push seveth
    push sixth

    mov rax, 0          ; The function can then be called
    call printf

    and rsp, 0xfffffffffffffff0     ; We need to realign the stack to call printf on a float!
    movsd xmm0, [pi]
    mov rax, 1
    mov rdi, fmt2
    call printf

    leave
    ret

;*****************************************************************************************************
; INFORMATION
;
;   -> Once function arguments are passed onto the stack, they are offset in 8-byte increments
;   -> Another 16-bytes (AT LEAST) are then added on top; these are rip and rbp
;       - Another push may be needed in order to get 16-byte alignment 
;   -> Therefore, before arguments can be accessed in a function, the first 16-bytes must be skipped
;
;*****************************************************************************************************
; Function argument order - Non-floating numbers
;  _________________________________________
; | Argument No. | Register                 |
; |-----------------------------------------|
; | 1            | rdi                      |
; | 2            | rsi                      |
; | 3            | rdx                      |
; | 4            | rcx                      |
; | 5            | r8                       |
; | 6            | r9                       |
; | 7+           | Stack (IN REVERSE ORDER) |
;  -----------------------------------------
;
; Function argument order - Floating numbers
;  ________________________________________
; | Argument No. | Register                 |
; |-----------------------------------------|
; | 1            | xmm0                     |
; | 2            | xmm1                     |
; | 3            | xmm2                     |
; | 4            | xmm3                     |
; | 5            | xmm4                     |
; | 6            | xmm5                     |
; | 7            | xmm6                     |
; | 8            | xmm7                     |
; | 9+           | Stack (IN REVERSE ORDER) |
;  -----------------------------------------  
;*****************************************************************************************************