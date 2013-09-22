/*
 * NEMA Motors
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <../main.scad>;

nema();

nema_sizes = [
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
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[42.2, 31.04, 3]
];

function nema_faceplate(size) = [nema_sizes[size][0], nema_sizes[size][0]];

module nema_faceplate_drill(
	size = 17
) {
	for(x=[0:1]) {
		for(y=[0:1]) {
			translate([
				-nema_sizes[size][1]/2 + nema_sizes[size][1]*x,
				-nema_sizes[size][1]/2 + nema_sizes[size][1]*y,
				0
			]) {
				kerf_cylinder(
					r = nema_sizes[size][2]/2,
					h = 1000
				);
			}	
		}
	}
	kerf_cylinder(
		r = nema_sizes[size][3]/2 + 1,
		h = 1000
	);
}

module nema(
    motor = [
        17, //Size
        20, //Shaft length
        5   //Shaft diamiter
    ],
	depth = 48,
	id
) {
	part(id, str("NEMA", motor[0], " ", depth,"mm long with ", motor[1], "x", motor[2], "mm shaft")) {	
		color(color_steel) cylinder(
			r = motor[2]/2,
			h = motor[1]
		);
		difference() {
			union() {
				color(color_steel) translate([
					-nema_sizes[motor[0]][0]/2,
					-nema_sizes[motor[0]][0]/2,
					-5
				]) {
					cube([
						nema_sizes[motor[0]][0],
						nema_sizes[motor[0]][0],
						5
					]);
				}
				color([0,0,0]) translate([
					-nema_sizes[motor[0]][0]/2,
					-nema_sizes[motor[0]][0]/2,
					-depth
				]) {
					cube([
						nema_sizes[motor[0]][0],
						nema_sizes[motor[0]][0],
						depth-5
					]);
				}
			}
			for(x=[0:1]) {
				for(y=[0:1]) {
					translate([
						-nema_sizes[motor[0]][1]/2 + nema_sizes[motor[0]][1]*x,
						-nema_sizes[motor[0]][1]/2 + nema_sizes[motor[0]][1]*y,
						-5
					]) {
						cylinder(
							r = nema_sizes[motor[0]][2]/2,
							h = 6
						);
					}
				}
			}
		}
	}
	translate([
		0,
		0,
		motor[1]
	] * preview) {
		if($children>0) for (i = [0 : $children-1]) child(i);
	}
}
