// Plate for DSLR
// 2024-09-20

scale=25.4;    // Inch to mm
tol=0.25;

//Resolution for STL export only. That is for display in Openscad and 3D printing only. 
//Please do comment this before going to Freecad, or you will end up with inefficient facets.
// and will not play well with export to .step files
$fn=350;

x=10*scale;
y=8*scale;


r_round=10;
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
module dovetail(){
    x1=(3.5/2)*scale;
    y1=(5.5/2)*scale;
    translate([x1,y1]) circle(r1);
    translate([x1,-y1]) circle(r1);
    translate([-x1,y1]) circle(r1);
    translate([-x1,-y1]) circle(r1);
    
    y2=(3/8)*scale;
    translate([x1,y2]) circle(r1);
    translate([x1,-y2]) circle(r1);
    translate([-x1,y2]) circle(r1);
    translate([-x1,-y2]) circle(r1);
    
    x3=(1.5/2)*scale;
    y3=(3.75/2)*scale;
    translate([x3,y3]) circle(r1);
    translate([x3,-y3]) circle(r1);
    translate([-x3,y3]) circle(r1);
    translate([-x3,-y3]) circle(r1);
    
    x4=0;
    y4=(1/2)*scale;
    translate([x4,y4]) circle(r1);
    translate([x4,-y4]) circle(r1);
    
    x5=0;
    y5=(142.5/2);
    translate([x5,y5]) circle(r1);
    translate([x5,-y5]) circle(r1);   
}

module guider(tx,ty){
    r3=2.1;
    translate([tx,ty+7]) circle(r3);
    translate([tx,ty-7]) circle(r3); 
}


module tele(tx,ty,r1){
    translate([tx,ty+14]) circle(r1);
    translate([tx,ty-14]) circle(r1); 
    translate([tx,ty-42]) circle(r1);
    translate([tx,ty-70]) circle(r1); 
    
    translate([tx,ty+14+14]) circle(r1);
    translate([tx,ty-14+14]) circle(r1); 
    translate([tx,ty-42+14]) circle(r1);
    translate([tx,ty-70+14]) circle(r1);
    //translate([tx,ty-98+14]) circle(r1); 
}

module camholder(tx,ty,r1,h){
    union(){
    translate([tx,ty+h/2]) circle(r1);
    translate([tx,ty-h/2]) circle(r1);
    translate([tx-.5*scale,ty+h/2]) circle(r1);
    translate([tx+.5*scale,ty+h/2]) circle(r1);
    translate([tx-.5*scale,ty-h/2]) circle(r1);
    translate([tx+.5*scale,ty-h/2]) circle(r1);
    
    translate([tx,ty]) square(size = [r1*2,h],center=true);
    translate([tx-.5*scale,ty]) square(size = [r1*2,h],center=true);
    translate([tx+.5*scale,ty]) square(size = [r1*2,h],center=true);
        
    }
}


//_____________________________________________________________________________________
//difference(){ //for just doing a subset
linear_extrude(4) {
difference(){
    rounded_square(x,y,r_round);
    dovetail();
    guider(-4.2*scale,0);
    guider(-4.2*scale,-2*scale);
    guider(-4.2*scale,2*scale);
    guider(-3.0*scale,0);
    guider(-3.0*scale,-2*scale);
    guider(-3.0*scale,2*scale);
    
    tele(3.8*scale,2.5*scale,r1);
    camholder(3.8*scale,2.5*scale-148,r1,14);
    camholder(3.8*scale,3.5*scale-148,r1,14);
    camholder(3.8*scale,4.5*scale-148,r1,14);   
}
}//linear_extrude
//translate([-60,0,0]) cube(size = [x,y+50,20],center=true);
//}// difference