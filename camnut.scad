// Plate for DSLR
// 2024-09-20

scale=25.4;    // Inch to mm
tol=0.25;

//Resolution for STL export only. That is for display in Openscad and 3D printing only. 
//Please do comment this before going to Freecad, or you will end up with inefficient facets.
// and will not play well with export to .step files
$fn=350;

x=2.1*scale;
y=0.9*scale;
r_round=5;

r1=0.26*scale/2; // 1/4 - 20 screws clearance drill, close fit


//_____________________________________________________________________________________
//makes a rectangle of size x,y with rounded corner of radius r
module rounded_square(x,y,r){
    union(){
    xi=x/2-r;
    yi=y/2-r;

    translate([xi,yi]) circle(r);
    translate([xi,-yi]) circle(r);
    translate([-xi,yi]) circle(r);
    translate([-xi,-yi]) circle(r);

    square(size = [x-2*r,y],center=true);
    square(size = [x,y-2*r],center=true);
    }
}

//_____________________________________________________________________________________
module camholder(tx,ty,r1,h){
    union(){
    translate([tx,0]) circle(r1);
    translate([tx-.5*scale,0]) circle(r1);
    translate([tx+.5*scale,0]) circle(r1);

        
    }
}
//_____________________________________________________________________________________

linear_extrude(4) {
difference(){
    rounded_square(x,y,r_round);
    camholder(0,0,r1,14);   
}
}