	section .text
	jmp main.m0
	global main
main:
	push ebp
	mov ebp, esp
	extern printf
	jmp fib.m6
	global fib
fib:
	push ebp
	mov ebp, esp
	push 2
	push dword [ebp+8]
	pop eax
	pop ebx
	cmp eax, ebx
	setl al
	movzx eax, al
	push eax
	test eax, eax
	jz fib.m19
	push dword [ebp+8]
	jmp fib.m11
fib.m19:
	push 2
	push dword [ebp+8]
	pop eax
	pop ebx
	sub eax, ebx
	push eax
	call fib
	add esp, 4
	push eax
	push 1
	push dword [ebp+8]
	pop eax
	pop ebx
	sub eax, ebx
	push eax
	call fib
	add esp, 4
	push eax
	pop eax
	pop ebx
	add eax, ebx
	push eax
fib.m11:
	pop eax
	mov esp, ebp
	pop ebp
	ret
fib.m6:
	push 10
	call fib
	add esp, 4
	push eax
	pop eax
	mov esp, ebp
	pop ebp
	ret
main.m0:
	section .rodata
