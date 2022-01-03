$fn=25;

hole_left = 2.5;
hole_dia  = 1.5;
screwdriver_dia = 2;

module deflector() {
    difference() {
        // deflector wall
        cube([30,30,1]);

        // holes for screwdriver
        translate([hole_left,4,3])
        rotate(a=225, v=[1,0,0])
        cylinder(r=screwdriver_dia, h=10);

        translate([screwdriver_dia+25,4,3])
        rotate(a=225, v=[1,0,0])
        cylinder(r=screwdriver_dia, h=10);
    }
}

module mount() {
    difference() {

        // wall for mount
        translate([0,0,1])
        rotate(a=-45, v=[1,0,0])
        cube([30,1,8]);

        // holes for fixation
        translate([hole_left,4,3])
            rotate(a=45, v=[1,0,0])
        cylinder(r=hole_dia, h=10);

        translate([hole_left+25,4,3])
            rotate(a=45, v=[1,0,0])
        cylinder(r=hole_dia, h=10);

    }
}

deflector();
mount();



