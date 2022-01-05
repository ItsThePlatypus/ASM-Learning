; A simple loop program 

extern printf
section .data
    number dq 5                                 ; Number of times to loop
    fmt db "The sum from 0 to %ld is %ld",10,0  ; Message to print at the end
    
section .bss

section .text
    global main

main:
    push rbp            ; Setup for debugging
    mov rbp, rsp
    
    mov rax, 0          ; Clear out registers for program start
    mov rbx, 0
    
jloop:
    add rax, rbx        ; Add the values in the register together
    inc rbx             ; Increase the value in rbx by 1
    cmp rbx, [number]   ; Compare against our loop stop
    jle jloop           ; Jump if not done to start of this section
    
    mov rdi, fmt        ; Move our string to print here
    mov rsi, [number]   ; Move our stored number here
    mov rdx, rax        ; Empty out rax and store our final value
    mov rax, 0          ; No xmm registers used
    call printf         ; Print
    
    mov rsp, rbp        ; Clean and quit
    pop rbp
    ret
