/*
 * Slightly offset previews to overcome rounding issues
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <config.scad>;

module e(
	shift = -.1,
	size = 1.1
) {
	if(preview == 1) {
		translate([
			0,
			0,
			shift
		]) {
			scale([
				1,
				1,
				size
			]) {
                if($children) children([0:$children-1]);
			}
		}
	} else {
        if($children) children([0:$children-1]);
	}
}

function space(pitch, i) = -pitch/2 + pitch*i;
