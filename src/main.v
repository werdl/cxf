module main

import cxf

fn main() {
	fifty := cxf.cxf('50.7')
	d := fifty.d128() or { return }
	x := cxf.hpf('10.0', 3)
	y := cxf.hpf('0.3', 3)

	println(x * y)
}
