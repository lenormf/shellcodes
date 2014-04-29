#! /usr/bin/env bash
##
## sc_compile_test.bash for shellcodes
## by lenormf
##

function fatal {
	echo "$@" >&2
	exit 1
}

function main {
	for i in "$@"; do
		test -f "${i}" || fatal "No such file: ${i}"

		local obj_output=$(mktemp)

		nasm ${SC_OPTIONS_NASM} -o "${obj_output}" "${i}" || fatal "Unable to generate object file"

		local shellcode=$(sc_get_c_shellcode.bash "${obj_output}" | tr '\n' ' ' || exit 1)
		
		test $? -eq 0 || fatal "Unable to get shellcode"

		local file_input_base="${i##*/}"
		local file_input_base_stripped="${file_input_base%.*}"
		local file_test_source="${SC_DIR_TEST}/test_${file_input_base_stripped}.c"
		local file_test_binary="${SC_DIR_TEST}/test_${file_input_base_stripped}"

		cp "${SC_FILE_TEST_TRAMPOLINE}" "${file_test_source}" || fatal "Unable to create source file"
		sed -i "s/#include \"shellcode.h\"/${shellcode//\\/\\\\}/g" "${file_test_source}" || fatal "Unable to inject shellcode into the source file"

		gcc ${SC_OPTIONS_GCC} -o "${file_test_binary}" "${file_test_source}" || fatal "Unable to generate test"

		echo "${file_test_binary}"
	done
}

test $# -lt 1 && fatal "Usage: $0 <assembly file> ..."

main "$@"
