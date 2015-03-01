/*
 * linear bearing
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <../main.scad>;

lmXuu = [
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[
		15.2,	//outside
		8,		//inside
		26,		//length
	]
];

linear_bearing();

function linear_bearing_length(size) = lmXuu[size][2];
function linear_bearing_offset(size) = (lmXuu[size][0] - lmXuu[size][1]);

module linear_bearing(
	size = 8,
	id
) {
	part(id, str("Linear bearing lm", size, "uu")) color(color_steel) {
		translate([
			0,
			0,
			-lmXuu[size][2]/2
		]) {
			difference() {
				union() {
					cylinder(
						r = lmXuu[size][0]/2 - 1,
						h = lmXuu[size][2]
					);
					cylinder(
						r = lmXuu[size][0]/2,
						h = 3.4
					);
					translate([
						0,
						0,
						3.4 + 1.25
					]) {
						cylinder(
							r = lmXuu[size][0]/2,
							h = lmXuu[size][2] - (3.4 + 1.25) * 2
						);
					}
					translate([
						0,
						0,
						lmXuu[size][2] - 3.4
					]) {
						cylinder(
							r = lmXuu[size][0]/2,
							h = 3.4
						);
					}
				}
				e() cylinder(
					r = lmXuu[size][1]/2,
					h = lmXuu[size][2]
				);
			}
		}
	}
	translate([
		0,
		0,
		lmXuu[size][2]/2
	] * preview) {
        if($children) children([0:$children-1]);
	}
}
