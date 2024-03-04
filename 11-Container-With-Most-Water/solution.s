.intel_syntax noprefix;

.global _maxArea

_maxArea:
    push rbp
    mov rbp, rsp

    sub rsp, 8
    mov qword ptr [rsp + 0], rdi

    mov r8, -2147483648
    mov r9, 0
    mov r10, rsi
    sub r10, 1

.WHILE_LOOP:
    cmp r10, r9
    jle .WHILE_LOOP_EXIT

    mov r11, r10
    sub r11, r9
    
    mov rax, qword ptr [rsp + 0]
    mov eax, dword ptr [rax + r9 * 4]
    mov esi, eax

    mov rax, qword ptr [rsp + 0]
    mov eax, dword ptr [rax + r10 * 4]
    mov edi, eax

    cmp esi, edi
    jle .L_LESS_THAN_R
    mov esi, edi
    sub r10, 1
    jmp .CALCULATE_AREA

.L_LESS_THAN_R:
    add r9, 1
    jmp .CALCULATE_AREA

.CALCULATE_AREA:
    imul rsi, r11
    cmp rsi, r8
    jg .SET_NEW_MAX_AREA
    jmp .WHILE_LOOP

.SET_NEW_MAX_AREA:
    mov r8, rsi
    jmp .WHILE_LOOP

.WHILE_LOOP_EXIT:
    mov eax, r8d
    add rsp, 8
    pop rbp
    ret