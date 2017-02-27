include <m3_screw.scad>

button_width_x = 6.5;
button_width_y = 4;
button_width_z = 6.5;

pin_depth_x = 1;
pin_depth_y = 10;
pin_depth_z = 1.5;

wire_slot_x = 10;
    
button_cover_width_x = 10;
button_cover_width_y = 2;
button_cover_width_z = 30;
    
screw_indent_width_x = button_cover_width_x;
screw_indent_width_y = screw_head_length + button_cover_width_y + 1;
screw_indent_width_z = 10;

module button_cap() {
    
}

module button_screw_mount() {

    
    union() {
        translate([screw_indent_width_x/2, 0, screw_indent_width_z/2])
            rotate([-90, 0, 0])
                cylinder(h=16, d=screw_diameter, $fn=25);
        
        
        translate([screw_indent_width_x/2-nut_width/2, 10, screw_indent_width_z/2-nut_width/2-0.5])
            cube([nut_width, nut_height, 50]);
        
        cube([screw_indent_width_x, screw_indent_width_y, screw_indent_width_z]);
    }
}
//button_screw_mount();

module button_negative() {

       
    union() {
        
        translate([screw_indent_width_x, 0, screw_indent_width_z])
            rotate([0, 180, 0])
                button_screw_mount();
        
        cube([button_cover_width_x, button_cover_width_y, button_cover_width_z]);
        
        translate([-10, button_cover_width_y, button_cover_width_z/2 - button_width_z/2])
            cube([40, pin_depth_y, pin_depth_z]);
            
        translate([-10, button_cover_width_y, button_cover_width_z/2 + button_width_z/2 - pin_depth_z])
            cube([40, pin_depth_y, pin_depth_z]);
        
        translate([button_cover_width_x/2 - button_width_x/2, button_cover_width_y, button_cover_width_z/2 - button_width_z/2])
            cube([button_width_x, button_width_y, button_width_z]);
        
        translate([0,0, button_cover_width_z-screw_indent_width_z])
            button_screw_mount();
        
        
    }

}

//button_negative();