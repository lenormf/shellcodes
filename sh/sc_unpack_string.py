#! /usr/bin/env python2
##
## sc_unpack_string.py for shellcodes
## by lenormf
##

import sys
import struct

def usage(av):
	print "Usage: {0} <size> <string> ...".format(av)

def main(ac, av):
	size_formats = {
		8: "Q",
		4: "L",
		2: "H",
		1: "B",
	}

	if (ac < 3):
		usage(av[0])
		return 0

	try:
		size = int(av[1])
		str_format = size_formats[size]
	except ValueError:
		usage(av[0])
		return 1
	except KeyError:
		print "Invalid size (has to be {0})".format(size_formats.keys())
		return 2

	for s in av[2:]:
		s = [ s[i:i + size] for i, _ in enumerate(s) if i % size == 0 ]

		for i in s:
			padded_substr = "".join(["\xFF" for c in xrange(0, size - len(i))]) + i

			print hex(struct.unpack("@{0}".format(str_format), i if len(i) == size else padded_substr)[0])

if __name__ == "__main__":
	main(len(sys.argv), sys.argv)
