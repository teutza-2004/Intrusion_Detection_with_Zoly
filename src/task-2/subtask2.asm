%include "../include/io.mac"

; declare your structs here

struc request
    admin: resb 1
    prio: resb 1
    passkey: resw 1
    username: resb 51
endstruc

section .text
    global check_passkeys
    extern printf

check_passkeys:
    ;; DO NOT MODIFY
    enter 0, 0
    pusha

    mov ebx, [ebp + 8]      ; requests
    mov ecx, [ebp + 12]     ; length
    mov eax, [ebp + 16]     ;
    ;; DO NOT MODIFY

    ;; Your code starts here

    push eax
    mov edi, ecx ; tin minte pozitia curenta in structura in edi
    ; fac ecx sa fie egal cu lungimea sirului * lungimea elementului
    dec ecx
    mov eax, ecx
    mov esi, request_size
    mul esi
    mov ecx, eax
    pop eax

big_loop:
    push edi
    mov byte [eax + edi - 1], 0x0 ; fac 0 toate elementele din vector
    xor edx, edx ; zeriozez edx
    mov dx, [ebx + ecx + 2] ; salvez in edx passkey-ul curent
    test edx, 1 ; verific daca ultimul bit este 1
    jz fin_loop
    test edx, 0x8000 ; verific daca primul bit este 1
    jz fin_loop
    shr edx, 1

    xor esi, esi ; contor pt iteratia in passkey
    xor edi, edi ; numara cati de 1 sunt in cei 7 biti
    mov esi, 7
passkey_loop1:
    test edx, 1
    jz fin_loop1
    inc edi
fin_loop1:
    shr edx, 1
    dec esi
    jnz passkey_loop1
    test edi, 1 ; verific daca nr este par
    jnz fin_loop

    xor esi, esi ; contor pt iteratia in passkey
    xor edi, edi ; numara cati de 1 sunt in cei 7 biti
    mov esi, 7
passkey_loop2:
    test edx, 1
    jz fin_loop2
    inc edi
fin_loop2:
    shr edx, 1
    dec esi
    jnz passkey_loop2
    test edi, 1 ; verific daca nr este impar
    jz fin_loop

    pop edi
    mov byte [eax + edi - 1], 0x1
    push edi

fin_loop:
    pop edi
    dec edi
    sub ecx, request_size
    jns big_loop

    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY