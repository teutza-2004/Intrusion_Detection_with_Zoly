section .rodata
	global sbox
	global num_rounds
	sbox db 126, 3, 45, 32, 174, 104, 173, 250, 46, 141, 209, 96, 230, 155, 197, 56, 19, 88, 50, 137, 229, 38, 16, 76, 37, 89, 55, 51, 165, 213, 66, 225, 118, 58, 142, 184, 148, 102, 217, 119, 249, 133, 105, 99, 161, 160, 190, 208, 172, 131, 219, 181, 248, 242, 93, 18, 112, 150, 186, 90, 81, 82, 215, 83, 21, 162, 144, 24, 117, 17, 14, 10, 156, 63, 238, 54, 188, 77, 169, 49, 147, 218, 177, 239, 143, 92, 101, 187, 221, 247, 140, 108, 94, 211, 252, 36, 75, 103, 5, 65, 251, 115, 246, 200, 125, 13, 48, 62, 107, 171, 205, 124, 199, 214, 224, 22, 27, 210, 179, 132, 201, 28, 236, 41, 243, 233, 60, 39, 183, 127, 203, 153, 255, 222, 85, 35, 30, 151, 130, 78, 109, 253, 64, 34, 220, 240, 159, 170, 86, 91, 212, 52, 1, 180, 11, 228, 15, 157, 226, 84, 114, 2, 231, 106, 8, 43, 23, 68, 164, 12, 232, 204, 6, 198, 33, 152, 227, 136, 29, 4, 121, 139, 59, 31, 25, 53, 73, 175, 178, 110, 193, 216, 95, 245, 61, 97, 71, 158, 9, 72, 194, 196, 189, 195, 44, 129, 154, 168, 116, 135, 7, 69, 120, 166, 20, 244, 192, 235, 223, 128, 98, 146, 47, 134, 234, 100, 237, 74, 138, 206, 149, 26, 40, 113, 111, 79, 145, 42, 191, 87, 254, 163, 167, 207, 185, 67, 57, 202, 123, 182, 176, 70, 241, 80, 122, 0
	num_rounds dd 10

section .text
	global treyfer_crypt
	global treyfer_dcrypt

; void treyfer_crypt(char text[8], char key[8]);
treyfer_crypt:
	;; DO NOT MODIFY
	push ebp
	mov ebp, esp
	pusha

	mov esi, [ebp + 8] ; plaintext
	mov edi, [ebp + 12] ; key	
	;; DO NOT MODIFY
	;; FREESTYLE STARTS HERE
	;; TODO implement treyfer_crypt

	mov edx, [num_rounds] ; pentru cele 10 runde
start_runda_e: ; loop pentru runde
	xor ecx, ecx ; pt a parcurge cei 8 bytes
	push ecx
bytes_e: ; loop pt block de 8 bytes
	pop ecx
	xor eax, eax ; zeroizez eax (eax este prectic t)
	mov al, [esi + ecx] ; copiez byte-ul i din text in eax
	add al, [edi + ecx] ; adun byte-ul i din key la eax
	mov al, [sbox + eax] ; pun in ebx valoarea sbox de la poz
	push ecx
	xor ecx, 7
	jz ultimul_e
	pop ecx
	add al, [esi + ecx + 1] ; byte-ul urmator
	rol al, 1 ; rotatie la stanga cu un bit
	mov [esi + ecx + 1], al
	jmp urmatorul_byte_e

ultimul_e:
	pop ecx
	add al, [esi] ; primul byte
	rol al, 1 ; rotatie la stanga cu un bit
	mov [esi], al
	
urmatorul_byte_e:	
	inc ecx
	push ecx
	xor ecx, 8
	jnz bytes_e

	pop ecx
	dec edx
	jnz start_runda_e

    ;; FREESTYLE ENDS HERE
	;; DO NOT MODIFY
	popa
	leave
	ret

; void treyfer_dcrypt(char text[8], char key[8]);
treyfer_dcrypt:
	;; DO NOT MODIFY
	push ebp
	mov ebp, esp
	pusha

	mov esi, [ebp + 8] ; plaintext
	mov edi, [ebp + 12] ; key	
	;; DO NOT MODIFY
	;; FREESTYLE STARTS HERE
	;; TODO implement treyfer_dcrypt

	mov edx, [num_rounds] ; pentru cele 10 runde
start_runda_d:
	mov ecx, 8 ; pt a parcurge cei 8 bytes
bytes_d:
	xor eax, eax ; zeroizez eax (eax este prectic t)
	xor ebx, ebx
	mov al, [esi + ecx - 1] ; copiez byte-ul i din text in eax
	add al, [edi + ecx - 1] ; adun byte-ul i din key la eax
	mov al, [sbox + eax] ; pun in eax valoarea sbox de la poz (eax este top)
	push ecx
	xor ecx, 8 ; verif daca e ultimul bit
	jz ultimul_d
	pop ecx
	mov bl, [esi + ecx] ; byte-ul urmator
	ror bl, 1 ; rotatie la stanga cu un bit (ebx este bottom)
	sub bl, al ; in eax ajunge bottom - top
	mov [esi + ecx], bl
	jmp urmatorul_byte_d

ultimul_d:
	pop ecx
	mov bl, [esi] ; byte-ul urmator
	ror bl, 1 ; rotatie la stanga cu un bit (ebx este bottom)
	sub bl, al ; in eax ajunge bottom - top
	mov [esi], bl
	
urmatorul_byte_d:	
	loop bytes_d

	dec edx
	jnz start_runda_d

	;; FREESTYLE ENDS HERE
	;; DO NOT MODIFY
	popa
	leave
	ret

