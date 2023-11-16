module main

import cxf

fn main() {
	fifty := cxf.cxf('50.7')
	println(fifty.d128() or { return })
}
