motor_height = 42;
motor_width = 42;
motor_bevel_width = 54;

motor_center_radius = 11;
motor_center_height = 2;

motor_shaft_length = 20;
motor_shaft_radius = 2.5;

motor_screw_offset = 15.5;
motor_screw_radius = 1.5;
motor_screw_depth = 5;

motor_pully_diameter1 = 16;
motor_pully_diameter2 = 12;
motor_pully_diameter3 = 16;
motor_pully_height1 = 10;
motor_pully_height2 = 5;
motor_pully_height3 = 1;

motor_pully_height = 16;
motor_pully_diameter = 16;

module motor() {
    
    union() {

    translate([0,0,motor_height/2])
    difference(){
        
        // Motor Body
        color([0,0,0])
        intersection(){
            cube([motor_width,motor_width, motor_height], center = true);
            rotate([0,0,45]) 
                translate([0,0,-1]) 
                    cube([motor_bevel_width, motor_bevel_width, motor_height+2], center = true);
        }
             
            
        // Screw Holes
        color([1/3,1/3,1/3]) 
        for(i=[0:3]){
                rotate([0, 0, 90*i])
                    translate([motor_screw_offset, motor_screw_offset, 0.1-motor_screw_depth+motor_height/2]) 
                        cylinder(h=motor_screw_depth, r=motor_screw_radius, $fn=25);
        }
    }
    // Motor Center
    color([1/3,1/3,1/3]) 
    translate([0, 0, motor_height]) 
        cylinder(h=motor_center_height, r=motor_center_radius, $fn=25);
        
    // Motor Shaft
    color([1/3,1/3,1/3]) 
    translate([0, 0, motor_height+motor_center_height]) 
        cylinder(h=motor_shaft_length, r=motor_shaft_radius, $fn=25);
    
    // Motor Pully
    color([1/2,1/2,1/2]) 
    translate([0, 0, motor_height+motor_center_height+motor_shaft_length-motor_pully_height])  {
            cylinder(h=motor_pully_height1, d=motor_pully_diameter1, $fn=25);
            translate([0,0,motor_pully_height1]) {
                cylinder(h=motor_pully_height2, d=motor_pully_diameter2, $fn=25);
                translate([0,0,motor_pully_height2])
                    cylinder(h=motor_pully_height3, d=motor_pully_diameter3, $fn=25);
            }
        }
    }
}

module motor_negative() {
    
    union() {

    translate([0,0,motor_height/2])
        
        // Motor Body
        intersection(){
            cube([motor_width,motor_width, motor_height], center = true);
            rotate([0,0,45]) 
                translate([0,0,-1]) 
                    cube([motor_bevel_width, motor_bevel_width, motor_height+2], center = true);
        }
            
        // Screw Holes
        for(i=[0:3]){
                rotate([0, 0, 90*i])
                    translate([motor_screw_offset, motor_screw_offset, motor_height-1]) 
                        cylinder(h=50, r=motor_screw_radius, $fn=25);
    }
    // Motor Center
    translate([0, 0, motor_height-1]) 
        cylinder(h=50, r=motor_center_radius+1, $fn=25);
    }
}

linear_rail_diameter = 8;
linear_rail_length = 506;
module rail() {
    color([1/2,1/2,1/2])
        cylinder(d = linear_rail_diameter, h = linear_rail_length, $fn=25);
}

bearing_height = 24;
bearing_outer_diameter = 15;
bearing_innter_diameter = 8;
module bearing() {
    difference() {
        cylinder(h = bearing_height, d = bearing_outer_diameter, $fn=25);
        translate([0,0,-1])
            cylinder(h = bearing_height+2, d = bearing_innter_diameter, $fn=25);
    }
}

electromagnet_diameter = 25; //mm
electromagnet_height = 20; //mm
module electromagnet() {
    color([1/2,1/2,1/2])
        cylinder(h = electromagnet_height, d = electromagnet_diameter, $fn=25);
}

post_motor_depth_x = 10;
post_motor_depth_y = 20;
post_motor_depth_y2 = 3;
post_motor_depth_z = 8;

tram_offset_z = 5;
tram_bearing_insulation = 5;

post_height = 80;
post_length = post_motor_depth_y+motor_width + post_motor_depth_z;

post_motor_z = tram_offset_z+motor_shaft_length;

post_base_width = motor_height+post_motor_depth_x-0.1;
post_base_height = post_motor_z + post_motor_depth_z;

tram_width = bearing_outer_diameter+tram_bearing_insulation*2+motor_width;
tram_length = bearing_height*2+tram_bearing_insulation*2;
tram_z = 5+motor_shaft_length;
tram_height = bearing_outer_diameter*2+tram_bearing_insulation*3;

