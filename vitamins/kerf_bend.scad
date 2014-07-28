/*
 * MDF
 *
 * Copyright 2014 <b@Zi.iS>
 * License CC BY 3.0
 */

include <../main.scad>;
use <2d.scad>;

module kerf_bend(
    a,
    r,
    h,
    material,
    id
) {
    l = (2/(360/a)*PI*r/material[0]) * (material[0]/2 + kerf);
    if(preview==1)
        part(id, str(material[0], "mm ", material[1], " ", l + kerf, "x", h + kerf, "mm"))
            for(i=[0:PI*(a/180)*r/material[0]])
                rotate([0,0,i*(a/(PI*(a/180)*r/material[0]))])
                    translate([r,0,0])
                        color(material[2])
                            cube([material[0], material[0]/2, h]);
     if(preview==0)
        2d(
            [
                l,
                h,
                material[0]
            ],
            material,
            id=id
        ) {
            for(i=[0:PI*(a/180)*r/material[0]*.5]) {
                translate([-l/2+i*(material[0] + kerf*2)-.005,-h/2+material[0]*1.5,0])
                    e() cube([.01,h-material[0]*3,material[0]]);
                translate([-l/2+i*(material[0] + kerf*2)-.005 + kerf + material[0]/2,-h/2-material[0]*.75,0])
                    e() cube([.01,h/2,material[0]]);
                translate([-l/2+i*(material[0] + kerf*2)-.005 + kerf + material[0]/2,material[0]*.75,0])
                    e() cube([.01,h/2,material[0]]);
            }
        }
}
