#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Usage: get_unused_space.py [-h] pokecrystal.map

Parse the mapfile to measure unused space across the ROM.
"""

import sys
import argparse
import subprocess
import struct
import enum
import signal

parser = argparse.ArgumentParser(description='Parse the mapfile to measure unused space across the ROM')
parser.add_argument('mapfile', type=argparse.FileType('r'),
	help='the mapfile')
args = parser.parse_args()

should_print_bank = False
rombank_line = ''
total_unused = 0
total_banks = 0
for line in args.mapfile:
	line = line.strip()
	if line.startswith('ROM'):
		should_print_bank = True
		rombank_line = line
	if line.startswith('TOTAL EMPTY') and should_print_bank:
		print(rombank_line)
		print(line)
		number = int(line.split(' ')[2].replace('$', '0x'), 0)
		total_unused += number
		total_banks += 1
		should_print_bank = False
while total_banks < 128:
	total_unused += 0x4000
	total_banks += 1
print(f'Total unused space: {total_unused} ({total_unused:x}) byte(s)')