; Function for summing the elements of the double array

section .data

section .bss

section .text
global aSum
    aSum:
        section .text
            mov rcx, rsi
            mov rbx, rdi
            mov r12, 0
            
            movsd xmm0, qword[rbx + r12 * 8]
            dec rcx
            
            sLoop:
                inc r12
                addsd xmm0, qword[rbx + r12 * 8]
                loop sLoop
            ret