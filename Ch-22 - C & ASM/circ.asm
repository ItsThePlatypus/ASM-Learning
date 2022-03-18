; Definition of functions for the circle

section .data
    pi      dq  3.141592654

section .bss

section .text
global cArea
    cArea:
        section .text
            push rbp
            mov rbp,rsp

            movsd xmm1, qword[pi]
            mulsd xmm0, xmm0
            mulsd xmm0, xmm1

            leave
            ret

global cCircum
    cCircum:
        section .text
            push rbp
            mov rbp, rsp 

            movsd xmm1, qword[pi]
            addsd xmm0, xmm0 
            mulsd xmm0, xmm1

            leave
            ret