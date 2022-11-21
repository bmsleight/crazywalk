block_w=63;
block_d=38;
block_h=25;

holes_d = 3.5;
counter_sunk = 8;
jig_wall = 5;
text_depth=0.3;

$fn=60;



module block_holes(text1="1", text2="2")
{
        translate([block_w/3,block_d/3,block_h/2]) cylinder(h=block_h*2, d=holes_d, center=true);
        translate([block_w/3,block_d/3,counter_sunk/2]) cylinder(h=counter_sunk*1.001, d1=counter_sunk, d2=0, center=true);    
    translate([block_w/3+block_w/6,block_d/3,0+text_depth]) rotate([0,180,270])linear_extrude(block_h) text(text1, font = "Liberation Sans", halign = "center", valign = "center", size = block_w/6);


        translate([2*block_w/3,2*block_d/3,block_h/2]) cylinder(h=block_h*2, d=holes_d, center=true); 
    translate([2*block_w/3,2*block_d/3,counter_sunk/2]) cylinder(h=counter_sunk*1.001, d1=counter_sunk, d2=0, center=true);    
    translate([2*block_w/3+block_w/6,2*block_d/3,0+text_depth]) rotate([0,180,270])linear_extrude(block_h) text(text2, font = "Liberation Sans", halign = "center", valign = "center", size = block_w/6);
}


module block()
{
    difference()
    {
        cube([block_w,block_d,block_h], center=false);
    }
}


module side_jig()
{
    difference()
    {
        union()
        {
            translate([block_d,0,0]) rotate([0,0,90]) block();
            translate([block_d,0,0]) block();
            translate([block_d,block_w-block_d,0]) block();
        }
        union()
        {
            translate([block_d,0,0]) rotate([0,0,90]) block_holes("1","2");
            translate([block_d,0,0]) block_holes("3","4");
            translate([block_d,block_w-block_d,0]) block_holes("5","6");
        }
    }
}

module framed_jig()
{
    side_jig();
    difference()
    {
        translate([-jig_wall,-jig_wall,0])
            cube([block_w+block_d+jig_wall,block_w+jig_wall*2,block_h+jig_wall], center=false);
            translate([0,0,-block_h]) cube([block_w+block_d+jig_wall,block_w,block_h*3+jig_wall], center=false);
   
    }
}

*side_jig();
framed_jig();