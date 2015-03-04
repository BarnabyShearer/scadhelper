/*
 * NEMA Motors
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <../main.scad>;

function nema_faceplate(size) = [nema_sizes[size][0], nema_sizes[size][0]];

module nema_faceplate_drill(
	motor,
    scale = 1
) {
	for(x=[0:1]) {
		for(y=[0:1]) {
			translate([
				-motor[1]/2 + motor[1]*x,
				-motor[1]/2 + motor[1]*y,
				0
			]) {
				kerf_cylinder(
					r = motor[2]/2 * scale,
					h = 1000
				);
			}	
		}
	}
	kerf_cylinder(
		r = motor[2]/2 + 1,
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
					-motor[0]/2,
					-motor[0]/2,
					-5
				]) {
					cube([
						motor[0],
						motor[0],
						5
					]);
				}
				color([0,0,0]) translate([
					-motor[0]/2,
					-motor[0]/2,
					-depth
				]) {
					cube([
						motor[0],
						motor[0],
						depth-5
					]);
				}
			}
			for(x=[0:1]) {
				for(y=[0:1]) {
					translate([
						-motor[1]/2 + motor[1]*x,
						-motor[1]/2 + motor[1]*y,
						-5
					]) {
						cylinder(
							r = motor[2]/2,
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
        if($children) children([0:$children-1]);
	}
}
