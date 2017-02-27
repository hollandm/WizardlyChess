// Motor Test Piece
//      So I can find a good fit without printing the whole assembally every time

include <nema17.scad>

difference() {
    cube([48,48,10]);

    translate([24,24,45])
        rotate([0,180,0])
            motor_negative();
}