post_yrail_lower_z = tram_offset_z + motor_shaft_length + bearing_outer_diameter/2+tram_bearing_insulation;
post_yrail_upper_z = tram_offset_z + motor_shaft_length + tram_height - bearing_outer_diameter/2 - tram_bearing_insulation;

linear_rail_insulation = 8;
linear_rail_hole_depth = 10;

post_linear_xrail_z = 8;

module motor_post() {
    post_width = linear_rail_insulation*2;
    
    difference() {
        union() {
            cube([post_width, post_length, post_height]);
            cube([post_base_width, post_length, post_base_height]);
        }
    
        // Lower Rail Indent
        translate([linear_rail_insulation, linear_rail_hole_depth, post_yrail_lower_z])
            rotate([-90,0,180])
                rail();
        
        // Upper Rail Indent
        translate([linear_rail_insulation, linear_rail_hole_depth, post_yrail_upper_z])
            rotate([-90,0,180])
                rail();
        
        // Center Rail Indent
        translate([linear_rail_hole_depth, post_width/2, post_linear_xrail_z])
            rotate([90,0,-90])
                rail();
        
        // Motor Indent
        translate([post_motor_depth_x+motor_height, post_motor_depth_y+motor_width/2, post_motor_z + motor_width/2])
            rotate([90,0,-90])
                motor_negative();  
    }
}




module motor_tram() {
    difference() {
        cube([tram_width, tram_length, tram_height]);
        
        //Bearing Slots for Lower Rail
        translate([linear_rail_insulation,-0.1,post_yrail_lower_z-tram_z])
            rotate([-90,0,0])
                bearing();
        translate([-1,-1,post_yrail_lower_z-tram_z-1])
            cube([2,bearing_height+1,2]);
        
        translate([linear_rail_insulation,tram_length-bearing_height+0.1,post_yrail_lower_z-tram_z])
            rotate([-90,0,0])
                bearing();
        translate([-1,1+tram_length-bearing_height,post_yrail_lower_z-tram_z-1])
            cube([2,bearing_height+1,2]);
        translate([linear_rail_insulation,-0.1,post_yrail_lower_z-tram_z])
            rotate([-90,0,0])
                cylinder(d=(bearing_outer_diameter+linear_rail_diameter)/2, h=tram_length);
        
        //Bearing Slots for Lower Rail
        translate([linear_rail_insulation,-0.1,post_yrail_upper_z-tram_z])
            rotate([-90,0,0])
                bearing();
        translate([-1,-1,post_yrail_upper_z-tram_z-1])
            cube([2,bearing_height+1,2]);
            
        translate([linear_rail_insulation,tram_length-bearing_height+0.1,post_yrail_upper_z-tram_z])
            rotate([-90,0,0])
                bearing();
        translate([-1,1+tram_length-bearing_height,post_yrail_upper_z-tram_z-1])
            cube([2,bearing_height+1,2]);
        
        translate([linear_rail_insulation,-0.1,post_yrail_upper_z-tram_z])
            rotate([-90,0,0])
                cylinder(d=(bearing_outer_diameter+linear_rail_diameter)/2, h=tram_length);
        
        // Motor Indent
        translate([bearing_outer_diameter+tram_bearing_insulation+motor_width/2,tram_length/2,motor_height+post_motor_depth_x])
            rotate([180,0,0])
                motor_negative();
            
        translate([motor_width+19,tram_length/2-3,motor_height-tram_bearing_insulation])
            cube([7,6,8]);
    }
}

translate([0, -20-tram_length, tram_z]) {
    motor_tram();
    
    // Motor
    translate([motor_width/2+20,tram_length/2,motor_height+post_motor_depth_x])
        rotate([180,0,0])
            motor();
    
    //Bearings
    color([1/3,1/3,1/3]) {
        translate([linear_rail_insulation,-0.1,post_yrail_lower_z-tram_z])
            rotate([-90,0,0])
                bearing();
        translate([linear_rail_insulation,tram_length-bearing_height+0.1,post_yrail_lower_z-tram_z])
            rotate([-90,0,0])
                bearing();
        translate([linear_rail_insulation,-0.1,post_yrail_upper_z-tram_z])
            rotate([-90,0,0])
                bearing();
        translate([linear_rail_insulation,tram_length-bearing_height+0.1,post_yrail_upper_z-tram_z])
            rotate([-90,0,0])
                bearing();
    }
}

motor_post();

translate([post_motor_depth_x+motor_height, post_motor_depth_y+motor_width/2, post_motor_z + motor_width/2])
    rotate([90,0,-90])
        motor();  

// Lower Rail
translate([linear_rail_insulation, linear_rail_hole_depth, post_yrail_lower_z])
    rotate([-90,0,180])
        rail();

// Upper Rail
translate([linear_rail_insulation, linear_rail_hole_depth, post_yrail_upper_z])
    rotate([-90,0,180])
        rail();
