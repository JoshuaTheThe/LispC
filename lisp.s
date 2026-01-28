	section .text
	extern printf
	extern memset
	extern strcmp
	extern fopen
	extern fclose
	extern fread
	extern exit
	jmp setup_keywords.m7
	global setup_keywords
setup_keywords:
	push ebp
	mov ebp, esp
	lea ebx, [_string_1]
	push ebx
	push 0
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_2]
	push ebx
	push 4
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_3]
	push ebx
	push 8
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_4]
	push ebx
	push 12
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_5]
	push ebx
	push 16
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_6]
	push ebx
	push 20
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_7]
	push ebx
	push 24
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_8]
	push ebx
	push 28
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_9]
	push ebx
	push 32
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_10]
	push ebx
	push 36
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_11]
	push ebx
	push 40
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_12]
	push ebx
	push 44
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_13]
	push ebx
	push 48
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_14]
	push ebx
	push 52
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_15]
	push ebx
	push 56
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_16]
	push ebx
	push 60
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_17]
	push ebx
	push 64
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_18]
	push ebx
	push 68
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_19]
	push ebx
	push 72
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_20]
	push ebx
	push 76
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_21]
	push ebx
	push 80
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_22]
	push ebx
	push 84
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_23]
	push ebx
	push 88
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	lea ebx, [_string_24]
	push ebx
	push 92
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	pop eax
	mov esp, ebp
	pop ebp
	ret
setup_keywords.m7:
	jmp is_alpha.m209
	global is_alpha
is_alpha:
	push ebp
	mov ebp, esp
	push 45
	push dword [ebp+8]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	push 95
	push dword [ebp+8]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	push 122
	push dword [ebp+8]
	pop eax
	pop ebx
	cmp eax, ebx
	setle al
	movzx eax, al
	push eax
	push 97
	push dword [ebp+8]
	pop eax
	pop ebx
	cmp eax, ebx
	setge al
	movzx eax, al
	push eax
	pop eax
	pop ebx
	and eax, ebx
	push eax
	push 90
	push dword [ebp+8]
	pop eax
	pop ebx
	cmp eax, ebx
	setle al
	movzx eax, al
	push eax
	push 65
	push dword [ebp+8]
	pop eax
	pop ebx
	cmp eax, ebx
	setge al
	movzx eax, al
	push eax
	pop eax
	pop ebx
	and eax, ebx
	push eax
	pop eax
	pop ebx
	or eax, ebx
	push eax
	pop eax
	pop ebx
	or eax, ebx
	push eax
	pop eax
	pop ebx
	or eax, ebx
	push eax
	pop eax
	mov esp, ebp
	pop ebp
	ret
is_alpha.m209:
	jmp get_identifier.m287
	global get_identifier
get_identifier:
	push ebp
	mov ebp, esp
	sub esp, 4
	push 255
	push dword [ebp+8]
	pop eax
	push dword [eax]
	pop eax
	pop ebx
	and eax, ebx
	push eax
	pop dword [ebp+-4]
	push 45
	push dword [ebp+-4]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz get_identifier.m0
	push 95
	jmp get_identifier.m1
get_identifier.m0:
	push dword [ebp+-4]
get_identifier.m1:
	pop dword [ebp+-4]
	push 1
	push dword [ebp+-4]
	call is_alpha
	add esp, 4
	push eax
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	push 31
	push dword [ebp+20]
	pop eax
	pop ebx
	cmp eax, ebx
	setl al
	movzx eax, al
	push eax
	pop eax
	pop ebx
	and eax, ebx
	push eax
	pop eax
	test eax, eax
	jz get_identifier.m2
	push dword [ebp+-4]
	push dword [ebp+20]
	push dword [ebp+16]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	push 1
	push dword [ebp+20]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	push dword [ebp+16]
	push dword [ebp+12]
	push 1
	push dword [ebp+8]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	call get_identifier
	add esp, 16
	push eax
	jmp get_identifier.m3
get_identifier.m2:
	push 0
	push dword [ebp+20]
	push dword [ebp+16]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	push dword [ebp+8]
get_identifier.m3:
	pop eax
	mov esp, ebp
	pop ebp
	ret
get_identifier.m287:
	jmp is_whitespace.m385
	global is_whitespace
