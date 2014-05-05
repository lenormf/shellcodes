#! /usr/bin/env python2
##
## sc_unpack_string.py for shellcodes
## by lenormf
##

import sys
import struct

def main(ac, av):
	if (ac < 2):
		print "Usage: {0} <string> ...".format(av[0])

	for s in av[1:]:
		s = [ s[i:i + 8] for i, _ in enumerate(s) if i % 8 == 0 ]

		for i in s:
			print hex(struct.unpack("<Q", i if len(i) == 8 else "".join(["\xFF" for c in xrange(0, 8 - len(i))] + i.split()))[0])

if __name__ == "__main__":
	main(len(sys.argv), sys.argv)
