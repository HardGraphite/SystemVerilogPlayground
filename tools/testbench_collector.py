#!/bin/env python3

"""
SystemVerilog testbench collector.
==================================
The HDL source shall contains code block wrapped by '/*?{{' and '}}*/',
and the code block will be recognized as testbench code, which will be put into
a module definition. There do not have to be '$dumpfile(...)' or `$dumpvars(...)`.
"""

import argparse
import dataclasses
import functools
import io
import json
import pathlib
import re


@dataclasses.dataclass
class ModuleInfo:
	source_file: pathlib.Path
	name: str
	tb_code: str


def scan_file(file: pathlib.Path) -> ModuleInfo:
	mod_name = file.stem
	if not re.match(r'[A-Za-z][A-Za-z0-9_]*', mod_name):
		raise RuntimeError('{file!r} is not a valid Verilog module file name')

	reading_tb_code = False
	with io.StringIO() as buffer, open(file) as f:
		for line in f:
			if reading_tb_code:
				pos = line.find('}}*/')
				if pos < 0:
					buffer.write(line)
				else:
					buffer.write(line[:pos])
					reading_tb_code = False
			else:
				pos = line.find('/*?{{')
				if pos < 0:
					continue
				buffer.write(line[pos + 5:])
				reading_tb_code = True
		tb_code = buffer.getvalue()

	if not tb_code:
		print('WARNING:', f'{file!r} does not contain valid testbench code')

	return ModuleInfo(file, mod_name, tb_code)


def quote_string(s: str) -> str:
	assert isinstance(s, str)
	return json.dumps(s)


def generate_testbench(mod: ModuleInfo, dumpfile: str, file: pathlib.Path):
	tb_mod_name = file.stem
	with open(file, 'w') as f:
		put = functools.partial(print, file=f)
		put('// Generated from', mod.source_file, 'by', __file__)
		put()
		put('`timescale 1ns / 100ps')
		put('`include', quote_string(str(mod.source_file.absolute())))
		put()
		put('module', tb_mod_name, ';')
		if (initial_pos := mod.tb_code.find('initial')) >= 0:
			begin_pos = mod.tb_code.find('begin', initial_pos)
			sep_pos = initial_pos + 7 if begin_pos < 0 else begin_pos + 5
			put(mod.tb_code[:sep_pos])
			if mod.tb_code.find('$dumpfile') < 0:
				put(f'$dumpfile({dumpfile});')
			if mod.tb_code.find('$dumpvars') < 0:
				put(f'$dumpvars(0, {tb_mod_name});')
			put(mod.tb_code[sep_pos:])
		else:
			put(mod.tb_code)
		put('endmodule')


def default_output_file(source: pathlib.Path) -> pathlib.Path:
	return source.parent / (source.stem + '_tb') / source.suffix


def main():
	arg_parser = argparse.ArgumentParser()
	arg_parser.add_argument('-d', '--dump-file', required=False,
		help='path to the dump file, which will be the argument for $dumpfile function')
	arg_parser.add_argument('-o', '--output', type=pathlib.Path, required=False,
		help='path to the generated testbench file')
	arg_parser.add_argument('SOURCE', type=pathlib.Path, help='source file')

	args = arg_parser.parse_args()
	del arg_parser

	generate_testbench(
		scan_file(args.SOURCE),
		'`DUMPFILE' if args.dump_file is None else quote_string(args.dump_file),
		default_output_file(args.SOURCE) if args.output is None else args.output,
	)


if __name__ == '__main__':
	main()
