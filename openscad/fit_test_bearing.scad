include <rails.scad>

difference() {
    translate([0,0,bearing_height/2])
        cube([22, 22, bearing_height], center=true);
    bearing_negative();
}