is_whitespace:
	push ebp
	mov ebp, esp
	push 13
	push dword [ebp+8]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	push 10
	push dword [ebp+8]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	push 9
	push dword [ebp+8]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	push 32
	push dword [ebp+8]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	pop eax
	pop ebx
	or eax, ebx
	push eax
	pop eax
	pop ebx
	or eax, ebx
	push eax
	pop eax
	pop ebx
	or eax, ebx
	push eax
	pop eax
	mov esp, ebp
	pop ebp
	ret
is_whitespace.m385:
	jmp is_keyword.m439
	global is_keyword
is_keyword:
	push ebp
	mov ebp, esp
	push 4
	push 4
	push 25
	pop eax
	pop ebx
	mul ebx
	push eax
	pop eax
	pop ebx
	sub eax, ebx
	push eax
	push dword [ebp+16]
	pop eax
	pop ebx
	cmp eax, ebx
	setl al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz is_keyword.m4
	push 0
	push dword [ebp+12]
	push dword [ebp+16]
	push dword [ebp+8]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	call strcmp
	add esp, 8
	push eax
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz is_keyword.m6
	push 16
	push 4
	push dword [ebp+16]
	pop eax
	pop ebx
	cdq
	div ebx
	push eax
	pop eax
	pop ebx
	add eax, ebx
	push eax
	jmp is_keyword.m7
is_keyword.m6:
	push 4
	push dword [ebp+16]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	push dword [ebp+12]
	push dword [ebp+8]
	call is_keyword
	add esp, 12
	push eax
is_keyword.m7:
	jmp is_keyword.m5
is_keyword.m4:
	push 3
is_keyword.m5:
	pop eax
	mov esp, ebp
	pop ebp
	ret
is_keyword.m439:
	jmp is_numeric.m520
	global is_numeric
is_numeric:
	push ebp
	mov ebp, esp
	push 57
	push dword [ebp+8]
	pop eax
	pop ebx
	cmp eax, ebx
	setle al
	movzx eax, al
	push eax
	push 48
	push dword [ebp+8]
	pop eax
	pop ebx
	cmp eax, ebx
	setge al
	movzx eax, al
	push eax
	pop eax
	pop ebx
	and eax, ebx
	push eax
	pop eax
	mov esp, ebp
	pop ebp
	ret
is_numeric.m520:
	jmp get_number.m550
	global get_number
get_number:
	push ebp
	mov ebp, esp
	sub esp, 4
	push 255
	push dword [ebp+8]
	pop eax
	push dword [eax]
	pop eax
	pop ebx
	and eax, ebx
	push eax
	pop dword [ebp+-4]
	push 1
	push dword [ebp+-4]
	call is_numeric
	add esp, 4
	push eax
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	push 31
	push dword [ebp+20]
	pop eax
	pop ebx
	cmp eax, ebx
	setl al
	movzx eax, al
	push eax
	pop eax
	pop ebx
	and eax, ebx
	push eax
	pop eax
	test eax, eax
	jz get_number.m8
	push dword [ebp+-4]
	push dword [ebp+20]
	push dword [ebp+16]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	push 1
	push dword [ebp+20]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	push dword [ebp+16]
	push dword [ebp+12]
	push 1
	push dword [ebp+8]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	call get_number
	add esp, 16
	push eax
	jmp get_number.m9
get_number.m8:
	push 0
	push dword [ebp+20]
	push dword [ebp+16]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	push dword [ebp+8]
get_number.m9:
	pop eax
	mov esp, ebp
	pop ebp
	ret
get_number.m550:
	jmp decode_sub.m631
	global decode_sub
decode_sub:
	push ebp
	mov ebp, esp
	push 110
	push dword [ebp+8]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz decode_sub.m10
	push 10
	jmp decode_sub.m11
decode_sub.m10:
	push 116
	push dword [ebp+8]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz decode_sub.m12
	push 9
	jmp decode_sub.m13
decode_sub.m12:
	push dword [ebp+8]
decode_sub.m13:
decode_sub.m11:
	pop eax
	mov esp, ebp
	pop ebp
	ret
decode_sub.m631:
	jmp get_string.m672
	global get_string
