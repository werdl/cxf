module cxf

import math.big
import math

pub struct HPF {
pub mut:
	number string
	point  i64
	prec   int = 3
}

pub fn hpf_bin(s string, prec int) HPF {
	whole, decimal := s.split_once('.') or { panic(err) }
	return HPF{
		number: big.integer_from_radix(s.replace('.', ''), 2) or { panic(err) }.str()
		point: big.integer_from_radix(whole, 2) or { panic(err) }.str().len
		prec: prec
	}
}

pub fn hpf(s string, prec int) HPF {
	whole, decimal := s.split_once('.') or { panic(err) }
	return HPF{
		number: big.integer_from_radix(s.replace('.', ''), 10) or { panic(err) }.str()
		point: big.integer_from_radix(whole, 10) or { panic(err) }.str().len
		prec: prec
	}
}

pub fn (a HPF) + (b HPF) HPF {
	mut res := HPF{}

	awhole := big.integer_from_string(a.number[..a.point]) or { panic(err) }
	bwhole := big.integer_from_string(b.number[..b.point]) or { panic(err) }

	approx := (awhole + bwhole).str().len

	mut a_altogether := big.integer_from_string(a.number) or { panic(err) }
	mut b_altogether := big.integer_from_string(b.number) or { panic(err) }
	println('${a_altogether} ${b_altogether}')
	alen := a.str().len
	blen := b.str().len

	if alen > blen {
		b_altogether = big.integer_from_string(b_altogether.str() + '0'.repeat(alen - blen)) or {
			panic(err)
		}
	} else if alen == blen {
	} else if blen > alen {
		a_altogether = big.integer_from_string(a_altogether.str() + '0'.repeat(blen - alen)) or {
			panic(error)
		}
	}

	result := a_altogether + b_altogether
	println(result.str()[approx..])
	res.number = result.str()
	res.point = result.str()[approx..].len

	return res
}

pub fn (a HPF) - (b HPF) HPF {
	mut res := HPF{}

	awhole := big.integer_from_string(a.number[..a.point]) or { panic(err) }
	bwhole := big.integer_from_string(b.number[..b.point]) or { panic(err) }

	approx := (awhole - bwhole).str().len

	mut a_altogether := big.integer_from_string(a.number) or { panic(err) }
	mut b_altogether := big.integer_from_string(b.number) or { panic(err) }

	mut a_dec := big.integer_from_string(a.number[..a.point]) or { panic(err) }
	mut b_dec := big.integer_from_string(b.number[..b.point]) or { panic(err) }

	println('${a_altogether} ${b_altogether}')
	alen := a.str().len
	blen := b.str().len

	if alen > blen {
		b_altogether = big.integer_from_string(b_altogether.str() + '0'.repeat(alen - blen)) or {
			panic(err)
		}
	} else if alen == blen {
	} else if blen > alen {
		a_altogether = big.integer_from_string(a_altogether.str() + '0'.repeat(blen - alen)) or {
			panic(error)
		}
	}

	result := a_altogether + b_altogether
	println(result.str()[approx..])
	res.number = result.str()
	res.point = result.str()[approx..].len

	return res
}

pub fn (a HPF) * (b HPF) HPF {
	mut res := HPF{}

	awhole := big.integer_from_string(a.number[..a.point]) or { panic(err) }
	bwhole := big.integer_from_string(b.number[..b.point]) or { panic(err) }

	approx := (awhole * bwhole).str().len
	println('${awhole} ${bwhole}')

	mut a_altogether := big.integer_from_string(a.number) or { panic(err) }
	mut b_altogether := big.integer_from_string(b.number) or { panic(err) }
	println('${a_altogether} ${b_altogether}')
	alen := a.str().len
	blen := b.str().len

	if alen > blen {
		b_altogether = big.integer_from_string(b_altogether.str() + '0'.repeat(alen - blen)) or {
			panic(err)
		}
	} else if alen == blen {
	} else if blen > alen {
		a_altogether = big.integer_from_string(a_altogether.str() + '0'.repeat(blen - alen)) or {
			panic(error)
		}
	}
	println('${a_altogether} ${b_altogether}')

	result := a_altogether * b_altogether
	println(approx)
	println(result.str())
	res.number = result.str().trim_right('0')
	res.point = result.str()[..approx].len

	return res
}

pub fn (a HPF) / (b HPF) HPF {
	mut res := HPF{}

	awhole := big.integer_from_string(a.number[..a.point]) or { panic(err) }
	bwhole := big.integer_from_string(b.number[..b.point]) or { panic(err) }

	approx := (awhole / bwhole).str().len

	mut a_altogether := big.integer_from_string(a.number) or { panic(err) }
	mut b_altogether := big.integer_from_string(b.number) or { panic(err) }
	println('${a_altogether} ${b_altogether}')
	alen := a.str().len
	blen := b.str().len

	mut prec := math.max(a.prec, b.prec)
	if prec < 3 {
		prec = 3
	}

	reps := blen * prec

	a_altogether = big.integer_from_string(a_altogether.str() + '0'.repeat(reps)) or {
		panic(error)
	}
	println('${a_altogether} ${b_altogether}')

	mut result := a_altogether / b_altogether
	println(approx.str().len + 1)
	println(result.str().len)
	result = big.integer_from_string(result.str().trim_right('0')) or { panic(err) }
	if approx.str().len + 1 == result.str().len {
		result = big.integer_from_string(result.str() + '0') or { panic(err) }
	}
	res.number = result.str()
	res.point = approx

	return res
}

pub fn (h HPF) str() string {
	whole := h.number[..h.point]
	dec := h.number[h.point..]
	return '${whole}.${dec}'
}
