; A version of input sanitisation 
; Prevents input buffer overflow and parses out disallowed characters

section .data
    msg1        db  "Hello, world!",10,0
    msg2        db  "Your turn (a - z only): ",0
    msg3        db  "You typed: ",0

    inputLen    equ 10
    NL          db  0xA

section .bss
    input       resb    inputLen + 1    ; Remember to leave space for the null byte!

section .text
    global main

main:
    push rbp
    mov rbp, rsp 

    mov rdi, msg1       ; Print the first string
    call prints
    
    mov rdi, msg2       ; Print the second string
    call prints
    
    mov rdi, input      ; Get the user input & Display message
    mov rsi, inputLen
    call reads

    mov rdi, msg3       ; Print third string
    call prints 

    mov rdi, input      ; Print the user input
    call prints

    mov rdi, NL         ; Print the final new line
    call prints 

    leave
    ret 

prints:
    push rbp                ; Align the stack frame
    mov rbp, rsp
    push r12                ; Save the callee (Value may be needed on return so we push to save it)

    xor rdx, rdx            ; Clear rdx
    mov r12, rdi            ; Move the message to print into r12

    .lengthLoop:
        cmp byte [r12], 0   ; Have we reached the end of the string yet?
        je  .lengthFound    ; If so go here
        inc rdx             ; Increment the character count
        inc r12             ; Move to the next character in the string
        jmp .lengthLoop     ; Loop
    
    .lengthFound:   
        cmp rdx, 0          ; Was there a string to print?
        je  .done           ; Jump straight to the end if so
        mov rsi, rdi        ; Print the message
        mov rax, 1
        mov rdi, 1
        syscall 
    
    .done:
        pop r12             ; Restore the callee
        
    leave
    ret

reads:
section .data
section .bss
    .inputChar  resb    1       ; Input buffer

section .text
    push rbp                    ; Align the stack frame
    mov rbp, rsp

    push r12                    ; Save the callee registers
    push r13
    push r14
    mov r12, rdi                ; r12 holds the address of the input buffer
    mov r13, rsi                ; r13 holds the input buffer 
    xor r14, r14                ; Clear out r14

    .readC:
        mov rax, 0              ; Read...
        mov rdi, 1              ; ...from standard I/O
        lea rsi, [.inputChar]   ; Load the address of the input buffer - This is so we can write to it
        mov rdx, 1              ; Number of characters to read (We read one at a time)
        syscall

        mov al, [.inputChar]    ; Move the character to check to al
        cmp al, byte[NL]        ; Is it the newline character?
        je  .done               ; Finish up if so

        cmp al, 32              ; We ideally want to keep spaces so check for that first
        je  .continueSpace      ; Bypass all other checks if and only if the character is a space
        cmp al, 97              ; Is the character a lower case character?
        jl  .readC              ; Move to next character if not
        cmp al, 122
        jg  .readC              ; Move to next character if not

    .continueSpace:
        inc r14                 ; Increment the character count
        cmp r14, r13            ; Have we read all the characters in?
        ja  .readC              ; If r14 > r13, the buffer limit has been reached. The character is ignored but the loop continues to the end of the input

        mov byte [r12], al      ; Move the character to r12
        inc r12                 ; Move to the next buffer space
        jmp .readC              ; And onto the next character...

    .done:
        inc r12                 ; Move to the next buffer space
        mov byte [r12],0        ; Add the null character (This is necessary: Indicates the end of the file)
        pop r14                 ; Restore callee characters
        pop r13
        pop r12

    leave
    ret