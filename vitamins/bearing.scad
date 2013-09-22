/*
 * radial bearing
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <../main.scad>;

bearing60_size = [
	[],
	[],
	[],
	[],
	[],
	[],
	[
        6,
        17,
        6
    ],
	[],
	[
		8,
		22,
		7
	]
];

bearing60();

function bearing60_offset(size) = bearing60_size[size][1] - bearing60_size[size][0];
function bearing60_width(size) = bearing60_size[size][2];

module bearing60(
	size = 8,
	id
) {
	bearing(
		bearing60_size[size],
		id
	);
	translate([
		0,
		0,
		bearing60_size[size][2]
	] * preview) {
		if($children>0) for (i = [0 : $children-1]) child(i);
	}
}

module bearing(
	size = bearing60_size[8],
	id
) {
	part(id, str("Radial bearing: ID", size[0], "mm, OD", size[1], "mm, width", size[2], "mm"))
	color(color_steal) {
		translate([
			0,
			0,
			-size[2]/2
		]) {
			difference() {
				cylinder(
					r = size[1]/2,
					h = size[2]
				);
				e() cylinder(
					r = size[0]/2,
					h = size[2]
				);
			}
		}
	}
	translate([
		0,
		0,
		size[2]
	] * preview) {
		if($children>0) for (i = [0 : $children-1]) child(i);
	}
}
