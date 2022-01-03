
$fn=64;
md = 42.3;
w=4;
f=1.5;
shaft=12;

difference() {
    
    cube([md, md, w]);
    
    translate([md/2-15.5, md/2-15.5, -3])
    cylinder(r=f, h=10);

    translate([md/2+15.5, md/2-15.5, -3])
    cylinder(r=f, h=10);

    translate([md/2+15.5, md/2+15.5, -3])
    cylinder(r=f, h=10);

    translate([md/2-15.5, md/2+15.5, -3])
    cylinder(r=f, h=10);
    
    // furo do shaft
    translate([md/2, md/2, -3])
    cylinder(r=shaft, h=10);


}

translate([0, md, 0])
cube([30, w, w]);

translate([0, md+w, w-50])
cube([30, w, 50]);

translate([30, md+w, w-50])
rotate([-90,180,0])
hook();

//translate([md/2-15, -39, 0])
//cube([30, 40, w]);

module hook() {
    difference() {
        cube([30, w, 25]);

        rotate([90,0,0])
        translate([30/2, md/2+3, -7])
        cylinder(r=4, h=10);
        rotate([90,0,0])
        translate([30/2, md/2+2, -7])
        cylinder(r=4, h=10);
        rotate([90,0,0])
        translate([30/2, md/2+1, -7])
        cylinder(r=4, h=10);
        rotate([90,0,0])
        translate([30/2, md/2, -7])
        cylinder(r=4, h=10);
        rotate([90,0,0])
        translate([30/2, md/2-1, -7])
        cylinder(r=4, h=10);
        rotate([90,0,0])
        translate([30/2, md/2-2, -7])
        cylinder(r=4, h=10);
        rotate([90,0,0])
        translate([30/2, md/2-3, -7])
        cylinder(r=4, h=10);
        rotate([90,0,0])
        translate([30/2, md/2-4, -7])
        cylinder(r=4, h=10);
        rotate([90,0,0])
        translate([30/2, md/2-5, -7])
        cylinder(r=4, h=10);
        rotate([90,0,0])
        translate([30/2, md/2-6, -7])
        cylinder(r=4, h=10);
        rotate([90,0,0])
        translate([30/2, md/2-7, -7])
        cylinder(r=4, h=10);
        rotate([90,0,0])
        translate([30/2, md/2-8, -7])
        cylinder(r=4, h=10);
    }
}