struct CXF {
	pub mut:
		sign bool
		exponent int
		mantissa int
}

pub fn cxf(s string) {
	mut result:=CXF
	match s[0] {
		`-` {
			result.sign=1
		} else {
			result.sign=0
		}
	}
	

}