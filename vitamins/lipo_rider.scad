/*
 * lipo rider
 *
 * Copyright 2013 b@Zi.iS
 *
 * License CC BY 3.0
 */

include <../main.scad>;

lipo_rider();

module lipo_rider(
	size = [
		45.5,
		38,
		1.6
	],
	id
) {
	part(id, str("lipo rider"))

	color([0,.5,.5]) {
		translate([
			-size[0]/2,
			-size[1]/2,
			0
		]) {
			cube(size);
		}
	}
	//USB
	color([.75,.75,.75]) {
		translate([
			size[0]/2 - 14,
			-size[1]/2 + 3.3,
			0
		]) {
			cube([
				14,
				13.2,
				5.6
			]);
		}
	}

	//Switch
	color([.75,.75,.75]) {
		translate([
			size[0]/2 - 2.8,
			size[1]/2 - 11,
			1.6
		]) {
			cube([
				2.8,
				6.8,
				1.55 
			]);
		}
	}
	color([1,1,1]) {
		translate([
			size[0]/2 - 2.8/2 - .7/2,
			size[1]/2 - 11 + 6.8/2,
			1.6
		]) {
			cube([
				0.7,
				1.7,
				3.3 
			]);
		}
	}

	//µUSB
	color([.75,.75,.75]) {
		translate([
			-size[0]/2 - 1,
			-7.8/2,
			1.6
		]) {
			cube([
				9.5,
				7.8,
				3.9
			]);
		}
	}

	//JST
	color([1,1,1]) {
		for(i=[0:1]) {
			translate([
				-size[0]/2,
				-22.2/2 + i*22.2 - 8/2,
				1.6
			]) {
				cube([
					8,
					7.8,
					5.7
				]);
			}
		}
	}
}
