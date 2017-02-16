// Basic Nema 17 Stepper Motor


motor_base_height = 42;
motor_width = 42;
motor_bevel_width = 54;

motor_center_radius = 11;
motor_center_height = 2;

motor_shaft_length = 20;
motor_shaft_radius = 2.5;

motor_screw_offset = 15.5;
motor_screw_depth = 5;

motor_pully_diameter1 = 16;
motor_pully_diameter2 = 12;
motor_pully_diameter3 = 16;
motor_pully_height1 = 10;
motor_pully_height2 = 5;
motor_pully_height3 = 1;
motor_pully_height = motor_pully_height1 + motor_pully_height2 + motor_pully_height3;

motor_pully_diameter = 16;

motor_height = motor_base_height + motor_center_height + motor_shaft_length;

module motor() {
    
    union() {

    translate([0,0,motor_base_height/2])
    difference(){
        
        // Motor Body
        color([0,0,0])
        intersection(){
            cube([motor_width,motor_width, motor_base_height], center = true);
            rotate([0,0,45]) 
                translate([0,0,-1]) 
                    cube([motor_bevel_width, motor_bevel_width, motor_base_height+2], center = true);
        }
             
            
        // Screw Holes
        color([1/3,1/3,1/3]) 
        for(i=[0:3]){
                rotate([0, 0, 90*i])
                    translate([motor_screw_offset, motor_screw_offset, 0.1-motor_screw_depth+motor_base_height/2]) 
                        cylinder(h=motor_screw_depth, d=screw_diameter, $fn=25);
        }
    }
    // Motor Center
    color([1/3,1/3,1/3]) 
    translate([0, 0, motor_base_height]) 
        cylinder(h=motor_center_height, r=motor_center_radius, $fn=25);
        
    // Motor Shaft
    color([1/3,1/3,1/3]) 
    translate([0, 0, motor_base_height+motor_center_height]) 
        cylinder(h=motor_shaft_length, r=motor_shaft_radius, $fn=25);
    
    // Motor Pully
    color([1/2,1/2,1/2]) 
    translate([0, 0, motor_base_height+motor_center_height+motor_shaft_length-motor_pully_height])  {
            cylinder(h=motor_pully_height1, d=motor_pully_diameter1, $fn=25);
            translate([0,0,motor_pully_height1]) {
                cylinder(h=motor_pully_height2, d=motor_pully_diameter2, $fn=25);
                translate([0,0,motor_pully_height2])
                    cylinder(h=motor_pully_height3, d=motor_pully_diameter3, $fn=25);
            }
        }
    }
}

motor_negative_shaft_diameter = motor_center_radius+1;
module motor_negative(screw_hole_depth=100) {
    echo(screw_hole_depth);
    translate([0,0,-motor_base_height])
    union() {

    translate([0,0,motor_base_height*2])
        
        // Motor Body
        translate([0,0,-motor_base_height])
        intersection(){
            cube([motor_width,motor_width, motor_base_height*2], center = true);
            rotate([0,0,45]) 
                translate([0,0,-1]) 
                    cube([motor_bevel_width, motor_bevel_width, motor_base_height*2+2], center = true);
        }
            
        // Screw Holes
        for(i=[0:3]){
                rotate([0, 0, 90*i])
                    translate([motor_screw_offset, motor_screw_offset, motor_base_height*2-1]) {
                        cylinder(h=screw_hole_depth+1, d=screw_diameter, $fn=25);
                        translate([0,0, screw_hole_depth+1])
                            cylinder(h=100, d=6, $fn=25);
                            
                    }
    }
    // Motor Center
    translate([0, 0, motor_base_height*2-1]) 
        cylinder(h=101+screw_hole_depth, r=motor_negative_shaft_diameter, $fn=25);
    }
}