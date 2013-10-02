/*
 * Herringbone Gear
 *
 * Copyright 2013 b@Zi.iS
 *
 * License CC BY 3.0
 */

include <main.scad>;
use <MCAD/involute_gears.scad>;

herringbone();

module herringbone(
	number_of_teeth = 15,
	circular_pitch = 10,
	pressure_angle = 28,
	clearance = 0,
	helix_angle = 0,
	h = 5,
	h_hub = 5,
){
	if(preview==1) {
		//Too slow for preview
		cylinder(
			r = circular_pitch*number_of_teeth/360,
			h = h
		);
	} else {

		translate([
			0,
			0,
			h/2
		]) {
			gear(
				number_of_teeth = number_of_teeth,
				circular_pitch = circular_pitch,
				pressure_angle = pressure_angle,
				clearance = clearance,
				twist = helix_angle,
				gear_thickness = h/2,
				rim_thickness = h/2,
				hub_thickness = h_hub/2,
				bore_diameter = 0
			);
			mirror([0,0,1]) gear(
				number_of_teeth = number_of_teeth,
				circular_pitch = circular_pitch,
				pressure_angle = pressure_angle,
				clearance = clearance,
				twist = helix_angle,
				gear_thickness = h/2,
				rim_thickness = h/2,
				hub_thickness = h/2,
				bore_diameter = 0
			);
		}
	}
}
