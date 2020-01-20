section .data
	SUCCESS		equ	0
	SYS_exit	equ	60
	NULL		equ	0
	x			dd 	10
	y			dd	10
	pthreadID0	dd	0,0,0,0,0
	myValue		dd	10
	MAX			dd	100
section .text
global _start
_start:

	; pthread_create(&pthreadIDO, NULL, &threadFunction0, NULL);
	mov		rdi,	pthreadID0
	mov		rsi,	NULL
	mov		rdx,	threadFunction0
	mov		rcx,	NULL
	call	threadFunction0

	; pthread_join (pthreadID0, NULL);
	mov		rdi,	qword [pthreadID0]
	mov		rsi,	NULL
	call 	threadFunction0

last:
	mov	rax,	SYS_exit
	mov	rdi,	SUCCESS
	syscall

global threadFunction0
threadFunction0:
; Perform MAX / 2 iterations to update myValue

	mov		rcx,	MAX
	shr		rcx,	1			; divide by 2
	mov		r10,	qword [x]
	mov		r11,	qword [y]
	
incLoop0:
	; myValue = (myValue / x) + y
	
	mov		rax,	qword [myValue]
	cqo
	div		r10
	add		rax,	r11
	mov		qword [myValue], rax
	loop 	incLoop0

	ret
