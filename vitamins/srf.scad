/*
 * SRF
 *
 * Copyright 2013 b@Zi.iS
 *
 * License CC BY 3.0
 */

include <../main.scad>;

srf();

module srf(
	size = [
		15.8,
		16.25,
		.8
	],
	arial = 1,
	id
) {
	part(id, str("SRF"))

	difference() {
		union() {
			color([0,.5,.5]) {
				translate([
					-size[0]/2,
					-size[1]/2,
					0
				]) {
					cube(size);
				}
			}
			//C1110
			color([0,0,0]) {
				translate([
					-5,
					-5/2,
					.8,
				]) {
					cube([
						5,
						5,
						1
					]);
				}
			}
			if(arial==1) {
				color([0,.5,.5]) {
					translate([
						size[0]/2,
						-10/2,
						0
					]) {
						cube([
							10,
							10,
							.8
						]);
					}
				}
				//Arial
				color([1,1,1]) {
					translate([
						10,
						2,
						.8,
					]) {
						cube([
							7.3,
							2.05,
							1
						]);
					}
				}
			}
			for(x=[0:1]) {
				for(y=[0:6]) {
					color([.75, .75, .25]) {
						translate([
							-size[0]/2 + 2*y + .75,
							-size[1]/2 -.01 + (size[1]-1.5/2 +.03)*x,
							-.01
						]) {
							cube([
								1.5,
								1.5/2,
								.82
							]);
						}
					}
				}
			}
			for(y=[0:6]) {
				color([.75, .75, .25]) {
					translate([
						-size[0]/2 - .01,
						-size[1]/2 + 2*y + 1.5,
						-.01
					]) {
						cube([
							1.5/2,
							1.5,
							.82
						]);
					}
				}
			}
		}
		for(x=[0:1]) {
			for(y=[0:6]) {
				color([.75, .75, .25]) {
					translate([
						-size[0]/2 + 2*y + .75 + 1.5/2,
						-size[1]/2 -.01 + (size[1]-1.5/2 +.03 + 1.5/2)*x,
						-.1
					]) {
						cylinder(
							r = .4,
							h = 2
						);
					}
				}
			}
		}
		for(y=[0:6]) {
			color([.75, .75, .25]) {
				translate([
					-size[0]/2 - .01,
					-size[1]/2 + 2*y + 1.5 + .75,
					-.1
				]) {
						cylinder(
							r = .4,
							h = 2
						);
				}
			}
		}
	}
}
