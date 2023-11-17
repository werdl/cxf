module cxf

import math
import encoding.binary
import math.big

struct CXF {
pub mut:
	prec     string
	sign     int
	exponent string // stored as base 10
	mantissa string
}

pub fn cxf(s string) CXF {
	mut result := CXF{}
	mut tocalc := ''
	match s[0] {
		`-` {
			result.sign = 1
			tocalc = s[1..]
		}
		`+` {
			result.sign = 0
			tocalc = s[1..]
		}
		else {
			tocalc = s
		}
	}
	result.exponent = tocalc.split('.')[0].len.str()

	result.mantissa = tocalc.replace('.', '').trim_right('0')

	result.prec = result.mantissa.str().len.str()

	return result
}

fn bin(i string) string {
	b := big.integer_from_string(i) or { return '' }
	return b.bin_str()
}

pub fn pad(s string, len int) string {
	if s.len == len {
		return s
	} else if s.len < len {
		return '0'.repeat(len - s.len) + s
	} else {
		return s[0..len]
	}
}

type IEEE754decimal32 = string
type IEEE754decimal64 = string
type IEEE754decimal128 = string

pub fn (c CXF) d32() !IEEE754decimal32 {
	if bin(c.exponent).len > 11 {
		return error('Exponent ${c.exponent} Too Big')
	}
	biased_exponent := big.integer_from_int(c.exponent.int() + 96)
	// println('${c.mantissa}, ${pad(bin(c.mantissa), 7)}')
	return IEEE754decimal32('${c.sign}${pad(biased_exponent.bin_str(), 11)}${pad(bin(c.mantissa),
		20)}')
}

pub fn (c CXF) d64() !IEEE754decimal64 {
	if bin(c.exponent).len > 13 {
		return error('Exponent ${c.exponent} Too Big')
	}
	biased_exponent := big.integer_from_int(c.exponent.int() + 192)
	// println('${c.mantissa}, ${pad(bin(c.mantissa), 7)}')
	return IEEE754decimal64('${c.sign}${pad(biased_exponent.bin_str(), 13)}${pad(bin(c.mantissa),
		52)}')
}

pub fn (c CXF) d128() !IEEE754decimal128 {
	if bin(c.exponent).len > 17 {
		return error('Exponent ${c.exponent} Too Big')
	}
	biased_exponent := big.integer_from_int(c.exponent.int() + 6144)
	// println('${c.mantissa}, ${pad(bin(c.mantissa), 7)}')
	return IEEE754decimal128('${c.sign}${pad(biased_exponent.bin_str(), 17)}${pad(bin(c.mantissa),
		110)}')
}

/*
Binary arbitrary precision floating point number repr

	Bit 1 - sign bit
		0 - positive
		1 - negative

	Bits 2-n - mantissa
		what is a mantissa
			0.mantissa * 10^exponent * (0-sign) == number
		n is returned as the second string
	
	Bits n-end - exponent
		what is an exponent
			see above
		base is 10


	Example: 50

	Sign - 0
	Mantissa - 5
	Exponent - 2

	Binary:
	0 101 10, n is 3
*/
pub fn (c CXF) bin() (string, string) {
	str := '${c.sign}${bin(c.mantissa)}${bin(c.exponent)}'
	return str, bin(c.mantissa).len.str()
}
