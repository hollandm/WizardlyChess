include <endstop_button.scad>

difference() {
    cube ([14,10,12]);
    
    translate([2,-10, 13])
        rotate([-90,0,0])
            button_negative();
}