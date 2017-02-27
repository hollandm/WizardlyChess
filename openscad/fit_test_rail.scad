// Rail Test Fit

include <rails.scad>

difference() {
    cylinder(r=6,h=15);

    translate([0,0,2])
        rail_negative();
}