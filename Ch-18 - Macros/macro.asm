; A simple example of a macro
extern printf

%define double_it(r)    sal r, 1                    ; Single line macro

%macro prntf 2                                      ; Define a macro, prntf, that takes two arguments
    section .data
        %%arg1      db  %1,0                        ; These are just variables in the macro. "%%" Indicates to the preprocessor that it
        %%fmtint    db  "%s %ld",10,0               ; needs to make a new instance of these variables every time the macro is called
    section .text
        mov rdi, %%fmtint
        mov rsi, %%arg1 
        mov rdx, [%2]                               ; %2 = Second macro argument, %1 = First macro argument
        mov rax, 0
        call printf
%endmacro                                           ; This indicates the end of the macro

section .data
    number  dq  15

section .bss

section .text
    global main

main:
    push rbp
    mov rbp, rsp

    prntf   "The number is", number                 ; Call the macro, with the first and second arguments 
    mov rax, [number]
    double_it(rax)                                  ; Call the define, passing in the value in rax
    mov [number], rax
    prntf   "The number doubled is", number

    leave
    ret

;*********************************************************************************************
; INFORMATION
;
;   -> Calling and returning from functions takes a lot of time due to the jumps required
;   -> A macro mitigates this issue as the macro code is inserted in-line to the main program
;
;   -> Macros are NOT part of the Intel assembly language
;   -> They are provided by the NASM pre-processor
;   -> Whilst macros decrease execution time, they do increase the size of the executable...
;
;
;   TYPES OF MACRO
;
;   -> %define, %macro, and %endmacro are called "Assembler Preprocessor Directives" 
;
;   -> Single line Macro
;       - Defined with "%define"
;       - The instruction is simply substituted in at runtime 
;
;   -> Multiline Macro
;       - Defined with "%macro...%endmacro"
;       - Strings and numbers are treated the same way as inline assembly 
;
;   -> Macros do make debugging very hard, as the macro code is inserted at run time!
;*********************************************************************************************