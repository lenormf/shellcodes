#! /usr/bin/env bash
##
## sc_get_c_shellcode.bash for shellcodes
## by lenormf
##

function fatal {
	echo "$@" >&2
	exit 1
}

function main {
	for i in "$@"; do
		readelf -x .text "${i}" | sed -r '1,2 d; $ d; s/\s+0x[a-f0-9]+((\s+[a-f0-9]{2,8}){1,4}).+/\1/ig; s/([a-f0-9]{2})/\\x\1/ig; s/ //g; s/^|$/"/g' || fatal "Unable to read the .text section"
	done
}

test $# -lt 1 && fatal "Usage: $0 <binary> ..."

main "$@"
