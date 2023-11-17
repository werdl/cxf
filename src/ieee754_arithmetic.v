module cxf

import math

pub fn (ie IEEE754decimal32) f64() f64 {
	s := ie.str()

	sign := s[0..1]

	exponent := s[1..12]
	mantissa := s[12..]

	println('${sign}-${exponent}-${mantissa}')

	sign_int := match sign {
		'0' {
			2
		}
		else {
			1
		}
	}
	mut total := math.pow(-1, sign_int)
	total *= ('0.' + (mantissa.parse_int(2, 32) or { return 0.0 }).str()).f64()
	total *= (exponent.parse_int(2, 32) or { return 0.0 }).str().f64()
	return total
}
