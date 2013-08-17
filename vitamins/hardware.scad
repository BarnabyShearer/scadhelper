/*
 * Metric hardware
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <../main.scad>;

// metric bolt sizes
function m_hole(size) = size*1.1/2;
function m_pilot(size) = size*.9/2;

module m_washer(
	size = 3,
	id
) {
	part(id, str("Washer M", size)) color(color_steal) {
		difference() {
			cylinder(
				r = size/2*2,
				h = size*.2
			);
			e() cylinder(
				r = size/2,
				h = size*.2
			);
		}
	}
	translate([
		0,
		0,
		size*.2
	] * preview) {
		if($children>0) for (i = [0 : $children]) child(i);
	}
}

module m_nut(
	size = 3,
	id
) {
	part(id, str("Nut M", size)) color(color_steal) {
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
		if($children>0) for (i = [0 : $children]) child(i);
	}
}

m_nylock();

module m_nylock(
	size = 3,
	id
) {
	part(id, str("Nylock M", size)) color(color_steal) {
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
					size*0.8
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
		if($children>0) for (i = [0 : $children]) child(i);
	}
}
