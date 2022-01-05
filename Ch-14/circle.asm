; This file contains all functions relating to the circle
extern pi
section .data

section .bss

section .text
    global c_area

c_area:
    section .text
        push rbp
        mov rbp, rsp

        movsd xmm1, qword [pi]
        mulsd xmm0, xmm0
        mulsd xmm0, xmm1        ; Can this be replaced with mulsd xmm0, qword [pi]?

        leave
        ret

    global c_circum

c_circum:
    section .text
        push rbp
        mov rbp, rsp

        movsd xmm1, qword [pi]
        addsd xmm0, xmm0
        mulsd xmm0, xmm1

        leave
        ret 