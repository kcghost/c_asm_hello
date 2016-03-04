bits 64

section .data
msg db  'Hello, world!',0xa
len equ $ - msg

section .text

; The _start label is only needed for a standalone executable, but its presence
; does not affect the bin file
global _start
_start:

; Linux x86_64 sys_write call
; unsigned int fd
mov rdi,0x01

%ifdef STANDALONE
	; char *buf
	mov rsi,msg
%else
	; Get the instruction pointer and calculate the real location of msg in memory
	call _here
	_here:
	pop rsi
	add rsi,msg - (_here - $$)
%endif

; size_t count
mov rdx,len
; sys_write
mov rax,1
syscall

%ifdef STANDALONE
	; Linux x86_64 sys_exit call
	; int error_code
	mov rdi,0x00
	mov rax,60
	syscall
%else
	ret
%endif
