; Function for doubling the elements in the array
section .data

section .bss

section .text
global aDouble
    aDouble:
        section .text
            mov rcx, rsi
            mov rbx, rdi
            mov r12, 0
            
            aLoop:
                movsd xmm0, qword [rbx + r12 * 8]
                addsd xmm0, xmm0
                movsd qword [rbx + r12 * 8], xmm0
                inc r12
                loop aLoop
            
            ret