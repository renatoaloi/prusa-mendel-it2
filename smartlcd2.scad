//////////////////////////////////////////////////////////////////////////////////////
///
///  Double Hinged Frame for Smart LCD 2004 Controller
///
///  This file constructs a double hinged frame for the Smart LCD Controller for mounting
///  on a box-frame Prusa i3 3D printer.  The hinge mechanism allows the controller
///  to be stowed away behind the frame when it's not being used.
///  
///  The project consists of the LCD frame as such and a strong double hinge mechanism.
///  Both frame and hinge mechanism can also be used independently, i.e. if the
///  Smart LCD Controller is to be mounted in a fixed position, the hinge is not
///  needed, and the hinge mechanism alone could well also be useful for flexible
///  mounting devices other than that particular controller.
///
///  The Smart LCD Controller is inserted into frame part and fastened on it by
///  means of four M3x10 screws.  
///
///  The hinge axes are M4 screws which are tightened with a spring and a Nyloc nut,
///  as to allow rotation while maintaining enough pressure to keep the frame solidly
///  in place.  The printer-side hinge also has a locking mechanism to restrict the
///  rotation between 0 and 90 degrees.  Also grooves at 0 and 90 degrees cause
///  the hinge to snap precisely into place at the two end positions.
///
///  The provided SCAD file is fully parametrized, so that it can be easily modified
///  to particular needs, if necessary.  Separate STL files are provided for the frame
///  and the hinge parts.
///
//////////////////////////////////////////////////////////////////////////////////////
///
///  2014-12-03 Heinz Spiess, Switzerland
///
///  released under Creative Commons - Attribution - Share Alike licence (CC BY-SA)
//////////////////////////////////////////////////////////////////////////////////////

eh=0.25;  // extrusion layer height
ew=0.55;  // extrusion width

// build a cube with chamfered edges
module chamfered_cube(size,d=1){
   hull(){
     translate([d,d,0])cube(size-2*[d,d,0]);
     translate([0,d,d])cube(size-2*[0,d,d]);
     translate([d,0,d])cube(size-2*[d,0,d]);
   }
}


// build a cylinder with chamfered edges
module chamfered_cylinder(r=0,r1=0,r2=0,h=0,d=1){
   hull(){
      translate([0,0,d])cylinder(r1=(r?r:r1),r2=(r>0?r:r2),h=h-2*d);
      cylinder(r1=(r?r:r1)-d,r2=(r>0?r:r2)-d,h=h);
   }
}

//////////////////////////////////////////////////////////////////////
// build an arbitrary object from a list of blocks and cavities
//////////////////////////////////////////////////////////////////////
module object(blocks,cavities,eps=[0,0,0]){
   difference(){
      union()for(i=[0:len(blocks)-1])assign(b=blocks[i])
         translate(b[0])
	    if(b[1][0]>0)
	       if(len(b[1])>3)
	          chamfered_cube([b[1][0],b[1][1],b[1][2]],b[1][3]);
	       else
	          cube(b[1]);
	    else
	       rotate(90*[b[1][0]==-1?1:0,b[1][0]==-2?1:0,0])
	       cylinder(r=b[1][1],h=b[1][2],$fn=(len(b)>2?b[2]:0));
      for(i=[0:len(cavities)-1])assign(c=cavities[i])
         translate(c[0])
	    if(c[1][0]>0)
	       translate([-eps])cube(c[1]+2*eps);
	    else
	       rotate(90*[c[1][0]==-1?1:0,c[1][0]==-2?1:0,0])
	       cylinder(r=c[1][1],h=c[1][2],$fn=(len(c)>2?c[2]:0));
   }
}


