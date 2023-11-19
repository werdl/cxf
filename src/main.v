module main

import cxf

fn main() {
	fifty := cxf.cxf('50.7')
	d := fifty.d128() or { return }
	x := cxf.hpf('115.0', 100)
	y := cxf.hpf('2.578', 1000)

	println(x / y)
}
