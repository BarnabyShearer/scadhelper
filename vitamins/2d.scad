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
	id
) {
	part(id, str(material[0], "mm ", material[1], " ", size[0] + kerf*(1-preview), "x", size[1] + kerf*(1-preview), "mm"))
    if($children!=1) {
        echo("ERROR: Openscad's $children bug means this must have exactly 1 child");
    }
	drawing()
   	difference() {
    	translate([
    		-size[0]/2,
    		-size[1]/2,
    		0
    	] * preview) {
			color(material[2]) cube([
				size[0] + kerf*(1-preview),
				size[1] + kerf*(1-preview),
				material[0]
			]);
        }
        translate([
            size[0]/2 + kerf/2,
            size[1]/2 + kerf/2,
            0
        ] * (1-preview)) {
    		if($children>0) for (i = [0:$children-1]) e() child(i);
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
	part(id, str(material[0], "mm ", material[1], " ", size*2+ kerf*(1-preview), "x", size*2+ kerf*(1-preview), "mm"))
    if($children!=1) {
        echo("ERROR: Openscad's $children bug means this must have exactly 1 child");
    }
	drawing()
	translate([
		size + kerf/2,
		size + kerf/2,
		0
	] * (1-preview)) {
    	difference() {
    		color(material[2]) cylinder(
	    		r = size + kerf/2,
		    	h = material[0]
    		);
    		if($children>0) for (i = [0:$children-1]) e() child(i);
        }
	}
}