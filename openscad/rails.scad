// Rail and Bearing

linear_rail_negative_add = 0.2;
linear_rail_diameter = 8;
linear_rail_length = 506;
module rail() {
    color([1/2,1/2,1/2])
        cylinder(d = linear_rail_diameter, h = linear_rail_length, $fn=25);
}

module rail_negative() {
    color([1/2,1/2,1/2])
        cylinder(d = linear_rail_diameter+linear_rail_negative_add, h = linear_rail_length, $fn=25);
}

bearing_height = 24;
bearing_outer_diameter = 15;
bearing_inner_diameter = 8;
module bearing() {
    color([1/2,1/2,1/2])
    difference() {
        cylinder(h = bearing_height, d = bearing_outer_diameter, $fn=25);
        translate([0,0,-1])
            cylinder(h = bearing_height+2, d = bearing_inner_diameter, $fn=25);
    }
}

module bearing_negative() {
    cylinder(h = bearing_height, d = bearing_outer_diameter + linear_rail_negative_add, $fn=50);
    
    ejection_slot_overhang_z = 5;
    ejection_slot_width_x = 5;
    ejection_slot_width_z = bearing_height/4*3;
    translate([0,50,ejection_slot_width_z/2 - ejection_slot_overhang_z])
        cube([ejection_slot_width_x,100,ejection_slot_width_z], center=true);
}

//bearing_negative();