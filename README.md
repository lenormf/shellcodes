
# shellcodes

This repository contains a few AMD64 shellcodes, coded with nASM. As they have
been made purely for educational purposes, they might not be optimized to the
fullest, although some of the most current optimization techniques have clearly
been used.

Shellcodes available:
* `bindshell.S`: bind a shell (/bin/sh) to a socket
* `iptables_flush.S`: flush the iptables rules
* `off_aslr.S`: deactivate ASLR (write directly to `/proc/sys/kernel/randomize_va_space`)
* `off_aslr_sysctl.S`: deactivate ASLR (use sysctl)
* `shell.S`: spawn a shell (/bin/sh)

# the environment

The first thing to do when you've got your hands on the repository, is
source-ing the `env.source` file. This will export a few environment variables
that will be used in the repo's util scripts, as well as modify your PATH to
have access to those same scripts.

The options exported by the file are:
* compilation flags for nasm/gcc/ld
* the path to the directory in which the test binaries will be compiled
* the path to the "trampoline" file, in charge of loading a shellcode into
memory area, and execute it

# the scripts

The util scripts are located in the `sh` directory, and can be useful during
shellcode development:
* `sc_compile_source.bash`: compile a given shellcode to a binary using nasm
and ld (input: path to a .S file), and output the path to the binary
* `sc_compile_test.bash`: compile a given shellcode to a test binary (in the `test` directory) using the
trampoline file (input: path the a .S file)
* `sc_find_xor_range.py`: bruteforce the operands of a xor operation that will
result in a given number of a given size (input: size of the target number, and
the number)
* `sc_get_c_shellcode.bash`: extract the .text section into an hex-encoded C string using readelf (input: a binary)
* `sc_show_null_bytes.bash`: show the lines of code where null bytes will be
generated at compile-time, using objdump
* `sc_unpack_string.py`: pack a string into integers of a certain size (input:
size of the integers, the string)

# the documentation

All the shellcodes are more or less commented, and the `doc` folder contains
the official Intel instruction reference manual, and the ABI for x64 assembly.
