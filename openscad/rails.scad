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
bearing_innter_diameter = 8;
module bearing() {
    color([1/2,1/2,1/2])
    difference() {
        cylinder(h = bearing_height, d = bearing_outer_diameter, $fn=25);
        translate([0,0,-1])
            cylinder(h = bearing_height+2, d = bearing_innter_diameter, $fn=25);
    }
}