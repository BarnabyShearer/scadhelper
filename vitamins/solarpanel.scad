/*
 * Solarpanel
 *
 * Copyright 2013 b@Zi.iS
 *
 * License CC BY 3.0
 */

include <../main.scad>;

solarpanel();

module solarpanel(
	size = [
		70,
		55,
		2.5
	],
	pitch = 15,
	id
) {
	part(id, str("solarpanel"))

	color([0,0,0]) {
		translate([
			-size[0]/2,
			-size[1]/2,
			0
		]) {
			cube(size);
		}
	}
	color([.75,.75,.75]) {
		for(i=[0:1]) {
			translate([
				-pitch/2 + i*pitch,
				0,
				0,
			]) {
				sphere(
					r = 1.5
				);
			}
		}
	}
}
