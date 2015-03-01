include <../main.scad>;

lfs81();
lfs81_bearing();

module lfs81(h=100, id) {
	part(id, str(h, "mm of LFS-8-1")) {
		color([.7,.7,.7])
			difference() {
				translate([-25/2, -13.5, 0])
					cube([25, 20, h]);
				translate([-6.5/2, -14, -.1])
					cube([6.5, 10.5, h+.2]);
				translate([-11/2, -10, -.1])
					cube([11, 4.5, h+.2]);
			}
		for(x=[-11,11])
			translate([x, 0, 0])
				color([.8,.8,.8])
					cylinder(d=8, h=h);
	}
}

module lfs81_bearing(id) {
	part(id, "LFS-8-1 bearing") {
		translate([-72/2,-10.5,-48]) color([.0,.0,.0]) cube([72, 28.5, 13]);
		translate([-72/2,-10.5,-35]) color([.7,.7,.7]) cube([72, 28.5, 70]);
		translate([-72/2,-10.5,35]) color([.0,.0,.0]) cube([72, 28.5, 13]);
	}
}