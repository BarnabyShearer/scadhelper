/*
 * Metric hardware
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <../main.scad>;

function m_washer_width(size) = size*.2;
function m_nut_width(size) = size*.8;
function m_nut_r(size) = size*1.8/2;

m_tap = [
    0,
    1.6,
    2.5,
    3.3,
    4.2,
    5,
    6.8,
    8.5,
    10.2
];

module m_washer(
	size = 3,
	id,
    fraction = 1
) {
	part(id, str("Washer M", size)) color(color_steel) {
		difference() {
			cylinder(
				r = size/2*2,
				h = size*.2 / fraction
			);
			e() cylinder(
				r = size/2,
				h = size*.2 / fraction
			);
		}
	}
	translate([
		0,
		0,
		size*.2 / fraction
	] * preview) {
		if($children) children([0:$children-1]);
	}
}

module m_nut(
	size = 3,
	id
) {
	part(id, str("Nut M", size)) color(color_steel) {
		difference() {
			cylinder(
				r = size*1.8/2,
				h = size*.8,
				$fn = 6
			);
			e() cylinder(
				r = size/2,
				h = size*.8
			);
		}
	}
	translate([
		0,
		0,
		size*.8
	] * preview) {
        if($children) children([0:$children-1]);
	}
}

m_nylock();

module m_nylock(
	size = 3,
	id
) {
	part(id, str("Nylock M", size)) color(color_steel) {
		difference() {
			union() {
				cylinder(
					r = size*1.8/2,
					h = size*0.8,
					$fn = 6
				);
				translate([
					0,
					0,
					size*0.3
				]) {
					sphere(
						r = size*1.8/2,
						$fn = 6
					);
				}
			}
			e() cylinder(
				r = size/2,
				h = size*1.5
			);
		}
	}
	translate([
		0,
		0,
		size
	]) {
        if($children) children([0:$children-1]);
	}
}

module m_tap(
    rod,
    h
) {
    kerf_cylinder(
        r = m_tap[rod]/2,
        h = h
    );
}
