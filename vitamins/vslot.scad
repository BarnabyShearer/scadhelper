// from https://github.com/fponticelli/smallbridges

include <../main.scad>;
use <MCAD/shapes.scad>;

vslot(sections=2)
	vslot_r([1,0,0], 2)
		vslot(sections=2);

module vslot(length=100, sections=1, id) {
	size = sections * 20;

	cutext = [
		[12.00,4.50], [10.00,4.50], [8.20,2.78], [8.20,5.50],
		[6.56,5.50], [3.90,2.84], [3.90,0.21], [3.69,0.00],
		[3.90,-0.21], [3.90,-2.84], [6.56,-5.50], [8.20,-5.50],
		[8.20,-2.78], [10.00,-4.50], [12.00,-4.50]
	];
	cutint = [
		[16.10,0.21], [16.10,2.84], [12.70,6.24], [12.70,8.78],
		[7.30,8.78], [7.30,6.24], [3.90,2.84], [3.90,0.21],
		[3.69,0.00], [3.90,-0.21], [3.90,-2.84], [7.30,-6.24],
		[7.30,-8.78], [12.70,-8.78], [12.70,-6.24], [16.10,-2.84],
		[16.10,-0.21], [16.31,0.00]
	];
	cutcorner = [
		[8.20,8.20], [6.57,8.20], [6.57,7.66], [7.66,6.57],
		[8.20,6.57]
	];

	part(id, str(length, "mm of ", sections, " section vslot"))
		color([0.27, 0.27, 0.3])
			difference() {
				translate([0,0,length/2])
					roundedBox(20 * sections, 20, length, 1.5);
	
				//End slots
				e() for(i = [0,180])
					rotate([0,0,-i])
						translate([10 * (sections - 1), 0, -0]) {
							linear_extrude(length+20)
								polygon(cutext);
							translate([5,-2.89,-20])
								cube([10,5.78,length+40]);
						}
	
				//Side slots
				e() for(i = [90,270])
					rotate([0,0,-i])
						for(j = [0:sections-1])
							translate([0, (sections - 1) * 10 - 20 * j, 0]) {
								linear_extrude(length)
									polygon(cutext);
								translate([5,-2.89,-20])
									cube([10,5.78,length+40]);
							}
	
				//Center hole
				e() for(i = [0:sections-1])
						translate([i * 20 - 10 * (sections - 1),0,0])
							cylinder(length+20, 2.1, 2.1);
	
				//Corners
				e() for(i = [90,270]) rotate([0,0,-i])
					translate([0,(sections - 1) * 10,-0])
						linear_extrude(length)
							polygon(cutcorner);
				e() for(i = [ 0,180]) rotate([0,0,-i])
					translate([(sections - 1) * 10,0,0])
						linear_extrude(length)
							polygon(cutcorner);
	
				//Between sections
				e() if(sections > 1)
					for(i = [0:sections-2])
						translate([(sections - 3) * 10 - i * 20, 0, 0])
						linear_extrude(length)
							polygon(cutint);
			}
	translate([0,0,length])
		children();
}

module vslot_r(angle, segments) {
	rotate(angle*90)
		translate([
			10*segments * angle[1],
			-10 * angle[0],
			10 *abs(angle[0]) + 10 * segments * abs(angle[1])
		])
			children();
}

module vslot_rr(angle, segments) {
	rotate(angle*90)
		translate([
			-10*segments * angle[1],
			10 * angle[0],
			-10 *abs(angle[0]) - 10 * segments * abs(angle[1])
		])
			children();
}