//////////////////////////////////////////////////////////////////////
// Frame for Smart 2004 LCD Controller 
//////////////////////////////////////////////////////////////////////
module smartlcd(
w=4,              // wall thickness
s=[4,7.2,5],      // screw [screw diameter,nut size, nut height]
eps=[0.1,0.1,0] // gap for cavities
){
  dist_conns = 113.2+25;
  blocks=[
      [[-w,-w,0],[151+2*w,63.5+2*w,16,1]],
      [[134,-19,0],[16,16,16]],  
    [[0,-19,0],[16,16,16]],
    //[[113.2,10,-10],[26,10,10]],
    // just one outer block
    
  ];
   cavities=[
      [[14,9,-2],[99,42,19]],    // LCD cutout
      [[14,-0.25,4],[98.5,60.5,9+10]],  // LCD PCB
      [[0,7.75,8],[151,56,5+14]],    // Main PCB
      [[dist_conns,33,-2],[0,8/2,20]],     // Switch axis
      [[dist_conns,7+39+13.5/2,-2],[0,13.5/2,19]],     // buzzer
      [[dist_conns-5,11,1], [10, 10, 20]],
      [[dist_conns,16,-2],[0,3,20]],      // reset switch
      [[116,8,2],[29,55.5,10]],     // buzzer/switch/reset
      [[118,18,2],[33,35.5,10]],    // buzzer/switch/reset
      [[0,18,2],[11,35.5,10]],    // buzzer/switch/reset
      [[-w-1,17,9],[w+2,27,10]],    // SD slot
    
    [[-1,-13,8],[-2,4.1,200], 16],
    
    
      //[[-w-1,s[0]/2,8],[-2,s[0]/2,151+2*w+2],7], // hinge hole
      //[[w,s[0]/2,8],[-2,s[1]/2/cos(30),s[2]],6], // hinge nut trap
      //[[w,s[0]/2,12],[-2,s[1]/2/cos(30),s[2]],6], // hinge nut trap
      //[[w,s[0]/2,16],[-2,s[1]/2/cos(30),s[2]],6], // hinge nut trap
      //[[151-w-s[2],s[0]/2,8],[-2,s[1]/2/cos(30),s[2]],6], // hinge nut trap
      //[[151-w-s[2],s[0]/2,12],[-2,s[1]/2/cos(30),s[2]],6], // hinge nut trap
      //[[151-w-s[2],s[0]/2,16],[-2,s[1]/2/cos(30),s[2]],6], // hinge nut trap
      [[0+2.9,8+2.5,3],[0,2.5/2,6],6],    // Screw hole for PCB
      [[151-2.7,8+2.5,3],[0,2.5/2,6],6],  // Screw hole for PCB
      [[0+2.9,8+55.5-2.5,3],[0,2.5/2,6],6],    // Screw hole for PCB
      [[151-2.7,8+55.5-2.5,3],[0,2.5/2,6],6],    // Screw hole for PCB
      [[14.5+8,60-5,2],[42,8.5,9]],              // LCD pin header
      [[50,-w/2,2],[2,55.5+8+w,11]],              // Anti-Warping
      [[90,-w/2,2],[2,55.5+8+w,11]],              // Anti-Warping
  ];

    
  scale([1,-1, 1])object(blocks,cavities,eps);
}

//////////////////////////////////////////////////////////////////////
// Frame hinge for Smart 2004 LCD Controller 
//////////////////////////////////////////////////////////////////////

