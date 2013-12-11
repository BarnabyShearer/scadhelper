/*
 * Bend unit length child along a Bézier curve
 *
 * Copyright 2013 William Adams, <b@Zi.iS>
 * License CC BY 3.0
 */
include <main.scad>;

bend([0, 500, 0], 1000) {
    cylinder(r=1, h=1);
}

module bend(
	end = [0, 40, 0],
	length = 100,
	steps = 10,
	debug = 0
) {
	span = sqrt(end*end);

	//aprox. a constant length
   c = [
		[0, 0, 0],
		[0, 0, (length-span)],
		[end[0], end[1], end[2] + (length-span)],
		end
   ];

	if(debug) {
		for(point=[0:3]) {
			translate(c[point]) {
				color([1,0,0]) {
					cylinder(r=1, h=1);
				}
			}
		}
	}

	for(step = [steps-1:0]) {
		cylinder_between(
			PointAlongBez4(c[0], c[1], c[2], c[3], step/(steps)),
			PointAlongBez4(c[0], c[1], c[2], c[3], (step+1)/(steps))
		) child();
	}
}

function BEZ03(u) = pow((1-u), 3);
function BEZ13(u) = 3*u*(pow((1-u),2));
function BEZ23(u) = 3*(pow(u,2))*(1-u);
function BEZ33(u) = pow(u,3);

function PointAlongBez4(p0, p1, p2, p3, u) = [
	BEZ03(u)*p0[0] + BEZ13(u)*p1[0] + BEZ23(u)*p2[0] + BEZ33(u)*p3[0],
	BEZ03(u)*p0[1] + BEZ13(u)*p1[1] + BEZ23(u)*p2[1] + BEZ33(u)*p3[1],
	BEZ03(u)*p0[2] + BEZ13(u)*p1[2] + BEZ23(u)*p2[2] + BEZ33(u)*p3[2]
];

module cylinder_between(p1, p2) {
	v = p2 - p1;
	translate(p1) {
		rotate([
			0,
			0,
			atan2(v[1], v[0])
		]) {
			rotate([
				0,
				atan2(
					sqrt(pow(v[0], 2) + pow(v[1], 2)),
					v[2]
				),
				0
			]) {
				scale([
					1,
					1,
					sqrt(v*v)
				]) {
					child();
				}
			}
		}
	}
}