get_string:
	push ebp
	mov ebp, esp
	sub esp, 4
	push 255
	push dword [ebp+8]
	pop eax
	push dword [eax]
	pop eax
	pop ebx
	and eax, ebx
	push eax
	pop dword [ebp+-4]
	push 34
	push dword [ebp+-4]
	pop eax
	pop ebx
	cmp eax, ebx
	setne al
	movzx eax, al
	push eax
	push 31
	push dword [ebp+20]
	pop eax
	pop ebx
	cmp eax, ebx
	setl al
	movzx eax, al
	push eax
	pop eax
	pop ebx
	and eax, ebx
	push eax
	pop eax
	test eax, eax
	jz get_string.m14
	push 92
	push dword [ebp+-4]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz get_string.m16
	push 255
	push 1
	push dword [ebp+8]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	pop eax
	push dword [eax]
	pop eax
	pop ebx
	and eax, ebx
	push eax
	pop dword [ebp+-4]
	push dword [ebp+-4]
	call decode_sub
	add esp, 4
	push eax
	push dword [ebp+20]
	push dword [ebp+16]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	push 1
	push dword [ebp+20]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	push dword [ebp+16]
	push dword [ebp+12]
	push 2
	push dword [ebp+8]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	call get_string
	add esp, 16
	push eax
	jmp get_string.m17
get_string.m16:
	push dword [ebp+-4]
	push dword [ebp+20]
	push dword [ebp+16]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	push 1
	push dword [ebp+20]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	push dword [ebp+16]
	push dword [ebp+12]
	push 1
	push dword [ebp+8]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	call get_string
	add esp, 16
	push eax
get_string.m17:
	jmp get_string.m15
get_string.m14:
	push 0
	push dword [ebp+20]
	push dword [ebp+16]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	push 1
	push dword [ebp+8]
	pop eax
	pop ebx
	add eax, ebx
	push eax
get_string.m15:
	pop eax
	mov esp, ebp
	pop ebp
	ret
get_string.m672:
	jmp get_comment.m810
	global get_comment
get_comment:
	push ebp
	mov ebp, esp
	sub esp, 4
	push 255
	push dword [ebp+8]
	pop eax
	push dword [eax]
	pop eax
	pop ebx
	and eax, ebx
	push eax
	pop dword [ebp+-4]
	push 13
	push dword [ebp+-4]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	push 10
	push dword [ebp+-4]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	pop eax
	pop ebx
	or eax, ebx
	push eax
	pop eax
	test eax, eax
	jz get_comment.m18
	push dword [ebp+8]
	jmp get_comment.m19
get_comment.m18:
	push 1
	push dword [ebp+8]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	call get_comment
	add esp, 4
	push eax
get_comment.m19:
	pop eax
	mov esp, ebp
	pop ebp
	ret
get_comment.m810:
	jmp get_token.m866
	global get_token
get_token:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	push 32
	push 0
	push dword [ebp+16]
	call memset
	add esp, 12
	push eax
	push 255
	push dword [ebp+8]
	pop eax
	push dword [eax]
	pop eax
	pop ebx
	and eax, ebx
	push eax
	pop dword [ebp+-8]
	push 0
	pop dword [ebp+-4]
	push 59
	push dword [ebp+-8]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz get_token.m20
	push dword [ebp+20]
	push dword [ebp+16]
	push dword [ebp+12]
	push dword [ebp+8]
	call get_comment
	add esp, 4
	push eax
	call get_token
	add esp, 16
	push eax
	pop dword [ebp+-4]
	jmp get_token.m21
get_token.m20:
	push 1
	push dword [ebp+-8]
	call is_numeric
	add esp, 4
	push eax
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz get_token.m22
	push 4
	pop dword [ebp+-4]
	push 0
	push dword [ebp+16]
	push dword [ebp+12]
	push dword [ebp+8]
	call get_number
	add esp, 16
	push eax
	push 0
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	jmp get_token.m23
get_token.m22:
	push 34
	push dword [ebp+-8]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz get_token.m24
	push 5
	pop dword [ebp+-4]
	push 0
	push dword [ebp+16]
	push dword [ebp+12]
	push 1
	push dword [ebp+8]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	call get_string
	add esp, 16
	push eax
	push 0
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	jmp get_token.m25
get_token.m24:
	push 40
	push dword [ebp+-8]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz get_token.m26
	push 1
	pop dword [ebp+-4]
	push 1
	push dword [ebp+8]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	push 0
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	jmp get_token.m27
get_token.m26:
	push 41
	push dword [ebp+-8]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz get_token.m28
	push 2
	pop dword [ebp+-4]
	push 1
	push dword [ebp+8]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	push 0
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	jmp get_token.m29
get_token.m28:
	push 1
	push dword [ebp+-8]
	call is_alpha
	add esp, 4
	push eax
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz get_token.m30
	push 0
	push dword [ebp+16]
	push dword [ebp+12]
	push dword [ebp+8]
	call get_identifier
	add esp, 16
	push eax
	push 0
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	push 0
	push dword [ebp+16]
	push dword [ebp+12]
	call is_keyword
	add esp, 12
	push eax
	pop dword [ebp+-4]
	jmp get_token.m31
