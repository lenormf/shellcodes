#! /usr/bin/env python2
##
## sc_find_xor_range.py for shellcodes
## by lenormf
##

import sys

def gen_ref(size, byte):
	n = byte

	for i in xrange(0, size - 1):
		n = (n << 8) | byte

	return n

def main(ac, av):
	if ac < 3:
		print "Usage: {0} <size in bytes> <number> ...".format(av[0])
		return 0

	nsize = int(av[1])
	numbers = [ int(n) for n in av[2:] ]

	ref_low = gen_ref(nsize, 0x01)
	ref_high = gen_ref(nsize, 0xFF)

	for n in numbers:
		for i in xrange(ref_low, ref_high):
			for j in xrange(ref_low, ref_high):
				if i ^ j == n:
					print (i, j)

if __name__ == "__main__":
	main(len(sys.argv), sys.argv)
