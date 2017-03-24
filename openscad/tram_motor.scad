include <m3_screw.scad>
include <nema17.scad>
include <rails.scad>
include <endstop_button.scad>

include <corner_post_motor.scad>

tram_offset_x = -6;
tram_offset_z = cpm_rail_offset_z - bearing_outer_diameter/2;

tram_base_width_x = rail_distance_x - tram_offset_x*2 + 2*cpm_rail1_offset_x;
tram_base_width_y = motor_height;
tram_base_height = 20;

tram_motor_mount_offset_x = -tram_offset_x  + cpm_post_offset_x;
tram_motor_mount_width_x = motor_width + 10;
tram_motor_mount_width_y = motor_base_height+10;

tram_motor_offset_x = tram_motor_mount_offset_x + motor_width/2 + 5;
tram_motor_offset_z = tram_base_height+motor_width/2 - 9;

tram_bearing1_offset_x = -tram_offset_x + cpm_rail1_offset_x;
tram_bearing1_offset_y = -0.01;
tram_bearing1_offset_z = bearing_outer_diameter/2;

tram_bearing2_offset_x = -tram_offset_x + cpm_rail2_offset_x;
tram_bearing2_offset_y = -0.01;
tram_bearing2_offset_z = bearing_outer_diameter/2;

tram_bearing3_offset_x = -tram_offset_x + cpm_rail1_offset_x;
tram_bearing3_offset_y = tram_base_width_y - bearing_height + 0.01;
tram_bearing3_offset_z = bearing_outer_diameter/2;

tram_bearing4_offset_x = -tram_offset_x + cpm_rail2_offset_x;
tram_bearing4_offset_y = tram_base_width_y - bearing_height + 0.01;
tram_bearing4_offset_z = bearing_outer_diameter/2;

tram_belt_hole_offset_x = -tram_offset_x + cpm_belt_slot_offset_x;
tram_belt_hole_offset_z = -tram_offset_z + cpm_belt_slot_offset_z;