module hinge(
fix=false,          // construct fixed part of hinge
move=false,         // construct moving part of hinge
draw=false,         // put movable part at end position for drawing (not for printing!)
off=[36,32],        // center offset in X/Y direction
l=25,               // length of LCD hinge
s=[4,7,5,8,5],      // LCD mounting screw [screw diameter,nut diameter,nut height,spring diameter, spring length]
h=16,               // hight 
w=8,                // wall thickness
m3r=3.5/2,          // screw radius for mounting frame hinge
eps=0               // gap between fitting fixed and moving part
){

//  moving part
if(move){
   // drawing or printing position?
   translate([0,0,w])rotate([draw?180:0,0,0])translate([0,0,-w])

   difference(){
      union(){
         hull(){
	    // construct basic form of moving part
	    chamfered_cylinder(r=off[1]-h+eps,h=w);
            translate([-off[0]-eps,-off[1]+h-2+eps,0])chamfered_cube([off[0]+3,4,w]);
	 }
	 // lock for 90 degrees max angle
	 rotate(-45)intersection(){
	    chamfered_cylinder(r=off[1]-h+5+eps,h=w);
	    cube([off[1]+6,off[1]+6,w]);
	 }
	 // smooth out locking part at negative end
	 rotate(45)translate([0,-7,0])chamfered_cylinder(r=off[1]-h-2,h=w);
	 // block for LCD-side hinge
         translate([-off[0],-off[1],0])chamfered_cube([l,h,h]);
      }
      // hole for LCD mounting spring
      translate([-off[0],-off[1]+h/2,h/2])rotate([0,90,0])
         translate([0,0,l-s[4]])rotate(30)cylinder(r=s[3]/2/cos(30),h=s[4]+1,$fn=6);
      // hole for LCD mounting screw 
      translate([-off[0]-1,-off[1]+h/2,h/2])rotate([0,90,0])
         rotate(30)cylinder(r=s[0]/2,h=l+2,$fn=6);
      // clip grooves at 0 and 90 degrees
      for(a=[0,90])rotate(a)translate([-off[0],0,w+1])rotate([0,90,0])cylinder(r=2,h=2*off[0],$fn=6);
      // hole for frame side pivot screw
      translate([0,0,w/2+eh])cylinder(r=s[0]/2,h=w+2);
      // hole for frame side pivot spring
      translate([0,0,-1])cylinder(r=s[3]/cos(30)/2,h=1+w/2,$fn=6);
   }

}

// fixed part for mounting on printer frame
if(fix){
   difference(){
      // main body of fixed part is a
      // rectangular block with rounded corners
      hull()
         translate([-off[1]+h/2+off[0],-off[1]/2+h/2,0])
            for(sx=[-1,1])for(sy=[-1,1])
               translate([sx*(off[0]-h/2-s[1]),sy*(off[1]-h/2-s[1]),0])
	          chamfered_cylinder(r=s[1],h=h-w+3);

      // hole for pivoting screw
      translate([0,0,s[2]+eh])cylinder(r=s[0]/2,h=h,$fn=12);
      // nut cavity for pivot screw
      translate([0,0,-1])cylinder(r=s[1]/cos(30)/2,h=1+s[2],$fn=6);
      // subract moving part in 0 and 90 degrees position and with adequate gap
      for(a=[0,90])rotate(a)hinge(move=true,draw=true,eps=0.3);

      // holes for the 4 frame mounting screws
      translate([-off[1]+h/2+off[0],-off[1]/2+h/2,0])
         for(sx=[-1,1])for(sy=[-1,1])
            translate([sx*(off[0]-h/2-s[1]),sy*(off[1]-h/2-s[1]),-1]){
	       cylinder(r=m3r,h=h+2);
	       translate([0,0,4+0.01])cylinder(r1=m3r,r2=2*m3r,h=2*m3r);
	       translate([0,0,4+2*m3r])cylinder(r=2*m3r,h=h);
	    }
      }
   }

}

// draw the LCD frame and the hinge in operating position with give
// rotation angles for both hinges
module drawAll(a1=90,a2=30){
   hinge(fix=true);
   rotate(a1){
      color("green")for(a=[0])rotate(a)hinge(move=true,draw=true);
      translate([-40,30,0])rotate([0,0,180])translate(-[8,-7,-8])
         rotate([a2,0,0])
           translate([8,2,-8]) color("red")smartlcd();
   }
}

//  Automatic generation of STL files by Makefile
module Frame_SmartLCD2004(){  // AUTO_MAKE_STL
   smartlcd();
}

module Hinge_SmartLCD2004_Right(){  // AUTO_MAKE_STL
   translate([80,0,0])hinge(move=true);
   hinge(fix=true);
}

module Hinge_SmartLCD2004_Left(){  // AUTO_MAKE_STL
   scale([1,-1,1]){
     translate([80,0,0])hinge(move=true);
     hinge(fix=true);
   }
}

//////////////////////////////////////////////////////////////////////////////////////
// For interactive use of OpenScad uncomment and modify the following lines as needed:
//////////////////////////////////////////////////////////////////////////////////////

smartlcd();

//drawAll(a1=90,a2=-90);
//drawAll(a1=0,a2=-45);
//translate([80,0,0])hinge(move=true);
//hinge(fix=true);
//color("green")for(a=[0])rotate(a)hinge(move=true,draw=true);

// tf=200;drawAll(a1=max(0,90-$t*tf),a2=-90+(($t*tf)>90?$t*tf-90:0)); // animation!!!