get_token.m30:
	push 1
	push dword [ebp+-8]
	call is_whitespace
	add esp, 4
	push eax
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz get_token.m32
	push dword [ebp+20]
	push dword [ebp+16]
	push dword [ebp+12]
	push 1
	push dword [ebp+8]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	call get_token
	add esp, 16
	push eax
	pop dword [ebp+-4]
	jmp get_token.m33
get_token.m32:
get_token.m33:
get_token.m31:
get_token.m29:
get_token.m27:
get_token.m25:
get_token.m23:
get_token.m21:
	push dword [ebp+-4]
	pop eax
	mov esp, ebp
	pop ebp
	ret
get_token.m866:
	jmp hash_iter.m1110
	global hash_iter
hash_iter:
	push ebp
	mov ebp, esp
	push 0
	push dword [ebp+12]
	push dword [ebp+8]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	pop eax
	push dword [eax]
	pop eax
	pop ebx
	cmp eax, ebx
	setne al
	movzx eax, al
	push eax
	push 16
	push dword [ebp+12]
	pop eax
	pop ebx
	cmp eax, ebx
	setl al
	movzx eax, al
	push eax
	pop eax
	pop ebx
	and eax, ebx
	push eax
	pop eax
	test eax, eax
	jz hash_iter.m34
	push dword [ebp+12]
	push dword [ebp+8]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	pop eax
	push dword [eax]
	push 1
	push dword [ebp+12]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	push dword [ebp+16]
	pop eax
	pop ebx
	mul ebx
	push eax
	pop eax
	pop ebx
	add eax, ebx
	push eax
	push 1
	push dword [ebp+12]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	push dword [ebp+8]
	call hash_iter
	add esp, 12
	push eax
	jmp hash_iter.m35
hash_iter.m34:
	push dword [ebp+16]
hash_iter.m35:
	pop eax
	mov esp, ebp
	pop ebp
	ret
hash_iter.m1110:
	jmp hash.m1187
	global hash
hash:
	push ebp
	mov ebp, esp
	push 0
	push 0
	push dword [ebp+8]
	call hash_iter
	add esp, 12
	push eax
	pop eax
	mov esp, ebp
	pop ebp
	ret
hash.m1187:
	jmp parse_declaration_arguments.m1203
	global parse_declaration_arguments
parse_declaration_arguments:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	push 32
	pop eax
	sub esp, eax
	push esp
	pop dword [ebp+-4]
	push dword [ebp+20]
	push dword [ebp+-4]
	push dword [ebp+12]
	push 0
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	call get_token
	add esp, 16
	push eax
	pop dword [ebp+-8]
	push 3
	push dword [ebp+-8]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz parse_declaration_arguments.m36
	push dword [ebp+-4]
	call hash
	add esp, 4
	push eax
	push dword [ebp+32]
	push dword [ebp+24]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	push dword [ebp+36]
	push dword [ebp+32]
	push dword [ebp+28]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	push 4
	push dword [ebp+36]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	push 4
	push dword [ebp+32]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	push dword [ebp+28]
	push dword [ebp+24]
	push dword [ebp+20]
	push dword [ebp+16]
	push dword [ebp+12]
	push 0
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	call parse_declaration_arguments
	add esp, 32
	push eax
	jmp parse_declaration_arguments.m37
parse_declaration_arguments.m36:
parse_declaration_arguments.m37:
	pop eax
	mov esp, ebp
	pop ebp
	ret
parse_declaration_arguments.m1203:
	jmp parse_end.m1290
	global parse_end
