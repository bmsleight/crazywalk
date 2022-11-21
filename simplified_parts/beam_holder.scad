$fn = 48;
use <./frame_jigs.scad>;

block_w=63;
block_d=38;
block_h=5;

function half_squircle_y_positive(steps) = [for (x = [-1 : 1/steps : 1]) [x, pow(abs(1-pow(x,4)),1/4)] ];
function half_squircle_y_negative(steps) = [for (x = [-1 : 1/steps : 1]) [x, -pow(abs(1-pow(x,4)),1/4)] ];


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

module squircle(x=5, y=5, z=5, r=1)
{
    resize([0,0,z]) hull()
    {
        translate([+x/2-r,+y/2-r,0])squircle_base(r=r);
        translate([+x/2-r,-y/2+r,0])squircle_base(r=r);
        translate([-x/2+r,+y/2-r,0])squircle_base(r=r);
        translate([-x/2+r,-y/2+r,0])squircle_base(r=r);
    }
}

module beam_holder(beam_units=1, mirror=false)
{
    color("Yellow") translate([0,0,0])
    {
        difference() 
        {
            union()
            {
                squircle(x=block_w, y=block_d, z=block_h, r=block_d/4);
                translate([(-block_d-block_w)/2,0,0]) squircle(x=block_d, y=block_d, z=block_h, r=block_d/4);
                // Stand is twice block_d from base
                translate([(block_w/2+block_d*beam_units)/2,(block_d/3-block_d)/2,0]) squircle(x=block_w/2+block_d*beam_units, y=block_d/3, z=block_h, r=block_d/(3*2));
            }
            if(mirror)
            {
                mirror([0,1,0]) translate([-block_w/2, -block_d/2,-block_h/2])  block_holes(text1="", text2="");
            }
            else
            {
                // the holes need to be mirrod on the non mirror shape! 
                //   I blame the designer...
                translate([-block_w/2, -block_d/2,-block_h/2])  block_holes(text1="", text2="");
            }
        mirror([0,0,1]) mirror([0,1,0]) translate([-block_w*1-block_d/2, -block_d/2,-block_h/2])  block_holes(text1="", text2="");
        }
    }
}

module beam_holder_mirror(beam_units=1)
{
    mirror([0,0,1]) beam_holder(beam_units=beam_units, mirror=true);
}

// For reference rotate([180,0,90]) translate([60,-50,0])  framed_jig();

beam_holder_mirror(beam_units=0);
translate([0,-50,0]) rotate([180,0,0]) beam_holder(beam_units=0);

