// pulley insert

include <nema17.scad>

outer_diameter = 4.8;
inner_diameter = 3.6;
height = motor_pully_height;

$fn = 240;
module pully_insert() {
    difference() {
        cylinder(d=outer_diameter, h=height);
        cylinder(d=inner_diameter, h=height);
    }
}

pully_insert();