%include "../include/io.mac"

; declare your structs here

struc request
    admin: resb 1
    prio: resb 1
    passkey: resw 1
    username: resb 51
endstruc

section .text
    global sort_requests
    extern printf

sort_requests:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov ebx, [ebp + 8]      ; requests
    mov ecx, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here

    ; fac ecx sa fie egal cu lungimea sirului * lungimea elementului
    dec ecx
    mov eax, ecx
    mov esi, request_size
    mul esi
    mov ecx, eax
first_loop: ; practic for dupa i = n-1:-1:1
    mov edi, ecx ; copiez in edi valoarea actuala a ecx pt a doua bucla a sortarii
    sub edi, request_size
second_loop: ; practic for dupa j = i-1:-1:0
    push ecx ; salvez val de inceput a lui i
    push edi ; salvez val de inceput a lui j
    xor eax, eax
    xor edx, edx
    mov al, [ebx + ecx] ; primul elem
    mov dl, [ebx + edi] ; al doilea elem
    push edx
    xor edx, eax ; verif daca admin este egal pt cele 2 elem
    jz crit_2 ; daca este egal trec la al doilea crit de comp
    pop edx
    push edx
    sub edx, eax
    js swap
    jmp end_cmp ; sunt in ordinea buna

crit_2:
    pop edx
    mov al, [ebx + ecx + 1]
    mov dl, [ebx + edi + 1]
    push edx
    xor edx, eax
    jz crit_3 ; daca prio sunt egale trec la al treilea crit de comp
    pop edx
    push edx
    sub edx, eax ; verif daca prio pe primul elem este mai mare
    jns swap
    jmp end_cmp ; sunt in ordinea buna

crit_3:
    pop edx
    mov al, [ebx + ecx + 4]
    mov dl, [ebx + edi + 4]
    push edx
    xor edx, eax ; verif daca user-ul pe primul elem este mai mare
    jz crit_3_inainte ; avansez prin sirul de caractere
    pop edx
    push edx
    sub edx, eax
    jns swap
    jmp end_cmp ; sunt in ordinea buna

crit_3_inainte:
    inc ecx
    inc edi
    jmp crit_3

swap:
    pop edx
    pop edi ; recuperez val de inceput a lui j
    pop ecx ; recuperez val de inceput a lui i
    
    xor esi, esi
    push esi
loop_swap:
    pop esi
    mov al, [ebx + ecx]
    mov dl, [ebx + edi]
    mov [ebx + ecx], dl
    mov [ebx + edi], al
    inc edi
    inc ecx
    inc esi
    push esi
    xor esi, request_size
    jnz loop_swap
    pop esi

    sub edi, request_size
    sub ecx, request_size
    push ecx
    push edi
    push edx

end_cmp:
    pop edx
    pop edi ; recuperez val de inceput a lui j
    pop ecx ; recuperez val de inceput a lui i
    sub edi, request_size
    jns second_loop

    sub ecx, request_size
    jnz first_loop

    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY