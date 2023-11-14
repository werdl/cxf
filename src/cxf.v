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

pub fn (c CXF) bin() string {
	return '${c.sign}${bin(c.exponent)}${bin(c.mantissa)}'
}
