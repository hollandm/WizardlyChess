
module corner_post_pully() {
    end_cushion_length = 10;
    
    cpp_width_x = cpm_base_width_x;
    cpp_width_y = cpm_linear_rail_indent+end_cushion_length;
    cpp_height = cpm_base_height;
    
    pully_slot_width_x = motor_pully_height + 2; 
    
    difference() {
        union() {
            translate([0, -end_cushion_length, 0]) {
                cube([cpp_width_x, cpp_width_y, cpp_height]);
                cube([cpm_belt_slot_offset_x, cpp_width_y, cpm_motor_negative_offset_z]);
                
                translate([cpm_belt_slot_offset_x + pully_slot_width_x, 0,0 ]) {
                    cube([cpm_belt_slot_offset_x, cpp_width_y, cpm_motor_negative_offset_z]);
                    
                    translate([0, cpp_width_y/2, cpm_motor_negative_offset_z])
                        rotate([0, 90, 0])
                            cylinder(h=cpm_belt_slot_offset_x, d=cpp_width_y);
                }
                        
                translate([0, cpp_width_y/2, cpm_motor_negative_offset_z])
                    rotate([0, 90, 0])
                        cylinder(h=cpm_belt_slot_offset_x, d=cpp_width_y);
               
            }
            
            translate([cpm_rail2_offset_x, 0, cpm_rail_offset_z])
                rotate([-90, 0, 0])
                    cylinder(h=cpm_linear_rail_indent,d=cpm_rail_holder_diameter);
            
             
        }
        
        // Belt Slot
        translate([cpm_belt_slot_offset_x, -20, cpm_belt_slot_offset_z])
            cube([pully_slot_width_x, 40, cpm_belt_slot_offset_z]);
        
        translate([-1, cpp_width_y/2-end_cushion_length, cpm_motor_negative_offset_z])
            rotate([0, 90, 0]) {
                cylinder(h=cpm_belt_slot_offset_x*2+ pully_slot_width_x, d=motor_shaft_radius+0.1, $fn=300);
                cylinder(h=cpm_belt_slot_offset_x + pully_slot_width_x, d=motor_shaft_radius*2+0.1, $fn=300);
            }
            
        translate([cpm_base_width_x-cpm_linear_rail_indent, -4, 6])
            rotate([0, 90, 0])
                rail_negative();
            
        translate([cpm_rail2_offset_x, 0, cpm_rail_offset_z])
            rotate([-90,0,0])
                rail_negative();
            
        translate([cpm_rail1_offset_x, 0, cpm_rail_offset_z])
            rotate([-90,0,0])
                rail_negative();
    }
}