include <../main.scad>;
use <bearing.scad>;
use <hardware.scad>;

//20mm nominal spacing = ~19.8 for tension

v_wheel_mount();

module v_wheel_mount(id) {
	v_wheel_spacer(id= id) {
		v_wheel(id + 1);
		bearing([5, 16, 5], id=id+2)
			translate([0,0,.95])
				bearing([5, 16, 5], id=id+3)
					m_washer(5, id=id+4)
						m_nylock(5, id=id+5);
	}
}

module v_wheel(id) {
	part(id, "Solid V-Wheel")
		color([.3,.3,.3]) {
			translate([0,0,.25])
				cylinder(
					d1 = 19.3,
					d2 = 24.39,
					h = 2.5
				);
			translate([0,0,.25+2.5])
				cylinder(
					d = 24.39,
					h = 5.38
				);
		
			translate([0,0,.25+2.5+5.38])
				cylinder(
					d1 = 24.39,
					d2 = 19.3,
					h = 2.5
				);
		}
}

module v_wheel_spacer(length = 5, id) {
	part(id, str("V-Wheel spacer ", length, "mm"))
		color([.8,.8,.8])
			cylinder(
				d = 8,
				h = 5
			);
	translate([0, 0, length])
		children();
}