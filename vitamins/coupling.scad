/*
 * Coupling
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <../main.scad>;

coupling();

module coupling(
	d1 = 6,
	d2 = 5,
	h = 40,
	id
) {
	part(id, str("Coupling ", d1, "mm to", d2, "x", h, "mm")) translate([
		0,
		0,
		-h/4
	]) {
		color(color_steel) {
			difference() {
				cylinder(
					r = max(d1,d2),
					h = h
				);
				e() cylinder(
					r = d1/2,
					h = h/2
				);
				translate([
					0,
					0,
					h/2
				]) {
					e() cylinder(
						r = d2/2,
						h = h/2
					);
				}
				for(x=[0:h/4]) {
					translate([
						-max(d1,d2)*.75 -max(d1,d2)*.5*(x%2),
						-max(d1,d2),
						h/4 + x*2
					]) {
						cube([
							max(d1,d2)*2,
							max(d1,d2)*2,
							1
						]);
					}
				}
			}
		}
	}
	translate([
		0,
		0,
		h/2
	] * preview) {
        if($children) children([0:$children-1]);
	}
}
