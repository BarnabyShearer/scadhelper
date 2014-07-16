/*
 * thrust bearing
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <../main.scad>;

thrust_bearing();

thrust_bearing = [
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
		24,
		8.9,
		4.8
	]
];		

module thrust_bearing(
	size = 10,
	rotation = 0,
	id
) {
	part(id, str("Thrust bearing: ID", thrust_bearing[size][0], "mm, OD", thrust_bearing[size][1], "mm, width", thrust_bearing[size][2], "mm"))
	color(color_steel) {
	rotate_extrude() {
		translate([
			thrust_bearing[size][0]/2,
			0,
			0
		]) {
			difference() {
				square([
					(thrust_bearing[size][1] - thrust_bearing[size][0])/2,
					(thrust_bearing[size][2] - thrust_bearing[size][3])/2*1.25
				]);
				translate([
					(thrust_bearing[size][1] - thrust_bearing[size][0])/2/2,
					thrust_bearing[size][3]
						- (thrust_bearing[size][2] - thrust_bearing[size][3])/2*1.25
						+ (thrust_bearing[size][2] - thrust_bearing[size][3])/2,
					0
				]) {
					circle(r = thrust_bearing[size][3]/2);
				}
			}
		}
	}
	translate([
		0,
		0,
		(thrust_bearing[size][2] - thrust_bearing[size][3])/2 + thrust_bearing[size][3]/2 
	]) {
		for(i=[0:8]) {
			rotate([
				0,
				0,
				360/9*i + rotation/2
			]) {
				translate([
					thrust_bearing[size][0]/2 + (thrust_bearing[size][1] - thrust_bearing[size][0])/2/2,
					0,
					0,
				]) {
					sphere(
						r = thrust_bearing[size][3]/2
					);
				}
			}
		}
	}
	translate([
		0,
		0,
		thrust_bearing[size][2]
	]) {
		rotate([
			180,
			0,
			rotation
		]) {
			rotate_extrude() {
				translate([
					thrust_bearing[size][0]/2,
					0,
					0
				]) {
					difference() {
						square([
							(thrust_bearing[size][1] - thrust_bearing[size][0])/2,
							(thrust_bearing[size][2] - thrust_bearing[size][3])/2*1.25
						]);
						translate([
							(thrust_bearing[size][1] - thrust_bearing[size][0])/2/2,
							thrust_bearing[size][3]
								- (thrust_bearing[size][2] - thrust_bearing[size][3])/2*1.25
								+ (thrust_bearing[size][2] - thrust_bearing[size][3])/2,
							0
						]) {
							circle(r = thrust_bearing[size][3]/2);
						}
					}
				}
			}
		}
	}
    }
	translate([
		0,
		0,
		thrust_bearing[size][2]
	] * preview) {
        if($children) children([0:$children-1]);
	}
}
