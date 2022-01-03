$fn=60;

inner_radius = 12;
slack = 1;
i = (inner_radius + slack) / 2;

outer_radius = 16;
o = outer_radius / 2;

// h = 4.8; // Prusa 
hight = 6;
h = hight - 0.3;


centerdistance = 50;
cd = centerdistance;

s = 1;

module head()
{
	cylinder(h,i,i);
	translate([0,0,h])  cylinder(5,o,o);
	translate([0,0,-h]) cylinder(h,o,o);
}

module block()
{
	hull()
	{
		translate([0,0,h/2])	 		cube([40,25,h],true);
		translate([0,0,-2])   		cube([40,25,4],true);

		translate([10+cd/2,0,-4]) 	cylinder(h+4,4,4);
		translate([-10-cd/2,0,-4]) 	cylinder(h+4,4,4);
	}
}

module plate()
{
	difference()
	{
		block();
		head();

		hull()
		{
			translate([ cd/2,0,-10]) cylinder(30,1.8,1.8);
			translate([ 8+cd/2,0,-10]) cylinder(30,1.8,1.8);
		}

		hull()
		{
			translate([-cd/2,0,-10]) cylinder(30,1.8,1.8);
			translate([-8-cd/2,0,-10]) cylinder(30,1.8,1.8);
		}

		translate([ 12,25,s]) rotate([90,0,0]) cylinder(50,1.8,1.8);
		translate([-12,25,s]) rotate([90,0,0]) cylinder(50,1.8,1.8);
		
		sinks();
	}
}

module sinks()
{
	translate([-12,14,s]) rotate([90,0,0]) cylinder(4,5.4/2, 5.4/2);
	translate([ 12,14,s]) rotate([90,0,0]) cylinder(4,5.4/2, 5.4/2);

	translate([-12,-9,s]) rotate([90,0,0]) cylinder(4,5.9/2, 5.3/2, $fn=6);
	translate([ 12,-9,s]) rotate([90,0,0]) cylinder(4,5.9/2, 6.3/2, $fn=6);
}


module cl() 
{ 
	translate([-15,0,0]) rotate([0,0,0]) cut(); 
}

module dr() 
{ 
	mirror([1,0,0]) mirror([0,1,0]) translate([-15,0,0]) rotate([0,00,0]) cut(); 
}

module oneplate()
{
	difference()
	{
		plate();
		cl();
	
		translate([-15,0,-10]) cube([70,30,20]);
		translate([17,-15,-10]) cube([30,30,20]);		
	}

	intersection()
	{
		plate();
		dr();
	}

}

module cut()
{
	translate([0,0,-10])
	difference()
	{
		rotate([0,0,45]) 		  cube([26,26,20]);
		translate([0,0,0])     cube([40,40,20]);
	}
}


rotate([0,180,0])
{
	difference()
	{
		plate();
		oneplate();
	}
}

translate([2,-2,0]) rotate([0,180,0]) oneplate();



















