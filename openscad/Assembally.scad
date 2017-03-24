include <m3_screw.scad>
include <nema17.scad>
include <rails.scad>
include <endstop_button.scad>
include <magnet.scad>

include <corner_post_motor.scad>
include <corner_post_pully.scad>

include <tram_motor.scad>

corner_post_motor();
corner_post_motor_yrails();
corner_post_motor_motor();
translate([tram_offset_x, -70, tram_offset_z])
    tram_assembally();
translate([0, -(linear_rail_length-cpm_linear_rail_indent), 0])
    corner_post_pully();