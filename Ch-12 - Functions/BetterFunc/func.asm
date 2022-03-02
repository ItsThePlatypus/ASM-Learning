; A more complex function
extern printf
section .data
    radius      dq  10.0        ; This variable is global!

section .bss
section .text

area:
    section .data
        .pi dq  3.141592654     ; This variable is local to the function

    section .text
        push rbp
        mov rbp, rsp

        movsd xmm0, [radius]    ; This function calculates the radius and returns it to xmm0
        mulsd xmm0, [radius]
        mulsd xmm0, [.pi]

        leave
        ret

circum:
    section .data
        .pi dq  3.141592654
    
    section .text
        push rbp
        mov rbp, rsp

        movsd xmm0, [radius]    ; This function calculates the cicumference and returns it to xmm0
        addsd xmm0, [radius]
        mulsd xmm0, [.pi]

        leave
        ret

circle:
    section .data
        .fmt_area   db  "The area is %f",10,0
        .fmt_circum db  "The cicumference is %f",10,0
    
    section .text
        push rbp
        mov rbp, rsp

        call area               ; Because xmm0 is populated by the output, we don't need to manually assign a value to it!
        mov rdi, .fmt_area
        mov rax, 1
        call printf

        call circum
        mov rdi, .fmt_circum
        mov rax, 1
        call printf

        leave
        ret

    global main     ; This global main is not part of any function

main:
    push rbp
    mov rbp, rsp

    call circle     ; We simply call the function and leave it to it

    leave
    ret

;********************************************************************
; INFORMATION
;
;   -> Functions can have their own .data, .bss, and .text sections
;   -> Functions CANNOT be nested, but CAN call other functions
;
;********************************************************************