/*
 * RFµ
 *
 * Copyright 2013 b@Zi.iS
 *
 * License CC BY 3.0
 */

include <../main.scad>;
use <srf.scad>;

rfmu();

module rfmu(
	size = [
		28,
		22,
		1.6
	],
	id
) {
	part(id, str("RFµ"))

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
			//AVR
			color([0,0,0]) {
				translate([
					-size[0]/2 + 4,
					-sin(45)*5,
					1.6,
				]) {
					rotate([
						0,
						0,
						45
					]) {
						cube([
							5,
							5,
							1
						]);
					}
				}
			}
			translate([
				3,
				0,
				1.6,
			]) {
				srf();
			}
			for(x=[0:1]) {
				for(y=[0:10]) {
					color([.75, .75, .25]) {
						translate([
							-size[0]/2 + 2*y + 5,
							-size[1]/2 -.01 + (size[1]-1.5/2 +.03)*x,
							-.01
						]) {
							cube([
								1.5,
								1.5/2,
								1.62
							]);
						}
					}
				}
			}
		}
		for(x=[0:1]) {
			for(y=[0:10]) {
				color([.75, .75, .25]) {
					translate([
						-size[0]/2 + 2*y + 5 + 1.5/2,
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
	}
}
