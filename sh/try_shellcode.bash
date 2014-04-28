#! /usr/bin/env bash
##
## try_shellcode.bash for shellcodes
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

		nasm "${SC_OPTIONS_NASM}" -o "${obj_output}" "${i}" || fatal "Unable to generate object file"

		local shellcode=$(shellcode_from_section.bash "${obj_output}" || fatal "Unable to get shellcode")

		local file_input_base="${i##*/}"
		local file_input_base_stripped="${file_input_base%.*}"
		local file_test_source="${SC_DIR_TEST}/test_${file_input_base_stripped}.c"
		local file_test_binary="${SC_DIR_TEST}/test_${file_input_base_stripped}"

		cp "${SC_FILE_TEST_TRAMPOLINE}" "${file_test_source}" || fatal "Unable to create source file"
		sed -i "s/#include \"shellcode.h\"/${shellcode//\\/\\\\}/g" "${file_test_source}" || fatal "Unable to inject shellcode into the source file"

		ld "${SC_OPTIONS_LD}" -o "${file_test_binary}" "${file_test_source}" || fatal "Unable to generate the test binary"

		echo "${file_test_binary}"
	done
}

test $# -lt 1 && fatal "Usage: $0 <assembly file> ..."

main "$@"
