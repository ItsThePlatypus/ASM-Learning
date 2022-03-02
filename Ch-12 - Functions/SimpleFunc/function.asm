; A simple function in asm
extern printf
section .data
    radius      dq  10.0
    pi          dq  3.14
    fmt         db "The area of the circle is %.2f",10,0

section .bss
section .text
    global main

main:
    push rbp
    mov rbp, rsp

    call area               ; Call the function
    mov rdi, fmt            ; Print out the final output
    movsd xmm1, [radius]    ; Dealing with double precision and floats, so use xmm!
    mov rax, 1              ; 1 float number
    call printf

    leave                   ; This does the same as 'mov rsp, rbp | pop rbp'
    ret

area:
    push rbp
    mov rbp, rsp
    movsd xmm0, [radius]    ; Move the radius into an xmm register
    mulsd xmm0, [radius]    ; Essentially a square
    mulsd xmm0, [pi]        ; Multiply by pi

    leave
    ret

;*********************************************
; INFORMATION
;
;   -> With functions:
;       - Floats are returned via xmm0
;       - Anything else is returned via rax
;
;*********************************************