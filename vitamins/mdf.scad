/*
 * MDF
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <../main.scad>;

mdf();

module mdf(
	size = [10, 10],
	thickness = 6,
	id
) {
	part(id, str(thickness, "mm MDF ", size[0] + kerf*(1-preview), "x", size[1] + kerf*(1-preview), "mm"))
	drawing()
   	difference() {
    	translate([
    		-size[0]/2,
    		-size[1]/2,
    		0
    	] * preview) {
			color(color_wood) cube([
				size[0] + kerf*(1-preview),
				size[1] + kerf*(1-preview),
				thickness
			]);
        }
        translate([
            size[0]/2 + kerf/2,
            size[1]/2 + kerf/2,
            0
        ] * (1-preview)) {
       		if($children>0) e() for(i = [0 : $children]) child(i);
        }
	}
}

module mdf_cylinder(
	size = 10,
	thickness = 6,
    id
) {
	part(id, str(thickness, "mm MDF ", size*2+ kerf*(1-preview), "x", size*2+ kerf*(1-preview), "mm"))
	drawing()
	translate([
		size + kerf/2,
		size + kerf/2,
		0
	] * (1-preview)) {
    	difference() {
    		color(color_wood) cylinder(
	    		r = size + kerf/2,
		    	h = thickness
    		);
    		if($children>0) e() for (i = [0:$children]) child(i);
        }
	}
}
