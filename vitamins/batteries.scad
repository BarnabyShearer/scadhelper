/*
 * Batteries
 *
 * Copyright 2014 <b@Zi.iS>
 * License CC BY 3.0
 */

include <../main.scad>;

aa();

module aa(id) {
	part(id, "AA Battery") {
		translate([0,0,0.1])
			cylinder(
				d=14.5,
				h=50.5-1.1
			);
		color([.7,.7,.7])
			cylinder(
				d=7,
				h=0.1
			);
		color([.7,.7,.7])
			cylinder(
				d=5.5,
				h=50.5
			);
	}
}