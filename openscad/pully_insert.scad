// pulley insert

include <nema17.scad>

pi_outer_diameter = 4.8;
pi_inner_diameter = 3.6;
pi_height = motor_pully_height;

$fn = 240;
module pully_insert() {
    difference() {
        cylinder(d=pi_outer_diameter, h=pi_height);
        cylinder(d=pi_inner_diameter, h=pi_height);
    }
}

//pully_insert();