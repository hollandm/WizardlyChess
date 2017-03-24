electromagnet_diameter = 25; //mm
electromagnet_height = 20; //mm

module electromagnet() {
    color([1/2,1/2,1/2])
        cylinder(h = electromagnet_height, d = electromagnet_diameter, $fn=25);
}