/*
 * Rod
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <../main.scad>;

rod();

module rod(
	r = 8/2,
	h = 250,
	id
) {
	part(id, str("Smooth rod ", r*2, "mm x ", h, "mm"))
	color(color_steal) {
		cylinder(
			r = r,
			h = h
		);
	}
	translate([
		0,
		0,
		h
	] * preview) {
		if($children>0) for (i = [0 : $children]) child(i);
	}
}

module threaded_rod(
	r = 8/2,
	h = 250,
	pitch = 1.26,
	id
) {
	part(id, str("Threaded rod ", r*2, "mm x ", h, "mm")) {
		color([.5,.5,.5]) cylinder(
			r = r*.8,
			h = h
		);
	
		color([.7,.7,.7,.5]) cylinder(
			r = r,
			h = h
		);
	
		/* Proper version but too slow
		color(color_steal) {
			linear_extrude(
				height = h,
				twist = -h/pitch*360
			) {
				translate([.866*pitch,0,0]) {
					circle(
						r=r 
					);
				}
			}
		}*/
	}

	translate([
		0,
		0,
		h
	] * preview) {
		if($children>0) for (i = [0 : $children]) child(i);
	}
}

