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
	result.exponent = tocalc.len.str()

	result.mantissa = tocalc.replace('.', '').trim_right('0')

	result.prec = result.mantissa.str().len.str()

	return result
}

fn bin(i string) string {
	b := big.integer_from_string(i) or { return '' }
	return b.bin_str()
}

type IEEE754single = string
type IEEE754double = string
type IEEE754quadruple = string
type IEEE754octuple = string

pub fn pad(s string, len int) string {
	if s.len == len {
		return s
	} else if s.len < len {
		return '0'.repeat(len - s.len) + s
	} else {
		return s[0..len]
	}
}

// pub fn (c CXF) single() IEEE754single {
// }

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
