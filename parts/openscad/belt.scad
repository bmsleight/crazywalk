$fn = 48;
use <./bearing.scad>;
timber_construct_h = 63;


module belt_connect_assembley_premove(slat_w=90, slat_t=12)
{
    rotate([90,0,0]) 
    {
        belt_connect(slat_w=slat_w, slat_t=slat_t);
        rotate([180,0,0]) translate([0,0,3]) 
        {
            bearing_shell();
            base_holder();
            ball_bearing();
        }
    }
}

module belt_connect_assembley(slat_w=90, slat_t=12, move=0)
{
    if(move==0)
    {
        belt_connect_assembley_premove(slat_w=slat_w, slat_t=slat_t);
    }
    else
    {
        translate([slat_w/2+7.5,0,0]) belt_connect_assembley_premove(slat_w=slat_w, slat_t=slat_t);
    }
}


module belt_assembley()
{
    color("blue") translate([0,(600-100)/2,0]) belt_connect_assembley(slat_w=90, slat_t=12);
    color("blue") translate([0,(600-100)/2,0]) belt_connect_assembley(slat_w=90, slat_t=12);
    
    cube([90,600-100,12],center=true);
    
    color("blue") mirror([0,1,0]) translate([0,(600-100)/2,0]) belt_connect_assembley(slat_w=90, slat_t=12);
}

belt_assembley();

*translate([104,0,0]) belt_assembley();


!belt_connect_assembley(move=1);
