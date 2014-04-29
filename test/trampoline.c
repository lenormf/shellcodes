/*
 * trampoline.c for shellcodes
 * by lenormf
 */

#include <stdio.h>
#include <stddef.h>
#include <string.h>
#include <sys/mman.h>

char const shellcode[] = {
#include "shellcode.h"
};

int main(void) {
	void (*f)();

	/* Allocate a private anonymous buffer */
	f = mmap(NULL, sizeof(shellcode), PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	if (MAP_FAILED == f)
		return 1;

	/* Copy the payload over to the buffer */
	memcpy(f, shellcode, sizeof(shellcode));

	/* Print the size of the shellcode */
	printf("Shellcode size: %lu\n", sizeof(shellcode));

	/* Execute the shellcode */
	f();

	/* Free the mapped area */
	munmap((void*)f, sizeof(shellcode));

	return 0;
}