parse_end:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	push 4
	pop eax
	sub esp, eax
	push esp
	pop dword [ebp+-8]
	push dword [ebp+-8]
	push dword [ebp+16]
	push dword [ebp+12]
	push 0
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	call get_token
	add esp, 16
	push eax
	pop dword [ebp+-4]
	push 2
	push dword [ebp+-4]
	pop eax
	pop ebx
	cmp eax, ebx
	setne al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz parse_end.m38
	push dword [ebp+28]
	push dword [ebp+24]
	push dword [ebp+20]
	push dword [ebp+16]
	push dword [ebp+12]
	push 0
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	call parse_primary
	add esp, 24
	push eax
	push 1
	push dword [ebp+32]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	push dword [ebp+28]
	push dword [ebp+24]
	push dword [ebp+20]
	push dword [ebp+16]
	push dword [ebp+12]
	push 0
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	call parse_end
	add esp, 28
	push eax
	jmp parse_end.m39
parse_end.m38:
	push dword [ebp+20]
	push dword [ebp+16]
	push dword [ebp+12]
	push 0
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	call get_token
	add esp, 16
	push eax
	pop dword [ebp+-4]
	push dword [ebp+32]
parse_end.m39:
	pop eax
	mov esp, ebp
	pop ebp
	ret
parse_end.m1290:
	jmp parse_nested.m1382
	global parse_nested
parse_nested:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	push 1024
	pop eax
	sub esp, eax
	push esp
	pop dword [ebp+-16]
	push 1024
	pop eax
	sub esp, eax
	push esp
	pop dword [ebp+-20]
	push 32
	pop eax
	sub esp, eax
	push esp
	pop dword [ebp+-12]
	push dword [ebp+20]
	push dword [ebp+-12]
	push dword [ebp+12]
	push 0
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	call get_token
	add esp, 16
	push eax
	pop dword [ebp+-4]
	push 16
	push dword [ebp+-4]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz parse_nested.m40
	push dword [ebp+20]
	push dword [ebp+-12]
	push dword [ebp+12]
	push 0
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	call get_token
	add esp, 16
	push eax
	pop dword [ebp+-8]
	push 3
	push dword [ebp+-8]
	pop eax
	pop ebx
	cmp eax, ebx
	setne al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz parse_nested.m42
	lea ebx, [_string_25]
	push ebx
	call printf
	add esp, 4
	push eax
	push 1
	call exit
	add esp, 4
	push eax
	jmp parse_nested.m43
parse_nested.m42:
parse_nested.m43:
	push dword [ebp+-12]
	lea ebx, [_string_26]
	push ebx
	call printf
	add esp, 8
	push eax
	push dword [ebp+-12]
	lea ebx, [_string_27]
	push ebx
	call printf
	add esp, 8
	push eax
	lea ebx, [_string_28]
	push ebx
	call printf
	add esp, 4
	push eax
	lea ebx, [_string_29]
	push ebx
	call printf
	add esp, 4
	push eax
	push 4
	push 0
	push dword [ebp+-20]
	push dword [ebp+-16]
	push dword [ebp+20]
	push dword [ebp+16]
	push dword [ebp+12]
	push dword [ebp+8]
	call parse_declaration_arguments
	add esp, 32
	push eax
	push 0
	push dword [ebp+-20]
	push dword [ebp+-16]
	push dword [ebp+20]
	push dword [ebp+16]
	push dword [ebp+12]
	push dword [ebp+8]
	call parse_end
	add esp, 28
	push eax
	push dword [ebp+-12]
	lea ebx, [_string_30]
	push ebx
	call printf
	add esp, 8
	push eax
	lea ebx, [_string_31]
	push ebx
	call printf
	add esp, 4
	push eax
	lea ebx, [_string_32]
	push ebx
	call printf
	add esp, 4
	push eax
	lea ebx, [_string_33]
	push ebx
	call printf
	add esp, 4
	push eax
	lea ebx, [_string_34]
	push ebx
	call printf
	add esp, 4
	push eax
	jmp parse_nested.m41
