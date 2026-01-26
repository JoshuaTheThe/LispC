	section .text
	jmp main.m0
	global main
main:
	push ebp
	mov ebp, esp
	sub esp, 4
	push 10
	pop eax
	sub esp, eax
	push esp
	pop dword [ebp+-4]
	push 1
	push 0
	push dword [ebp+-4]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	push 0
	push dword [ebp+-4]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	pop eax
	mov esp, ebp
	pop ebp
	ret
main.m0:
	section .rodata
