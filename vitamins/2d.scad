/*
 * MDF
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <../main.scad>;

2d();

module 2d(
	size = [10, 10],
    material = [
        6,
        "MDF",
        color_wood
    ],
    drill = [0, 0, 0, 0],
    drill_x = true, //drill corners or centers
    castle = [0, 0, 0, 0],
    castle_material = 0,
    castle_alt = [0, 1],
	id
) {
	part(id, str(material[0], "mm ", material[1], " ", size[0] + kerf, "x", size[1] + kerf, "mm"))
	drawing()
   	difference() {
    	translate([
    		-size[0]/2 - kerf/2*(1-preview),
    		-size[1]/2 - kerf/2*(1-preview),
    		0
    	] * preview) {
			color(material[2]) cube([
				size[0] + kerf*(1-preview),
				size[1] + kerf*(1-preview),
				material[0]
			]);
        }
        translate([
            size[0]/2 + kerf/2*(1-preview),
            size[1]/2 + kerf/2*(1-preview),
            0
        ] * (1-preview)) {
            e() if($children) children([0:$children-1]);
            for(x=[0,1]) {
                if(castle[2*x] > 0) {
                    for(i=[0:floor(size[0]/castle[2*x])]) {
                        if(i*castle[2*x]!=size[0] && i%2==castle_alt[0]) {
                            translate([
                                -.1*preview + -size[0]/2 + (size[0] - castle[2*x] * floor(size[0]/castle[2*x])) / 2 + i * castle[2*x],
                                -.1*preview + -size[1]/2 - kerf/2*(1-preview) + (size[1] + kerf*(1-preview) - (castle_material ? castle_material[0] : material[0]))*x,
                                0
                            ]) {
                                if(i==0) {
                                    e() translate([-kerf/2*(1-preview), 0, 0]) cube([
                                        kerf*(1-preview),
                                        castle_material ? castle_material[0] : material[0],
                                        material[0]
                                    ]);
                                }
                                if(i==floor(size[0]/castle[2*x])-1) {
                                    e() translate([kerf/2*(1-preview), 0, 0]) cube([
                                        castle[2*x],
                                        castle_material ? castle_material[0] : material[0],
                                        material[0]
                                    ]);
                                }
                                e() cube([
                                    castle[2*x] - kerf*(1-preview) + .2*preview,
                                    castle_material ? castle_material[0] : material[0] + .2*preview,
                                    material[0]
                                ]);
                            }
                        }
                    }
                }
                if(castle[2*x+1] > 0) {
                    for(i=[0:floor(size[1]/castle[2*x+1])]) {
                        if (i*castle[2*x+1]!=size[1] && i%2==castle_alt[1]) {
                            translate([
                                -.1*preview -size[0]/2 - kerf/2*(1-preview) + (size[0] + kerf*(1-preview) - (castle_material ? castle_material[0] : material[0]))*x,
                                -.1*preview -size[1]/2 + (size[1] - castle[2*x+1] * floor(size[1]/castle[2*x+1])) / 2 + i * castle[2*x+1],
                                0
                            ]) {
                                if(i==0) {
                                    e() translate([0,-kerf/2*(1-preview), 0]) cube([
                                        castle_material ? castle_material[0] : material[0],
                                        kerf*(1-preview),
                                        material[0]
                                    ]);
                                }
                                if(i==floor(size[1]/castle[2*x+1])-1) {
                                    e() translate([0, kerf/2*(1-preview), 0]) cube([
                                        castle_material ? castle_material[0] : material[0],
                                        castle[2*x+1],
                                        material[0]
                                    ]);
                                }
                                e() cube([
                                    castle_material ? castle_material[0] : material[0] + .2*preview,
                                    castle[2*x+1] - kerf*(1-preview) + .2*preview,
                                    material[0]
                                ]);
                            }
                        }
                    }
                }
                for(y=[0,1]) {
                    if(drill[2*x + y] > 0) {
                        if(drill_x) {
                            translate([
                                (size[0]/2 - material[0]/2)*(2*x-1),
                                (size[1]/2 - material[0]/2)*(2*y-1),
                                0
                            ]) {
                                e() kerf_cylinder(
                                    r = drill[2*x + y]/2,
                                    h = material[0]
                                );
                            }
                        } else {
                            translate([
                                (size[0]/2 - material[0]/2)*(2*x-1)*(1-y),
                                (size[1]/2 - material[0]/2)*(2*x-1)*(y),
                                0
                            ]) {
                                e() kerf_cylinder(
                                    r = drill[2*x + y]/2,
                                    h = material[0]
                                );
                            }
                        }
                    }
                }
            }
        }
	}
}

module 2d_cylinder(
	size = 10,
    material = [
        6,
        "MDF",
        color_wood
    ],
    id
) {
	part(id, str(material[0], "mm ", material[1], " ", size*2+ kerf, "x", size*2+ kerf, "mm"))
	drawing()
	translate([
		size + kerf/2*(1-preview),
		size + kerf/2*(1-preview),
		0
	] * (1-preview)) {
    	difference() {
    		color(material[2]) cylinder(
	    		r = size + kerf/2*(1-preview),
		    	h = material[0]
    		);
            if($children) children([0:$children-1]);
        }
	}
}
