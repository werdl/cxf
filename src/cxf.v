module cxf

import math
import encoding.binary
import math.big

struct CXF {
pub mut:
	prec     string
	sign     int
	exponent string
	mantissa string
}

pub fn cxf(s string) CXF {
	mut result := CXF{}
	mut tocalc := 0.0
	match s[0] {
		`-` {
			result.sign = 1
			tocalc = s[1..].f64()
		}
		`+` {
			result.sign = 0
			tocalc = s[1..].f64()
		}
		else {
			tocalc = s.f64()
		}
	}
	result.exponent = big.integer_from_int(int(tocalc)).bin_str().len.str()

	result.mantissa = (tocalc / math.pow(2, result.exponent.f64())).str()[2..]

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
