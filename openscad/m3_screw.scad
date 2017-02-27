// A very basic M3 screw

screw_diameter = 3;
screw_head_diameter=5; //TODO: Check this
screw_head_length = 3; //TODO: Check this

nut_width = 5.5;
nut_height = 2.5;

module m3_screw(screw_length=16) {
    translate([0,0,screw_head_length])
        cylinder(h=screw_length,d=screw_diameter,$fn=25);
    cylinder(h=screw_head_length,d=screw_head_diameter,$fn=25);
}