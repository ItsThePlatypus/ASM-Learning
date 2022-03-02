; My attempt at a fizz-buzz program
extern printf

section .data
    counter     dq  100         ; Used for the main loop
    numFizzBuzz dq  15          ; 15 = Fizz Buzz
    numFizz     dq  3           ; 3 = Fizz
    numBuzz     dq  5           ; 5 = Buzz
    number      dq  0           ; The number we start from - 1, in this case 0

    fizzMsg     db  " - Fizz",0         ; Strings to print
    buzzMsg     db  " - Buzz",0
    fizzBuzzMsg db  " - Fizz Buzz",0
    defaultMsg  db  " - Nothing",0
    complete    db  "Done",0
    strfmt      db  "%d%s",10,0
    endfmt      db  "%s",10,0

section .bss
    currentNumber   resq    1   ; We will use this to store the start number as it is incremented
    loopCounter     resq    1

section .text
    global main

main:
    mov rbp, rsp                    ; Time to align the stack...
    push rbp
    
    mov rcx, [counter]              ; Move our variables to the registers 
    mov rax, [number]               ; Sadly the most efficient way of moving number into current number to save it 
    mov [currentNumber], rax
    xor rax, rax                    ; Hide our shame and clear rax
    
mainLoop: 
    cmp rcx, 0                      ; Have we completed the cycle?
    je exit                         ; Exit if so
    mov [loopCounter], rcx          ; Save the loop counter from being overwritten
    
    mov rdi, [currentNumber]        ; Move the number to test into rdi
    inc rdi                         ; To make the loop work we have to increment this value
    jmp testFizzBuzz                ; Start checking

looper:
    mov rcx, [loopCounter]          ; Place the counter back into rcx for checking (And ease of looping)
    loop mainLoop                   ; Decrement the counter and jump back to the main loop

exit:
    mov rax, 0                      ; Print the exit message and quit
    mov rdi, endfmt
    mov rsi, complete
    
    call printf
    
    mov rsp, rbp
    pop rbp
    mov rax, 60
    mov rdi, 0
    syscall
    
testFizzBuzz:
    mov [currentNumber], rdi    ; Save the number from being overwritten this round (Can now be reference whenever)

    mov rax, rdi                ; Put number to check in rax
    mov rdx, 0                  ; Clear rdx (This is where the modulo is stored so we need it empty)
    mov rdi, [numFizzBuzz]
    idiv rdi                    ; Divide the number to check by 15
    
    cmp rdx, 0                  ; Does it divide by 15?
    jne testBuzz                ; If not go here
    
    mov rsi, [currentNumber]    ; If it divides, print the message saying it does
    mov rdi, strfmt
    mov rdx, fizzBuzzMsg
    mov rax, 0
    call printf

    jmp looper                  ; Jump to pre-loop processing
    
testBuzz:
    mov rax, [currentNumber]    ; Same as above but with 5
    mov rdx, 0
    mov rdi, [numBuzz]
    idiv rdi
    
    cmp rdx, 0
    jne testFizz
    
    mov rsi, [currentNumber]
    mov rdi, strfmt
    mov rdx, buzzMsg
    mov rax, 0
    call printf
    
    jmp looper
    
testFizz:
    mov rax, [currentNumber]    ; Same as above but with 3  
    mov rdx, 0
    mov rdi, [numFizz]
    idiv rdi
    
    cmp rdx, 0
    jne fail
    
    mov rsi, [currentNumber]
    mov rdi, strfmt
    mov rdx, fizzMsg
    mov rax, 0
    call printf

    jmp looper

fail:
    mov rdi, strfmt             ; If the number does not fit, go here
    mov rsi, [currentNumber]
    mov rdx, defaultMsg
    mov rax, 0
    call printf
    
    jmp looper
