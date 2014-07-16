/*
 * Chain
 *
 * Copyright 2013 <b@Zi.iS>
 * License CC BY 3.0
 */

include <../main.scad>
use <MCAD/involute_gears.scad>

p = 150*$t;
x = 150.0-p;

chain(
	chain = [
		6.0,
		7.8	
	],
	gears = [
		[0, 0, 12, -1],
		[250- 1.15, 0, 12, -1],
		[55+x, 4, 8, -1],
		[40+x, 17, 8, 1],
		[25+x, 4, 8, -1]
	],
	pos = p,
	id = 1
) {
	chain_gear(
		12,
		[6,	7.8	],
		[6,	10,	3],
		id = 2
	);
	chain_gear(
		12,
		[6,	7.8	],
		[6,	10,	3],
		id = 3
	);
	chain_gear(
		8,
		[6,	7.8	],
		[6,	10,	3],
		id = 4
	);
	chain_gear(
		8,
		[6,	7.8	],
		[6,	10,	3],
		id = 5
	);
	chain_gear(
		8,
		[6,	7.8	],
		[6,	10,	3],
		id = 6
	);
}

*translate([0,34,0])
rotate([180,0,0])
chain(
	chain = [
		6.0,
		7.8	
	],
	gears = [
		[2.455, 0, 12, -1],
		[250, 0, 12, -1],
		[55+x, 4, 8, -1],
		[40+x, 17, 8, 1],
		[25+x, 4, 8, -1]
	],
	pos = p,
	id = 7
) {
	chain_gear(
		12,
		[6,	7.8	],
		[6,	10,	3],
		id = 8
	);
	chain_gear(
		12,
		[6,	7.8	],
		[6,	10,	3],
		id = 7
	);
	chain_gear(
		8,
		[6,	7.8	],
		[6,	10,	3],
		id = 8
	);
	chain_gear(
		8,
		[6,	7.8	],
		[6,	10,	3],
		id = 5
	);
	chain_gear(
		8,
		[6,	7.8	],
		[6,	10,	3],
		id = 10
	);
}

function _center_length(
	start,
	end
) = pow(pow(end[0] - start[0], 2) + pow(end[1] - start[1], 2), 0.5);

function _center_angle(
	start,
	end
) =  atan((end[0] - start[0])/ (end[1] - start[1])) + (end[1]<start[1] ? 180: 0);

function _radius_ratio(
	start,
	end
) = (-(end[2] * end[3]) + (start[2] * start[3]));

function _start_angle(
	start,
	end
) =  asin(_radius_ratio(start, end) / _center_length(start, end));

function _length(
	start,
	end
) = pow(pow(_center_length(start, end),2) - pow(_radius_ratio(start, end), 2), 0.5);

function __angle_wrapped( //Don't know direction
	prev,
	start,
	end
) = (-_center_angle(start, prev) -_start_angle(prev, start) + 90) - (-_center_angle(start, end) -_start_angle(start, end) - 90);


function _angle_wrapped( //Correct direction
	prev,
	start,
	end
) = ((-_center_angle(start, prev) -_start_angle(prev, start) + 90) - ((__angle_wrapped(prev, start, end)<0 ? 0:360)-_center_angle(start, end) -_start_angle(start, end) - 90)) ;

function _length_wrapped(
	chain,
	prev,
	start,
	end
) = chain[0]*abs(_angle_wrapped(prev, start, end))/360.0*start[2];

function _gear_length(
	chain,
	prev,
	start,
	end
) = _length(start, end) + _length_wrapped(chain, prev, start, end);

function chain_start(
	chain,
	gears
) = (-_center_angle(gears[0], gears[len(gears)-1]) -
	_start_angle(gears[len(gears)-1], gears[0]) + 90)/360*gears[0][2]*chain[0];
	

function chain_length(
	chain,
	gears,
	limit,
	running = 0
) = (limit==0) ?
		running :
		chain_length(
			chain,
			gears,
			limit-1,
			running + _gear_length(
				chain,
				gears[(len(gears)+limit-2)%len(gears)],
				gears[limit-1],
				gears[limit%len(gears)]
			)              
		);

module chain(
	chain,
	gears,
	pos = 0,
	id
) {
	if($children!=len(gears)) {
		echo("ERROR: chain must have correct number of child gears", $children, len(gears));
	}
	part(id, str(
		chain_length(chain, gears, len(gears)),
		"mm (",
		chain_length(chain, gears, len(gears))/chain[0],
		" links)  of ",
		chain[0],
		"x",
		chain[1],
		"mm chain"
	)) {
		for (i = [0 : len(gears)-1]) {
			translate([
				gears[i][0],
				gears[i][1],
				0
			]) {
				chain_span(
					chain,
					gears[(len(gears)-1+i)%len(gears)],
					gears[i],
					gears[(i+1)%len(gears)],
					-(chain[0]-chain_start(chain, gears)) + chain_length(chain, gears, i),
					pos
				);
			}
		}
	}

	for (i = [0 : $children-1]) {
		translate([
			gears[i][0],
			gears[i][1],
			0
		] * preview) {
			rotate([
				0,
				0,
				//TODO: check start offset: (i>0 ? (chain[0]+chain_start(chain, gears)) : 0)
				gears[i][3] *
				((chain_length(chain, gears, i) - pos + chain[0]/2) % chain[0] / chain[0]) * 
				(360/gears[i][2]) 
				- (i>0 ? _center_angle(gears[i], gears[i-1])+90: 0)
			] * preview) {
				children(i);
			}
		}
	}
}

module chain_span(
	chain,
	prev,
	start,
	end,
	off,
	pos
) {
    //TODO: correct handling of outside gears
	start_r = chain[0]/(2*PI)*start[2];
	offset = (chain[0] - ((_length_wrapped(chain, prev, start, end)+off -pos))) % chain[0];

	rotate(-_center_angle(start, end) -_start_angle(start, end)  - 90) {
		translate([0, -start[3]*(start_r), 0]) {
			rotate(90) {
				for(i=[offset:chain[0]:_length(start, end)]) {
					translate([
						0,
						i,
						0
					]) {
						cylinder(
							r = chain[0]/4,
							h = chain[1]
						);
					}			
				}
			}
		}
	}
	rpos = (1-(((off - pos) % chain[0])/chain[0])*(360/start[2]));

	a = (__angle_wrapped(prev, start, end)<0 ? 0:360)-_center_angle(start, end) -_start_angle(start, end) - 90;
	b = -_center_angle(start, prev) -_start_angle(prev, start) + 90;

	for(i=[
			min(a,b)+rpos:
			360/start[2]:
			max(a,b)	
		]
	) {
		rotate(i) {
			translate([0, -start[3]*(start_r), 0]) {
				cylinder(
					r = chain[0]/4,
					h = chain[1]
				);
			}
		}
	}
}

module chain_gear(
    teeth,
    chain,
    hub,
    id
) {
	part(id, str(teeth, " tooth gear for ", chain[0], "x", chain[1], "mm chain")) {
		color(color_steel) {
			gear(
				number_of_teeth = teeth,
				circular_pitch = chain[0] * 360/(2*PI),
				gear_thickness = chain[1]/3,
				rim_thickness = chain[1]/3,
				hub_thickness = hub[1],
				hub_diameter = hub[0]*2,
				bore_diameter = hub[2]*2
			);
		}
	}
	translate([
		0,
		0,
		hub[1]
	] * preview) {
        if($children) children([0:$children-1]);
	}
}

