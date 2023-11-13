module cxf

import math

struct CXC {
pub:
	real f64 // a
	imag f64 // b
	// in a + bi
}

pub fn cxc(real f64, imag f64) CXC {
	return CXC{
		real: real
		imag: imag
	}
}

pub fn (c CXC) is_real() bool {
	return c.imag == 0
}

pub fn (c CXC) is_imag() bool {
	return c.real == 0
}

// (a + bi) + (c + di) = (a + c) + (b + d)i
pub fn (a CXC) + (b CXC) CXC {
	return cxc(a.real + b.real, a.imag + b.imag)
}

// (a - c) + (b - d)i
pub fn (a CXC) - (b CXC) CXC {
	return cxc(a.real - b.real, a.imag - b.imag)
}

// (a + bi)(c + di) = (ac - bd) + (ad + bc)i
pub fn (a CXC) * (b CXC) CXC {
	real := ((a.real) * (b.real) - (a.imag) * (b.imag))
	imag := ((a.real) * (b.imag) + (a.imag) * (b.real))
	return cxc(real, imag)
}

/*
(ac - bd)/(c^2 + d^2) + (ad + bc)i/(c^2 + d^2)
*/
pub fn (a CXC) / (b CXC) CXC {
	denominator := b.real * b.real + b.imag * b.imag
	real := (a.real * b.real + a.imag * b.imag) / denominator
	imag := (a.imag * b.real - a.real * b.imag) / denominator
	return cxc(real, imag)
}

// converts to form 'a + bi'
pub fn (c CXC) str() string {
	return '${c.real} + ${c.imag}i'
}

// √(a+bi) = √r(cos(θ/2) + i sin(θ/2))
pub fn (c CXC) sqrt() CXC {
	mag := math.sqrt(c.real * c.real + c.imag * c.imag)
	arg := math.atan2(c.imag, c.real)

	real := math.sqrt(mag) * math.cos(arg / 2.0)
	imag := math.sqrt(mag) * math.sin(arg / 2.0)

	return cxc(real, imag)
}
