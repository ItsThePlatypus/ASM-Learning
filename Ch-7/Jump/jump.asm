; An example of basic jumps in a program

extern printf
section .data
    number1     dq  42
    number2     dq  41
    fmt1        db  "Number1 >= Number2",10,0
    fmt2        db  "Number2 >= Number1",10,0

section .bss
section .text
    global main
main:
    push rbp
    mov rbp, rsp
    
    mov rax, [number1]  ; Move the values into the two registers
    mov rbx, [number2]
    cmp rax, rbx        ; Perform a comparison. This will set or clear flags in the flag register
    jge greater         ; Jump to "greater" if first value is greater than the second

    mov rax, 0          ; This section runs if the above condition isn't met
    mov rdi, fmt2
    call printf
    jmp exit            ; Exit is always called

greater:
    mov rax, 0          ; This section runs if the above condition is met
    mov rdi, fmt1
    call printf
    jmp exit            ; Exit is always called

exit:
    mov rsp, rbp
    pop rbp
    ret

;*****************************************************************************************
;   INFORMATION
;
;   Flags Registers
;   _____________________________________________________________________________________
;  | Instruction | Flags                   | Meaning                  | Use              |
;  |-------------------------------------------------------------------------------------|
;  | je          | ZF = 1                  | Jump if equal            | Signed, Unsigned |
;  | jne         | ZF = 0                  | Jump if not equal        | Signed, Unsigned | 
;  | jg          | ((SF XOR OF) OR ZF) = 0 | Jump if greater          | Signed           |
;  | jge         | (SF XOR OF) = 0         | Jump if greater or equal | Signed           |
;  | jl          | (SF XOR OF) = 1         | Jump if lower            | Signed           |
;  | jle         | ((SF XOR OF) OR ZF) = 1 | Jump if lower or equal   | Signed           |
;  | ja          | (CF OR ZF) = 0          | Jump if above            | Unsigned         |
;  | jae         | CF = 0                  | Jump if above or equal   | Unsigned         |
;  | jb          | CF = 1                  | Jump if lesser           | Unsigned         |
;  | jbe         | (CF OR ZF) = 1          | Jump if lesser or equal  | Unsigned         |
;   -------------------------------------------------------------------------------------
;*****************************************************************************************