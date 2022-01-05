; How are values stored in registers affected by moves?
; Best viewed in a debugger...

section .data
    bNum    db  123
    wNum    dw  12345
    dNum    dd  124567890
    qNum1   dq  1234567890123456789
    qNum2   dq  123456
    qNum3   dq  3.14

section .bss
section .text
    global main

main:
    push rbp
    mov rbp, rsp

    mov rax, -1             ; Fill rax up with 1s
    mov al, byte [bNum]     ; This does NOT clear the upper bits of rax
    xor rax, rax            ; Clear rax
    mov al, byte [bNum]     ; Now the upper bits of rax are cleared 

    mov rax, -1
    mov ax, word [wNum]     ; This does not clear the upper bits of rax either 
    xor rax, rax
    mov ax, word [wNum]

    mov rax, -1
    mov eax, dword [dNum]   ; This clears the upper bits of rax

    mov rax, -1
    mov rax, qword [qNum1]  ; This clears rax too
    mov qword [qNum2], rax
    mov rax, 123456

    movq xmm0, [qNum3]

    mov rsp, rbp
    pop rbp

    ret

;************************************************************************************************
; -> Copying a value into an 8 or 16-bit register does not clear the higher part of the register
; -> Copying in a value into a 32-bit register does clear it, however
;************************************************************************************************