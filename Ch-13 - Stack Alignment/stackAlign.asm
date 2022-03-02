; Demonstrating the need for stack alignment

extern printf
section .data
    fmt     db  "2 * Pi = %.14f",10,0
    pi      dq  3.14159265358979

section .bss

section .text

func3:
    push rbp
    
    movsd xmm0, [pi]
    addsd xmm0, [pi]
    mov rdi, fmt
    mov rax, 1
    call printf

    pop rbp
    ret

func2:
    push rbp

    call func3

    pop rbp
    ret

func1:
   push rbp

    call func2

    pop rbp
    ret 

    global main

main:
    push rbp

    call func1

    pop rbp
    ret

;***************************************************************************************************
; INFORMATION
;
;   -> The above program may or may not run; it's pure luck!
;   -> This is all down to whether the program is correctly aligned in the stack when run...
;
;   Stack Alignment
;   
;   -> The stack MUST have a 16-bit alignment when a function is called
;   -> If not, the program will crash, even if it's aligned to 8-bits for example
;
;   -> To counter this, we manually align the stack every time a function is called
;   -> You dont explicitly have to, but not including it may cause your program to randomly crash
;   -> We simply push RBP to stack before it can be modified, which preserves the 16-bit alignment
;       - push rbp | mov rbp, rsp 
;       - mov rsp, rbp | pop rbp
;
;   Stack Frames and Functions
;
;   -> In principle, every time a function is called, you need to build a new stack frame
;   -> This is done the same way as in the main function
;
;   -> There are two types of functions
;       - Branch Functions: These call other functions
;       - Leaf Functions: These do not call other functions
;   -> Branch functions NEED to be aligned to stack
;   -> Leaf functions don't need to be, as long as they don't call any functions
; 
;   -> The rule of thumb, however, is to always include a stack frame
;
;***************************************************************************************************