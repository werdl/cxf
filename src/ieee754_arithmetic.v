module cxf

import math
import math.big

pub fn (ie IEEE754decimal32) f64() f64 {
	s := ie.str()

	sign := s[0..1]

	exponent := s[1..12]
	mantissa := s[12..]

	sign_int := match sign {
		'0' {
			2
		}
		else {
			1
		}
	}
	mut total := math.pow(-1, sign_int)

	// total = big.integer_from_radix(mantissa, 2) or { panic(err) }
	total *= math.pow(10, (exponent.parse_int(2, 32) or { return 0.0 }) - 96)
	return total
}

pub fn (ie IEEE754decimal64) f64() f64 {
	s := ie.str()

	sign := s[0..1]

	exponent := s[1..14]
	mantissa := s[14..]

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
	total *= math.pow(10, (exponent.parse_int(2, 64) or { panic(err) }) - 192)
	return total
}

pub fn (ie IEEE754decimal128) f64() f64 {
	s := ie.str()

	sign := s[0..1]

	exponent := s[1..18]
	mantissa := s[18..]

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
	total *= math.pow(10, (exponent.parse_int(2, 64) or { panic(err) }) - 6144)
	return total
}
