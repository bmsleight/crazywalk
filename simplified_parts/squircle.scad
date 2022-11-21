/* An OpenSCAD squircle

Copyright (C) 2022 by Brendan M. Sleight
Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted. 

https://en.wikipedia.org/wiki/Squircle

A squircle is a shape intermediate between a square and a circle.
A superellipse, where x^4 + y^4 = 1.

example:-
squircle([40,30,10], r=10, center=false);
   r and center is optional 
 
*/
function half_squircle_y_positive(steps) = [for (x = [-1 : 1/steps : 1]) [x, pow(abs(1-pow(x,4)),1/4)] ];
function half_squircle_y_negative(steps) = [for (x = [-1 : 1/steps : 1]) [x, -pow(abs(1-pow(x,4)),1/4)] ];
// Need to make sure 2r>X or Y 
function adjusted_r(r=0, size) = (r==0) ? min(size[0],size[1])/2 : min(size[0],size[1],2*r)/2 ;

module squircle_base(r = 1, sides = 60*4)
{
    resize([r*2, 0, 0], auto=true)
        // Risize squircle with Radius=1, hence z=2 
        linear_extrude(2 , center = true) 
            hull()
            {
                polygon(half_squircle_y_positive(sides/2));
                polygon(half_squircle_y_negative(sides/2));
            }
}

module squircle_corners(x=5, y=5, z=5, r=1, sides = 60*4)
{
    resize([0,0,z]) hull()
    {
        translate([+x/2-r,+y/2-r,0])squircle_base(r=r, sides=sides);
        translate([+x/2-r,-y/2+r,0])squircle_base(r=r, sides=sides);
        translate([-x/2+r,+y/2-r,0])squircle_base(r=r, sides=sides);
        translate([-x/2+r,-y/2+r,0])squircle_base(r=r, sides=sides);
    }
}

module squircle(size, r=0, sides = 60*4, center=true)
{
    
    if(center)
    {
        translate([0,0,0]) squircle_corners(x=size[0], y=size[1], z=size[2], r=adjusted_r(r,size), sides=sides);
    }
    else
    {
        translate([size[0]/2,size[1]/2,size[2]/2]) squircle_corners(x=size[0], y=size[1], z=size[2], r=adjusted_r(r,size), sides=sides);
    }
}

squircle([40,30,10], r=10, center=true);