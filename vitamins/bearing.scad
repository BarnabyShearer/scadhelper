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
	],
    [],
    [
        10,
        22,
        6
    ]
];

bearing67002_size = [
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[
		10,
		15,
		4
	]
];

//bearing60();

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
        if($children) children([0:$children-1]);
	}
}

module bearing(
	size = bearing60_size[8],
	id
) {
	part(id, str("Radial bearing: ID", size[0], "mm, OD", size[1], "×", 
size[2], "mm"))
	color(color_steel) {
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
	translate([
		0,
		0,
		size[2]
	] * preview) {
        if($children) children([0:$children-1]);
	}
}
