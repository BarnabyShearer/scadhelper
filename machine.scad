/*
 * Helpers for machinging; i.e. kerf alowances
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <main.scad>;

ZCUT = 0;
XOFF = 0;
YOFF = 0;

module drawing() {
	//create blueprint
	if(preview==0) {
		projection(cut=true) translate([
			XOFF,
			YOFF,
			ZCUT
		]) {
			for(i=[0:$children-1]) child(i);
		}
	} else {
		for(i=[0:$children-1]) child(i);
	}
}

module kerf_cube(
	size
) {
	translate([
		kerf/2*(1-preview),
		kerf/2*(1-preview),
		0
	]) {
		cube([
			size[0] - kerf*(1-preview),
			size[1] - kerf*(1-preview),
			size[2]
		]);
	}
}

module kerf_cylinder(
	r,
	h
) {
	cylinder(
		r = r - kerf/2*(1-preview),
		h = h
	);
}

module part(
	id,
	name
) {
	if(PART<1 || PART==id) {
		if(id>=0) echo(str("PART", id, ":", name));
		for(i=[0:$children-1]) child(i);
	}	
}
