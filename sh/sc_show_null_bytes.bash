#! /usr/bin/env bash
##
## sc_show_null_bytes.bash for shellcodes
## by lenormf
##

function fatal {
	echo "$@" >&2
	exit 1
}

function main {
	for i in "$@"; do
		objdump -dMintel -j .text "${i}" | sed -r "s/\s+[a-z0-9]+:\s+//i; s/[a-z0-9]+\s+<\w+>://ig" | grep 00
	done
}

test $# -lt 1 && fatal "Usage: $0 <binary> ..."

main "$@"
