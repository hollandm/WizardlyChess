include <m3_screw.scad>
include <nema17.scad>
include <rails.scad>
include <endstop_button.scad>

// Corner Post Motor

cpm_linear_rail_indent = 15;

cpm_base_width_x = 92;
cpm_base_width_y = 65;
cpm_base_height = 14;

cpm_post_offset_x = 30;

cpm_post_width_x = 20;
cpm_post_width_y = cpm_base_width_y;
cpm_post_height = 48;

cpm_motor_bed_indent = 12;
cpm_motor_indent_x = cpm_post_width_x-10;


cpm_rail_holder_diameter = 14;

cpm_rail1_offset_x = cpm_rail_holder_diameter/2;
cpm_rail2_offset_x = cpm_post_offset_x + cpm_post_width_x + 35;
cpm_rail_offset_z = cpm_base_height;
rail_distance_x = cpm_rail2_offset_x - cpm_rail1_offset_x;


cpm_motor_negative_offset_x = motor_base_height + cpm_post_offset_x + cpm_post_width_x - cpm_motor_indent_x;
cpm_motor_negative_offset_y = motor_width/2 + cpm_linear_rail_indent + 5;
cpm_motor_negative_offset_z = motor_width/2 + cpm_base_height - cpm_motor_bed_indent;

belt_slot_width_x = motor_shaft_length - cpm_motor_indent_x + motor_center_height + 1;
cpm_belt_slot_offset_x = cpm_post_offset_x - belt_slot_width_x;
cpm_belt_slot_offset_z = cpm_base_height - cpm_motor_bed_indent + motor_width/2 - motor_negative_shaft_diameter;

module corner_post_motor() {
    difference() {
        union() {
            cube([cpm_base_width_x, cpm_base_width_y, cpm_base_height]);
            
            translate([cpm_post_offset_x,0,0])
                cube([cpm_post_width_x, cpm_post_width_y, cpm_post_height]);
            
            translate([cpm_rail1_offset_x, 0, cpm_rail_offset_z])
                rotate([-90,0,0])
                    cylinder(h=cpm_linear_rail_indent-0.01,d=cpm_rail_holder_diameter);
            
            translate([cpm_rail2_offset_x, 0, cpm_rail_offset_z])
                rotate([-90,0,0])
                    cylinder(h=cpm_linear_rail_indent-0.01,d=cpm_rail_holder_diameter);
           
        }
        

        translate([cpm_motor_negative_offset_x,cpm_motor_negative_offset_y,cpm_motor_negative_offset_z])
            rotate([0,-90,0])
                motor_negative(cpm_motor_indent_x);
        
        corner_post_motor_yrails();
        
        translate([cpm_base_width_x-cpm_linear_rail_indent, cpm_linear_rail_indent/2, 6])
            rotate([0, 90, 0])
                rail_negative();
        
        // Belt Slot
        translate([cpm_belt_slot_offset_x, -1, cpm_belt_slot_offset_z])
            cube([belt_slot_width_x, cpm_motor_negative_offset_y,       
cpm_belt_slot_offset_z]);
        
        translate([cpm_post_offset_x+cpm_post_width_x/2-button_cover_width_x/2, -0.1, 2])
            button_negative();
        

    }
}   



module corner_post_motor_yrails() {
    
    translate([cpm_rail1_offset_x, cpm_linear_rail_indent, cpm_rail_offset_z])
        rotate([90,0,0])
            rail_negative();
    
    translate([cpm_rail2_offset_x, cpm_linear_rail_indent, cpm_rail_offset_z])
        rotate([90,0,0])
            rail_negative();
}


module corner_post_motor_motor() {
    translate([cpm_motor_negative_offset_x,cpm_motor_negative_offset_y,cpm_motor_negative_offset_z])
        rotate([0,-90,0])
            motor();
}