include <m3_screw.scad>
include <nema17.scad>
include <rails.scad>
include <endstop_button.scad>

electromagnet_diameter = 25; //mm
electromagnet_height = 20; //mm
module electromagnet() {
    color([1/2,1/2,1/2])
        cylinder(h = electromagnet_height, d = electromagnet_diameter, $fn=25);
}

linear_rail_indent = 15;


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
cpm_motor_negative_offset_y = motor_width/2 + linear_rail_indent + 5;
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
                    cylinder(h=linear_rail_indent-0.01,d=cpm_rail_holder_diameter);
            
            translate([cpm_rail2_offset_x, 0, cpm_rail_offset_z])
                rotate([-90,0,0])
                    cylinder(h=linear_rail_indent-0.01,d=cpm_rail_holder_diameter);
           
        }
        

        translate([cpm_motor_negative_offset_x,cpm_motor_negative_offset_y,cpm_motor_negative_offset_z])
            rotate([0,-90,0])
                motor_negative(cpm_motor_indent_x);
        
        corner_post_motor_yrails();
        
        translate([cpm_base_width_x-linear_rail_indent, linear_rail_indent/2, 6])
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
    
    translate([cpm_rail1_offset_x, linear_rail_indent, cpm_rail_offset_z])
        rotate([90,0,0])
            rail_negative();
    
    translate([cpm_rail2_offset_x, linear_rail_indent, cpm_rail_offset_z])
        rotate([90,0,0])
            rail_negative();
}


module corner_post_motor_motor() {
    translate([cpm_motor_negative_offset_x,cpm_motor_negative_offset_y,cpm_motor_negative_offset_z])
        rotate([0,-90,0])
            motor();
}

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
                cube([linear_rail_indent, rail_mount_width_y, tram_rail_offset_z-tram_base_height]);
                translate([0, rail_mount_width_y/2, tram_rail_offset_z-tram_base_height])
                    rotate([0, 90, 0])
                        cylinder(d=rail_mount_width_y, h=linear_rail_indent);
            }
            
            translate([rail_mount_offset_x, tram_rail_2_offset_y - rail_mount_width_y/2, tram_base_height]) {
                cube([linear_rail_indent, rail_mount_width_y, tram_rail_offset_z-tram_base_height]);
                translate([0, rail_mount_width_y/2, tram_rail_offset_z-tram_base_height])
                    rotate([0, 90, 0])
                        cylinder(d=rail_mount_width_y, h=linear_rail_indent);
            }
        }
        // Bearing Slots
        translate([tram_bearing1_offset_x, tram_bearing1_offset_y, tram_bearing1_offset_z])
            rotate([-90,0,0])
                cylinder(h=bearing_height, d=bearing_outer_diameter);
        
        translate([tram_bearing2_offset_x, tram_bearing2_offset_y, tram_bearing2_offset_z])
            rotate([-90,0,0])
                cylinder(h=bearing_height, d=bearing_outer_diameter);
        
        translate([tram_bearing3_offset_x, tram_bearing3_offset_y, tram_bearing3_offset_z])
            rotate([-90,0,0])
                cylinder(h=bearing_height, d=bearing_outer_diameter);
        
        translate([tram_bearing4_offset_x, tram_bearing4_offset_y, tram_bearing4_offset_z])
            rotate([-90,0,0])
                cylinder(h=bearing_height, d=bearing_outer_diameter);
        
        // Smaller holes next to bearings
        translate([tram_bearing1_offset_x, tram_bearing1_offset_y, tram_bearing1_offset_z])
            rotate([-90,0,0])
                cylinder(h=tram_base_width_y, d=bearing_outer_diameter-2);
        
        translate([tram_bearing2_offset_x, tram_bearing2_offset_y, tram_bearing2_offset_z])
            rotate([-90,0,0])
                cylinder(h=tram_base_width_y, d=bearing_outer_diameter-2);
        
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




module corner_post_2rail() {
    end_cushion_length = 10;
    
    cp2r_width_x = cpm_base_width_x;
    cp2r_width_y = linear_rail_indent+end_cushion_length;
    cp2r_height = cpm_base_height;
    
    pully_slot_width_x = motor_pully_height + 2; 
    
    difference() {
        union() {
            translate([0, -end_cushion_length, 0]) {
                cube([cp2r_width_x, cp2r_width_y, cp2r_height]);
                cube([cpm_belt_slot_offset_x, cp2r_width_y, cpm_motor_negative_offset_z]);
                
                translate([cpm_belt_slot_offset_x + pully_slot_width_x, 0,0 ]) {
                    cube([cpm_belt_slot_offset_x, cp2r_width_y, cpm_motor_negative_offset_z]);
                    
                    translate([0, cp2r_width_y/2, cpm_motor_negative_offset_z])
                        rotate([0, 90, 0])
                            cylinder(h=cpm_belt_slot_offset_x, d=cp2r_width_y);
                }
                        
                translate([0, cp2r_width_y/2, cpm_motor_negative_offset_z])
                    rotate([0, 90, 0])
                        cylinder(h=cpm_belt_slot_offset_x, d=cp2r_width_y);
               
            }
            
            translate([cpm_rail2_offset_x, 0, cpm_rail_offset_z])
                rotate([-90, 0, 0])
                    cylinder(h=linear_rail_indent,d=cpm_rail_holder_diameter);
            
             
        }
        
        // Belt Slot
        translate([cpm_belt_slot_offset_x, -20, cpm_belt_slot_offset_z])
            cube([pully_slot_width_x, 40, cpm_belt_slot_offset_z]);
        
        translate([-1, cp2r_width_y/2-end_cushion_length, cpm_motor_negative_offset_z])
            rotate([0, 90, 0])
                cylinder(h=cpm_belt_slot_offset_x*2+ pully_slot_width_x + 2, d=motor_shaft_radius);
    }
}

corner_post_motor();
//corner_post_motor_yrails();
//corner_post_motor_motor();
//translate([tram_offset_x, -70, tram_offset_z])
//    tram_assembally();
//translate([0, -(linear_rail_length-linear_rail_indent), 0])
//    corner_post_2rail();