parse_nested.m40:
parse_nested.m41:
	push 17
	push dword [ebp+-4]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz parse_nested.m44
	push 4
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	pop dword [ebp+-28]
	push 1
	push 4
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	push 4
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	push 4
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	pop dword [ebp+-32]
	push 1
	push 4
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	push 4
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	push 4
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	pop dword [ebp+-36]
	push 1
	push 4
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	pop eax
	pop ebx
	add eax, ebx
	push eax
	push 4
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	push 0
	push dword [ebp+-20]
	push dword [ebp+-16]
	push dword [ebp+20]
	push dword [ebp+16]
	push dword [ebp+12]
	push 0
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	call parse_primary
	add esp, 28
	push eax
	lea ebx, [_string_35]
	push ebx
	call printf
	add esp, 4
	push eax
	lea ebx, [_string_36]
	push ebx
	call printf
	add esp, 4
	push eax
	push dword [ebp+-36]
	lea ebx, [_string_37]
	push ebx
	call printf
	add esp, 8
	push eax
	push dword [ebp+-28]
	lea ebx, [_string_38]
	push ebx
	call printf
	add esp, 8
	push eax
	push 0
	push dword [ebp+-20]
	push dword [ebp+-16]
	push dword [ebp+20]
	push dword [ebp+16]
	push dword [ebp+12]
	push 0
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	call parse_primary
	add esp, 28
	push eax
	push dword [ebp+-32]
	lea ebx, [_string_39]
	push ebx
	call printf
	add esp, 8
	push eax
	push dword [ebp+-36]
	lea ebx, [_string_40]
	push ebx
	call printf
	add esp, 8
	push eax
	push 0
	push dword [ebp+-20]
	push dword [ebp+-16]
	push dword [ebp+20]
	push dword [ebp+16]
	push dword [ebp+12]
	push dword [ebp+8]
	call parse_end
	add esp, 28
	push eax
	push dword [ebp+-32]
	lea ebx, [_string_41]
	push ebx
	call printf
	add esp, 8
	push eax
	jmp parse_nested.m45
parse_nested.m44:
	push 3
	push dword [ebp+-4]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz parse_nested.m46
	push 0
	push dword [ebp+-20]
	push dword [ebp+-16]
	push dword [ebp+20]
	push dword [ebp+16]
	push dword [ebp+12]
	push dword [ebp+8]
	call parse_end
	add esp, 28
	push eax
	pop dword [ebp+-24]
	push dword [ebp+-12]
	lea ebx, [_string_42]
	push ebx
	call printf
	add esp, 8
	push eax
	push 4
	push dword [ebp+-24]
	pop eax
	pop ebx
	mul ebx
	push eax
	lea ebx, [_string_43]
	push ebx
	call printf
	add esp, 8
	push eax
	jmp parse_nested.m47
parse_nested.m46:
	push 0
	push dword [ebp+-20]
	push dword [ebp+-16]
	push dword [ebp+20]
	push dword [ebp+16]
	push dword [ebp+12]
	push 0
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	call parse_end
	add esp, 28
	push eax
parse_nested.m47:
parse_nested.m45:
	pop eax
	mov esp, ebp
	pop ebp
	ret
parse_nested.m1382:
	jmp parse_primary.m1771
	global parse_primary
parse_primary:
	push ebp
	mov ebp, esp
	sub esp, 4
	push dword [ebp+20]
	push dword [ebp+16]
	push dword [ebp+12]
	push 0
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	call get_token
	add esp, 16
	push eax
	pop dword [ebp+-4]
	push 4
	push dword [ebp+-4]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz parse_primary.m48
	push dword [ebp+16]
	lea ebx, [_string_44]
	push ebx
	call printf
	add esp, 8
	push eax
	jmp parse_primary.m49
parse_primary.m48:
parse_primary.m49:
	push 3
	push dword [ebp+-4]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz parse_primary.m50
	push dword [ebp+16]
	lea ebx, [_string_45]
	push ebx
	call printf
	add esp, 8
	push eax
	jmp parse_primary.m51
parse_primary.m50:
parse_primary.m51:
	push 1
	push dword [ebp+-4]
	pop eax
	pop ebx
	cmp eax, ebx
	sete al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz parse_primary.m52
	push dword [ebp+20]
	push dword [ebp+16]
	push dword [ebp+12]
	push 0
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	call parse_nested
	add esp, 16
	push eax
	jmp parse_primary.m53
parse_primary.m52:
parse_primary.m53:
	pop eax
	mov esp, ebp
	pop ebp
	ret
parse_primary.m1771:
	jmp main.m1861
	global main
main:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	push 65536
	pop eax
	sub esp, eax
	push esp
	pop dword [ebp+-28]
	push 4
	push 26
	pop eax
	pop ebx
	mul ebx
	push eax
	pop dword [ebp+-16]
	push dword [ebp+-16]
	pop eax
	sub esp, eax
	push esp
	pop dword [ebp+-4]
	push 32
	pop eax
	sub esp, eax
	push esp
	pop dword [ebp+-8]
	push 8
	pop eax
	sub esp, eax
	push esp
	pop dword [ebp+-20]
	push 0
	pop dword [ebp+-24]
	push 0
	push 4
	push dword [ebp+-20]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	push 1
	push dword [ebp+8]
	pop eax
	pop ebx
	cmp eax, ebx
	setg al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz main.m54
	lea ebx, [_string_46]
	push ebx
	push 4
	push dword [ebp+12]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	call fopen
	add esp, 8
	push eax
	pop dword [ebp+-24]
	push dword [ebp+-24]
	push 65536
	push 1
	push dword [ebp+-28]
	call fread
	add esp, 16
	push eax
	push dword [ebp+-28]
	pop dword [ebp+-12]
	jmp main.m55
main.m54:
	lea ebx, [_string_47]
	push ebx
	pop dword [ebp+-12]
main.m55:
	push dword [ebp+-12]
	push 0
	push dword [ebp+-20]
	pop edx
	pop ebx
	add ebx, edx
	pop dword [ebx]
	push dword [ebp+-4]
	call setup_keywords
	add esp, 4
	push eax
	jmp mainloop.m1958
	global mainloop
mainloop:
	push ebp
	mov ebp, esp
	sub esp, 4
	push dword [ebp+20]
	push dword [ebp+16]
	push dword [ebp+12]
	push dword [ebp+8]
	call get_token
	add esp, 16
	push eax
	pop dword [ebp+-4]
	push dword [ebp+16]
	push dword [ebp+-4]
	lea ebx, [_string_48]
	push ebx
	call printf
	add esp, 12
	push eax
	push 0
	push dword [ebp+-4]
	pop eax
	pop ebx
	cmp eax, ebx
	setne al
	movzx eax, al
	push eax
	pop eax
	test eax, eax
	jz mainloop.m56
	push dword [ebp+20]
	push dword [ebp+16]
	push dword [ebp+12]
	push 0
	push dword [ebp+20]
	pop edx
	pop ebx
	add ebx, edx
	push dword [ebx]
	call mainloop
	add esp, 16
	push eax
	jmp mainloop.m57
mainloop.m56:
mainloop.m57:
	pop eax
	mov esp, ebp
	pop ebp
	ret
mainloop.m1958:
	push 0
	push 0
	push dword [ebp+-20]
	push dword [ebp+-8]
	push dword [ebp+-4]
	push dword [ebp+-12]
	call parse_primary
	add esp, 24
	push eax
	push dword [ebp+-24]
	pop eax
	test eax, eax
	jz main.m58
	push dword [ebp+-24]
	call fclose
	add esp, 4
	push eax
	jmp main.m59
main.m58:
main.m59:
	pop eax
	mov esp, ebp
	pop ebp
	ret
main.m1861:
	section .rodata
_string_1:
	db 102
	db 110
	db 0
_string_2:
	db 105
	db 102
	db 0
_string_3:
	db 100
	db 101
	db 99
	db 108
	db 97
	db 114
	db 101
	db 0
_string_4:
	db 115
	db 116
	db 114
	db 117
	db 99
	db 116
	db 0
_string_5:
	db 115
	db 101
	db 116
	db 0
_string_6:
	db 97
	db 100
	db 100
	db 0
_string_7:
	db 115
	db 117
	db 98
	db 0
_string_8:
	db 109
	db 117
	db 108
	db 0
_string_9:
	db 100
	db 105
	db 118
	db 0
_string_10:
	db 109
	db 111
	db 100
	db 0
_string_11:
	db 101
	db 113
	db 0
_string_12:
	db 110
	db 101
	db 113
	db 0
_string_13:
	db 108
	db 116
	db 0
_string_14:
	db 103
	db 116
	db 0
_string_15:
	db 108
	db 116
	db 101
	db 0
_string_16:
	db 103
	db 116
	db 101
	db 0
_string_17:
	db 100
	db 101
	db 114
	db 101
	db 102
	db 0
_string_18:
	db 115
	db 101
	db 116
	db 45
	db 100
	db 101
	db 114
	db 101
	db 102
	db 0
