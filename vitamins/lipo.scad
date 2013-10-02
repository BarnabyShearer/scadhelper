/*
 * lipo
 *
 * Copyright 2013 b@Zi.iS
 *
 * License CC BY 3.0
 */

include <../main.scad>;

lipo();

module lipo(
	size = [
		49,
		35,
		7.5
	],
	id
) {
	part(id, str("lipo cell"))

	color([.25,.25,.25]) {
		translate([
			-size[0]/2,
			-size[1]/2,
			0
		]) {
			cube(size);
		}
	}
}
