/*
 * Planetary gear bearing
 *
 * Copyright 2013 Emmett Lalish, b@Zi.iS
 *
 * based on http://www.thingiverse.com/thing:53451
 *
 * License CC BY 3.0
 */

include <main.scad>;
use <herringbone.scad>;

planetary_gear_bearing();

module planetary_gear_bearing(
	r = 30,
	h_sun = 15,
	h_planets = 15,
	h_rim = 20,
	planets = 5,
	teeth_planets = 7,
	approximate_teeth_sun = 8,
	pressure_angle = 45,
	clearance = .15,
	helix_angle = -360
) {
	//Calcualte valid teeth_sun
	k1 = round(2/planets*(approximate_teeth_sun + teeth_planets));
	k = k1 * planets % 2 != 0 ? k1+1 : k1;
	teeth_sun = k*planets/2 - teeth_planets;
	teeth_rim = teeth_sun + 2*teeth_planets;

	//Calculate pitch
	pitch = 1.8*r/(1+(PI/(2*teeth_rim*tan(pressure_angle))));
	circular_pitch = pitch*(2*PI+2);

	//Rim
	difference(){
		cylinder(
			r = r,
			h = h_rim
		);
		e() herringbone(
			teeth_rim,
			circular_pitch,
			pressure_angle,
			-clearance,
			helix_angle/teeth_rim,
			h_planets,
			h_planets
		);
		//HACK: Second subtraction to allow h_rim > h_planets
		translate([
			0,
			0,
			h_planets
		]) {
			e() mirror([0,1,0]) {
				herringbone(
					teeth_rim,
					circular_pitch,
					pressure_angle,
					-clearance,
					helix_angle/teeth_rim,
					h_planets,
					h_planets
				);
			}
		}
	}

	//Sun
	rotate([
		0,
		0,
		(teeth_planets + 1)*180/teeth_sun +
		$t*360/planets*(teeth_sun + teeth_planets)*2/teeth_sun
	]) {
		mirror([0,1,0]) {
			herringbone(
				teeth_sun,
				circular_pitch,
				pressure_angle,
				clearance,
				helix_angle/teeth_sun,
				h_planets,
				h_sun
			);
		}
	}

	//Planets
	for(i=[1:planets]) {
		rotate([
			0,
			0,
			i*360/planets + $t*360/planets
		]) {
			translate([
				pitch/2*(teeth_sun+teeth_planets)/teeth_rim,
				0,
				0
			]) {
				rotate([
					0,
					0,
					i*teeth_sun/planets*360/teeth_planets - 
					$t*360/planets*(teeth_sun+teeth_planets)/teeth_planets -
					$t*360/planets
				]) {
					herringbone(
						teeth_planets,
						circular_pitch,
						pressure_angle,
						clearance,
						helix_angle/teeth_planets,
						h_planets,
						h_planets
					);
				}
			}
		}
	}
}
