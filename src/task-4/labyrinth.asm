%include "../include/io.mac"

extern printf
extern position
global solve_labyrinth

; you can declare any helper variables in .data or .bss

section .text

; void solve_labyrinth(int *out_line, int *out_col, int m, int n, char **labyrinth);
solve_labyrinth:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     eax, [ebp + 8]  ; unsigned int *out_line, pointer to structure containing exit position
    mov     ebx, [ebp + 12] ; unsigned int *out_col, pointer to structure containing exit position
    mov     ecx, [ebp + 16] ; unsigned int m, number of lines in the labyrinth
    mov     edx, [ebp + 20] ; unsigned int n, number of colons in the labyrinth
    mov     esi, [ebp + 24] ; char **a, matrix represantation of the labyrinth
    ;; DO NOT MODIFY
   
    ;; Freestyle starts here

    dec ecx ; oprirea se face cand linia = nr_linii - 1
    dec edx ; oprirea se face cand coloana = nr_coloane - 1
    
    mov edi, [esi] ; edi -> pointer la linie
    mov byte [edi], 0x31 ; edi -> elem: linie, coloana
    push eax ; salvez adresa lui *out_linie
    push ebx ; salvez adresa lui *out_coloana
    xor eax, eax ; linia 0
    xor ebx, ebx ; coloana 0
start_loop:
    push eax ; salvez linia
sus:
    mov edi, eax ; salvez linia in edi
    xor eax, 0
    jz jos
    xor eax, eax ; zeroizez eax
    dec edi ; linia anterioara
    mov edi, [esi + edi * 4] ; edi -> pointer la linie
    mov al, [edi + ebx] ; edi -> elem: linie, coloana
    xor al, 0x30 ; verific daca e 0
    jnz jos ; daca e 1 trec la celalalte verificari
    pop eax
    dec eax
    jmp verif_exit

jos:
    pop eax ; restaurez linia
    push eax ; salvez iar linia
    mov edi, eax ; salvez linia in edi
    xor eax, eax ; zeroizez eax
    inc edi ; linia urmatoare
    mov edi, [esi + edi * 4] ; edi -> pointer la linie
    mov al, [edi + ebx] ; edi -> elem: linie, coloana
    xor al, 0x30 ; verific daca e 0
    jnz stanga ; daca e 1 trec la celalalte verificari
    pop eax
    inc eax
    jmp verif_exit

stanga:
    pop eax ; restaurez eax
    push eax ; salvez iar eax
    push ebx ; salvez coloana

    mov edi, eax ; salvez linia in edi
    xor ebx, 0
    jz dreapta
    pop ebx
    push ebx
    dec ebx ; coloana anterioara
    mov edi, [esi + edi * 4] ; edi -> pointer la linie
    mov al, [edi + ebx] ; edi -> elem: linie, coloana
    xor al, 0x30 ; verific daca e 0
    jnz dreapta ; daca e 1 trec la celalalte verificari
    pop ebx
    dec ebx ; coloana anterioara
    pop eax
    jmp verif_exit

dreapta:
    pop ebx ; restaurez valoare coloana
    inc ebx ; coloana urmatoare
    pop eax
    jmp verif_exit

verif_exit:
    push ebx
    push eax
    xor eax, ecx ; verif capat pe linii
    jz return
    xor ebx, edx ; verif capat coloane
    jz return
    pop eax
    pop ebx
    mov edi, [esi + eax * 4] ; edi -> pointer la linie
    mov byte [edi + ebx], 0x31 ; marchez ca trecuta poz curenta
    jmp start_loop

return:
    pop ecx ; rezultatul liniei pt output
    pop edx ; rezultatul coloanei pt output
    pop ebx ; adresa coloanei
    pop eax ; adresa liniei
    mov [eax], ecx
    mov [ebx], edx

    ;; Freestyle ends here
end:
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