tram_rail_offset_x = tram_motor_mount_offset_x + tram_motor_mount_width_x;
tram_rail_1_offset_y = 10;
tram_rail_2_offset_y = tram_motor_mount_width_y - 10;
tram_rail_offset_z = tram_motor_offset_z;
module tram() {
    
    
    difference() {
        
        union() {
            // Tram Base
            cube([tram_base_width_x, tram_base_width_y, tram_base_height]);
            
            // Motor Mount Cube
            translate([tram_motor_mount_offset_x, 0, tram_base_height])
                cube([tram_motor_mount_width_x, tram_motor_mount_width_y, motor_width/2 - tram_base_height + tram_motor_offset_z]);
            
            rail_mount_offset_x = tram_motor_mount_offset_x+tram_motor_mount_width_x;
            rail_mount_width_y = cpm_rail_holder_diameter;
            // X-Axis Rail Holders
            translate([rail_mount_offset_x, tram_rail_1_offset_y - rail_mount_width_y/2, tram_base_height]) {
                cube([cpm_linear_rail_indent, rail_mount_width_y, tram_rail_offset_z-tram_base_height]);
                translate([0, rail_mount_width_y/2, tram_rail_offset_z-tram_base_height])
                    rotate([0, 90, 0])
                        cylinder(d=rail_mount_width_y, h=cpm_linear_rail_indent);
            }
            
            translate([rail_mount_offset_x, tram_rail_2_offset_y - rail_mount_width_y/2, tram_base_height]) {
                cube([cpm_linear_rail_indent, rail_mount_width_y, tram_rail_offset_z-tram_base_height]);
                translate([0, rail_mount_width_y/2, tram_rail_offset_z-tram_base_height])
                    rotate([0, 90, 0])
                        cylinder(d=rail_mount_width_y, h=cpm_linear_rail_indent);
            }
            
//            translate([16, 16, 20])
//                cube([22, 6, 4]);
//            
//            translate([16, 30, 20])
//                cube([22, 6, 4]);
            
            belt_holder_offset = 6;
            belt_holder_width = 16;
            
            translate([16, belt_holder_offset, 20])
                cube([22, belt_holder_width, 4]);
            
            translate([16, tram_base_width_y-belt_holder_width-belt_holder_offset, 20])
                cube([22, belt_holder_width, 4]);
        }
        // Bearing Slots
        translate([tram_bearing1_offset_x, tram_bearing1_offset_y + bearing_height, tram_bearing1_offset_z])
            rotate([-90,0,180])
                bearing_negative();
        
        translate([tram_bearing2_offset_x, tram_bearing2_offset_y + bearing_height, tram_bearing2_offset_z])
            rotate([-90,0,180])
                bearing_negative();
        
        translate([tram_bearing3_offset_x, tram_bearing3_offset_y, tram_bearing3_offset_z])
            rotate([-90,0,0])
                bearing_negative();
        
        translate([tram_bearing4_offset_x, tram_bearing4_offset_y, tram_bearing4_offset_z])
            rotate([-90,0,0])
                bearing_negative();
        
        // Smaller holes next to bearings
        translate([tram_bearing1_offset_x, tram_bearing1_offset_y, tram_bearing1_offset_z])
            rotate([-90,0,0])
                cylinder(h=tram_base_width_y, d=linear_rail_diameter+1);
        
        translate([tram_bearing2_offset_x, tram_bearing2_offset_y, tram_bearing2_offset_z])
            rotate([-90,0,0])
                cylinder(h=tram_base_width_y, d=linear_rail_diameter+1);
                
        // Slots next to the bearings (to pry the bearing out if needed)
//        extraction_slot_width_x = 4;
//        extraction_slot_width_z = 4;
//        translate([tram_bearing1_offset_x, tram_base_width_y/1.5, extraction_slot_width_z/2-0.01])
//            cube([extraction_slot_width_x, tram_base_width_y/1.5, extraction_slot_width_z], center=true);
        
        // Motor Negative
        translate([tram_motor_offset_x, 0, tram_motor_offset_z+0.01])
            rotate([-90,0,0])
                motor_negative(screw_hole_depth=tram_motor_mount_width_y-motor_base_height);
      
      
        
        // Belt Hole
        translate([tram_belt_hole_offset_x, -1, tram_belt_hole_offset_z])
            cube([belt_slot_width_x, 100, 8]);
            
        // Belt indent
        translate([tram_belt_hole_offset_x, -1, tram_base_height - 2])
            cube([belt_slot_width_x,200, 3]);
            
            
        // Rails
        translate([tram_rail_offset_x, tram_rail_1_offset_y, tram_rail_offset_z])
            rotate([0, 90, 0])
                rail_negative();
        
        translate([tram_rail_offset_x, tram_rail_2_offset_y, tram_rail_offset_z])
            rotate([0, 90, 0])
                rail_negative();
                

                
    }
    
}

module tram_assembally() {
    
    tram();

    translate([tram_motor_mount_offset_x + motor_width/2 + 5, 0, tram_motor_offset_z + 0.01])
        rotate([-90,0,0])
            motor();
    
    translate([tram_bearing1_offset_x, tram_bearing1_offset_y, tram_bearing1_offset_z])
        rotate([-90,0,0])
            bearing();
    
    translate([tram_bearing2_offset_x, tram_bearing2_offset_y, tram_bearing2_offset_z])
        rotate([-90,0,0])
            bearing();
    
    translate([tram_bearing3_offset_x, tram_bearing3_offset_y, tram_bearing3_offset_z])
        rotate([-90,0,0])
            bearing();
    
    translate([tram_bearing4_offset_x, tram_bearing4_offset_y, tram_bearing4_offset_z])
        rotate([-90,0,0])
            bearing();
    
    translate([tram_rail_offset_x, 10, tram_motor_offset_z])
        rotate([0, 90, 0])
            rail_negative();
    
    translate([tram_rail_offset_x, tram_motor_mount_width_y - 10, tram_motor_offset_z])
        rotate([0, 90, 0])
            rail_negative();


}