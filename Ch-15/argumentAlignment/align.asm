; Program demonstrating need for alignment when calling arguments in functions
extern printf

section .data
    first       db  "A",0
    second      db  "B",0
    third       db  "C",0
    fourth      db  "D",0
    fifth       db  "E",0
    sixth       db  "F",0
    seveth      db  "G",0
    eigth       db  "H",0
    ninth       db  "I",0
    tenth       db  "J",0

    fmt         db  "The string is %s",10,0

section .bss
    flist   resb    11  ; Length of string to print + NULL

section .text
    global main

main:
    push rbp
    mov rbp, rsp

    mov rdi, flist          ; This is where we will store the string
    mov rsi, first          ; Add the arguments in order
    mov rdx, second
    mov rcx, third
    mov r8, fourth
    mov r9, fifth

    push tenth
    push ninth
    push eigth
    push seveth
    push sixth

    call lfunc              ; Call the function

    mov rdi, fmt            ; Print out the list
    mov rsi, flist
    mov rax, 0
    call printf

    leave
    ret

lfunc:
    push rbp                ; Initial stack alignment
    mov rbp, rsp            ; Note that rsp has been modified twice...

    xor rax, rax            ; Ensure rax is clear (including higher bits)

    mov al, byte[rsi]       ; Move the first character (A) into al
    mov [rdi], al           ; Save the character as the first element in the array (flist)
    mov al, byte[rdx]       ; Go through each character in the registers we have
    mov [rdi+1], al
    mov al, byte[rcx]       ; NB: Using [byte] isn't necessary, it just helps improve readability
    mov [rdi+2], al
    mov al, byte[r8]
    mov [rdi+3], al
    mov al, byte[r9]
    mov [rdi+4], al

    push rbx                ; Save the caller
    xor rbx, rbx    
    
    mov rax, qword [rbp+16] ; Next character on stack = Initial stack pointer + rbi + rsi (0 + 8 + 8 = 16)
    mov bl, byte[rax]       ; Since rsp has been modified twice, it decreased by 16-bytes
    mov [rdi+5], bl         ; Therefore we need to augment the value of the addresses by 16...
    mov rax, qword [rbp+24]
    mov bl, byte[rax]
    mov [rdi+6], bl
    mov rax, qword [rbp+32] ; Extract the memory portion from the stack
    mov bl, byte[rax]       ; Move the lower bytes (The character) to bl
    mov [rdi+7], bl         ; Add the character to the array to print
    mov rax, qword [rbp+40]
    mov bl, byte[rax]
    mov [rdi+8], bl
    mov rax, qword [rbp+48]
    mov bl, byte[rax]
    mov [rdi+9], bl

    mov bl, 0
    mov [rdi + 10], bl

    pop rbx                 ; Restore the caller
    leave
    ret

; ****************************************************************************************************
; INFORMATION
;
; Calling conventions
;  ________________________________________________
; |  Register  | Usage                    | Save   |
; |------------------------------------------------|
; | rax        | Return value             | Caller |
; | rbx        | Callee saved             | Callee |
; | rcx        | 4th Argument             | Caller |
; | rdx        | 3rd Argument             | Caller |
; | rsi        | 2nd Argument             | Caller |
; | rdi        | 1st Argument             | Caller |
; | rbp        | Callee saved             | Callee |
; | rsp        | Stack Pointer            | Callee |
; | r8         | 5th Argument             | Caller |
; | r9         | 6th Argument             | Caller |
; | r10        | Temporary                | Caller |
; | r11        | Temporary                | Caller |
; | r12        | Callee Saved             | Callee |
; | r13        | Callee Saved             | Callee |
; | r14        | Callee Saved             | Callee |
; | r15        | Callee Saved             | Callee |
; | xmm0       | First Argument & Return  | Caller |
; | xmm1       | Second Argument & Return | Caller |
; | xmm2 - 7   | Arguments                | Caller |
; | xmm8 - 15  | Temporary                | Caller |
;  ------------------------------------------------
;
; ****************************************************************************************************
;   -> When a function uses a callee-saved register, the function needs to push that register
;      to the stack in order to preserve it 
;   -> The caller expects the callee-saved register to remain intact
;   -> The argument registers can easily be changed in functions
;       - It is the responsibility of the caller to push/pop registers if they need to be preserved 
;
;   -> The xmm registers can be changed by a function, and can be preserved in the same way
;   -> Syscalls also modify registers, so be sure to push registers that need to be saved
; ****************************************************************************************************