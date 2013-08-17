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
	[42.2, 31.04, 3, 5]
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
	size = 17,
	depth = 48,
	shaft = 20,
	id
) {
	part(id, str("NEMA", size, depth,"mm long with", shaft, "mm shaft")) {	
		color(color_steal) cylinder(
			r = nema_sizes[size][3]/2,
			h = shaft
		);
		difference() {
			union() {
				color(color_steal) translate([
					-nema_sizes[size][0]/2,
					-nema_sizes[size][0]/2,
					-5
				]) {
					cube([
						nema_sizes[size][0],
						nema_sizes[size][0],
						5
					]);
				}
				color([0,0,0]) translate([
					-nema_sizes[size][0]/2,
					-nema_sizes[size][0]/2,
					-depth
				]) {
					cube([
						nema_sizes[size][0],
						nema_sizes[size][0],
						depth-5
					]);
				}
			}
			for(x=[0:1]) {
				for(y=[0:1]) {
					translate([
						-nema_sizes[size][1]/2 + nema_sizes[size][1]*x,
						-nema_sizes[size][1]/2 + nema_sizes[size][1]*y,
						-5
					]) {
						cylinder(
							r = nema_sizes[size][2]/2,
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
		shaft
	] * preview) {
		if($children>0) for (i = [0 : $children]) child(i);
	}
}
