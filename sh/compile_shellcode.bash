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

		local obj=$(mktemp)
		local out=$(mktemp)

		test -z "${obj}" -o -z "${out}" && fatal "Unable to create temporary objects"

		nasm "${SC_OPTIONS_NASM}" -o "${obj}" "$i" || fatal "Unable to generate object"

		ld "${SC_OPTIONS_LD}" -o "${out}" "${obj}" || fatal "Unable to link objects"

		rm -f "${obj}"

		echo "${out}"
	done
}

test $# -lt 1 && fatal "Usage: $0 <assembly file> ..."

main "$@"
