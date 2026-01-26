	section .text
	jmp main.m0
	global main
main:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 12
	push esp
	pop dword [ebp+-4]
	push 3
	pop ebx
	push dword [ebp+-4]
	pop eax
	add eax, 0
	mov [eax], ebx
	push 2
	pop ebx
	push dword [ebp+-4]
	pop eax
	add eax, 4
	mov [eax], ebx
	push 1
	pop ebx
	push dword [ebp+-4]
	pop eax
	add eax, 8
	mov [eax], ebx
	push dword [ebp+-4]
	pop ebx
	add ebx, 0
	push dword [ebx]
	pop eax
	mov esp, ebp
	pop ebp
	ret
main.m0:
	section .rodata
