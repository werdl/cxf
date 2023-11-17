module main

import cxf

fn main() {
	fifty := cxf.cxf('50.7')
	d := fifty.d32() or { return }
	println(d)
	println(d.f64())
}