_string_19:
	db 97
	db 110
	db 100
	db 0
_string_20:
	db 111
	db 114
	db 0
_string_21:
	db 120
	db 111
	db 114
	db 0
_string_22:
	db 110
	db 111
	db 116
	db 0
_string_23:
	db 97
	db 108
	db 108
	db 111
	db 99
	db 97
	db 0
_string_24:
	db 101
	db 120
	db 116
	db 101
	db 114
	db 110
	db 0
_string_25:
	db 84
	db 104
	db 101
	db 32
	db 70
	db 117
	db 99
	db 107
	db 32
	db 68
	db 105
	db 100
	db 32
	db 89
	db 111
	db 117
	db 32
	db 68
	db 111
	db 63
	db 10
	db 0
_string_26:
	db 9
	db 103
	db 108
	db 111
	db 98
	db 97
	db 108
	db 32
	db 37
	db 115
	db 10
	db 0
_string_27:
	db 37
	db 115
	db 58
	db 10
	db 0
_string_28:
	db 9
	db 112
	db 117
	db 115
	db 104
	db 32
	db 101
	db 98
	db 112
	db 10
	db 0
_string_29:
	db 9
	db 109
	db 111
	db 118
	db 32
	db 101
	db 98
	db 112
	db 44
	db 32
	db 101
	db 115
	db 112
	db 10
	db 0
_string_30:
	db 37
	db 115
	db 46
	db 101
	db 110
	db 100
	db 58
	db 10
	db 0
_string_31:
	db 9
	db 112
	db 111
	db 112
	db 32
	db 101
	db 97
	db 120
	db 10
	db 0
_string_32:
	db 9
	db 109
	db 111
	db 118
	db 32
	db 101
	db 115
	db 112
	db 44
	db 32
	db 101
	db 98
	db 112
	db 10
	db 0
_string_33:
	db 9
	db 112
	db 111
	db 112
	db 32
	db 101
	db 98
	db 112
	db 10
	db 0
_string_34:
	db 9
	db 114
	db 101
	db 116
	db 10
	db 0
_string_35:
	db 9
	db 112
	db 111
	db 112
	db 32
	db 101
	db 97
	db 120
	db 10
	db 0
_string_36:
	db 9
	db 116
	db 101
	db 115
	db 116
	db 32
	db 101
	db 97
	db 120
	db 44
	db 32
	db 101
	db 97
	db 120
	db 10
	db 0
_string_37:
	db 9
	db 106
	db 122
	db 32
	db 109
	db 37
	db 100
	db 10
	db 0
_string_38:
	db 109
	db 37
	db 100
	db 58
	db 10
	db 0
_string_39:
	db 9
	db 106
	db 109
	db 112
	db 32
	db 109
	db 37
	db 100
	db 10
	db 0
_string_40:
	db 109
	db 37
	db 100
	db 58
	db 10
	db 0
_string_41:
	db 109
	db 37
	db 100
	db 58
	db 10
	db 0
_string_42:
	db 9
	db 99
	db 97
	db 108
	db 108
	db 32
	db 37
	db 115
	db 10
	db 0
_string_43:
	db 9
	db 97
	db 100
	db 100
	db 32
	db 101
	db 115
	db 112
	db 44
	db 32
	db 37
	db 100
	db 10
	db 0
_string_44:
	db 9
	db 112
	db 117
	db 115
	db 104
	db 32
	db 37
	db 115
	db 10
	db 0
_string_45:
	db 9
	db 112
	db 117
	db 115
	db 104
	db 32
	db 37
	db 115
	db 10
	db 0
_string_46:
	db 114
	db 0
_string_47:
	db 40
	db 102
	db 110
	db 32
	db 109
	db 97
	db 105
	db 110
	db 32
	db 97
	db 32
	db 98
	db 32
	db 99
	db 32
	db 40
	db 40
	db 105
	db 102
	db 32
	db 51
	db 32
	db 50
	db 32
	db 49
	db 41
	db 41
	db 41
	db 0
_string_48:
	db 84
	db 111
	db 107
	db 101
	db 110
	db 58
	db 32
	db 37
	db 100
	db 32
	db 73
	db 100
	db 58
	db 32
	db 39
	db 37
	db 115
	db 39
	db 10
	db 0
