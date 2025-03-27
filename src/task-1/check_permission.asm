%include "../include/io.mac"

extern ant_permissions

extern printf
global check_permission

section .text

check_permission:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     eax, [ebp + 8]  ; id and permission
    mov     ebx, [ebp + 12] ; address to return the result
    ;; DO NOT MODIFY
   
    ;; Your code starts here

    mov edx, eax
    shr edx, 24 ; extrag id-ul furnicii

    xor edi, edi ; init edi cu 0
    mov ecx, [ant_permissions + edx * 4] ; extrag permisiunile furnicii curente
    shl eax, 8 ; shiftez pt a ramane numai cu lista salilor dorite
    shl ecx, 8 ; shiftez permisiunile pentru ca indicele salilor sa coincida
    
    and ecx, eax ; compar permisiunile cu salile dorite
    xor ecx, eax ; daca salile dorite coincid cu permisiunile aferente, rezultatul ar trebui sa dea 0
    jnz return
    inc edi ; edi=1 doar daca permisiunile coincid
    
return:
    mov [ebx], edi ; salvare rez la adresa sepecificata

    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
