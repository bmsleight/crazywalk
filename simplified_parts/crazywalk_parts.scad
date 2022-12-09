use <squircle.scad>;


timber_construct_w = 38;
timber_construct_h = 63;
overall_width = 650;
overall_length = 1100;
length_top = 900;
bearing_height = 400;
interval_blocks = 24;

$fn=60;
ball_bearing_d = 16.5;
height_ball = 0.5;
ball_bearing_wall = 2;

screw_thread_d= 5 ;
screw_thread_inner_d= 2.5 ;

screw_thread_wall = 3;
screw_head = 8;
screw_max_length = 50;

click_slop=0.5;
ball_slop=0.1;

framing_wall = 3;
slant_thickness = 18;

angle_of_support = 45;
angle_of_top = 45+15;

screw_outer=screw_thread_d+screw_thread_wall*2;
screw_outer_translate=(ball_bearing_d+screw_outer)/2+ball_bearing_wall;


// http://www.ambrsoft.com/TrigoCalc/Sphere/Cap/SphereCap.htm
// h=R(1-cosTheta)
// r=RsinTheta
height_base=(ball_bearing_d/2)*(1-cos(angle_of_support));
radius_base=(ball_bearing_d/2)*(sin(angle_of_support));
base_holder_width=(screw_outer_translate+screw_outer/2)*2;

screw_mount_h = height_base+height_ball;
max_height_of_screw_mount_before_split = 30;
inner_turn_r = 160 -screw_mount_h;

cylinder_d = ball_bearing_d+ball_bearing_wall*2;

//https://www.desmos.com/calculator/mxntsqwvh3
zfromx = function (x) (x-900*0.33)*(x-900*0.33)/3100;


module ball_bearing() 
{
    translate([0,0, height_ball + ball_bearing_d/2])
        color(alpha = 0.95, c = "Blue") 
            sphere(d = ball_bearing_d);
}

module tube(d1, d2, h)
{
    difference() 
    {
        cylinder(d=d1, h=h);
        cylinder(d=d2, h=h*4, center=true);
    }
}

module screw_outer_position(mirror=false)
{
    if(!mirror)
        translate([screw_outer_translate,0, 0])
                children(); 
    if(mirror)
        mirror([1,0,0]) translate([screw_outer_translate,0, 0])
                children(); 
}

module screw_hole(countersunk=true, shell_hole=false)
{
    screw_outer_position()
    {
        if(countersunk)
        {
            translate([0,0,screw_mount_h]) cylinder(
                        d2 =(screw_thread_d+screw_thread_wall/2)/2,
                        d1 = 0,
                        h=(screw_mount_h)*2, center=true
                        );
        }
        if(shell_hole)
        {
            cylinder(
                        d =screw_thread_d+screw_thread_wall/2+click_slop,
                        h=height_base*8, center=true
                        );
        }
    }
    
}

module screw_hole_pair(countersunk=true, ball_hole=true, shell_hole=false)
{
    screw_hole(countersunk=countersunk, shell_hole=shell_hole);
    mirror([1,0,0]) screw_hole(countersunk=countersunk, shell_hole=shell_hole);
 
    if(ball_hole)
    {
        cylinder(d=ball_bearing_d+ball_slop,
                    h=(screw_mount_h)*4,
                    center=true
                    );
    }
}


module screw_mount(countersunk=true, ball_hole=true, shell_hole=false, nibs=false)
{
    difference()
    {
        union()
        {
            hull()
            {
               screw_outer_position() 
                    cylinder(d=screw_outer,
                            h=screw_mount_h
                            );
                screw_outer_position(mirror=true) 
                    cylinder(d=screw_outer,
                            h=screw_mount_h
                            );
            }
            if(nibs) 
            {
               screw_outer_position() 
                    cylinder(
                        d=screw_thread_d+screw_thread_wall/2,
                        h=height_base*1.5+height_ball
                        );
               screw_outer_position(mirror=true) 
                    cylinder(
                        d=screw_thread_d+screw_thread_wall/2,
                        h=height_base*1.5+height_ball
                        );
            }
        }
        screw_hole_pair(countersunk=countersunk, ball_hole=ball_hole,
                        shell_hole=shell_hole);
    }
}

module bearing_shell()
{
    screw_outer = ball_bearing_d + ball_bearing_wall*2;
    translate([0,0, height_ball + ball_bearing_d/2]) difference()
    {
        sphere(d = screw_outer);    
        sphere(d = ball_bearing_d+ball_slop);
        translate([0,0,-screw_outer/2]) cube(screw_outer, center=true);
        translate([0,0,screw_outer-ball_bearing_wall-height_base*1.5]) cube(screw_outer, center=true);        
    }
    translate([0,0, height_ball + height_base]) 
    {
        tube(screw_outer, ball_bearing_d+ball_slop, ball_bearing_d/2-height_base); 
        screw_mount(countersunk=false, shell_hole=true);
    }
}

module base_holder(){
    tube(cylinder_d, radius_base*2, screw_mount_h);
   screw_mount(nibs=true);
}

module base_holder_shadow(height=screw_mount_h){
    cylinder(d=cylinder_d, h=height);
    // rounding error
   resize([0,0,height]) screw_mount(countersunk=false, 
                        shell_hole=false, ball_hole=false);
}


module base_holder_height(height, continous=false){
    if(height<=screw_mount_h)
    {
        base_holder();
    }
    if((height>screw_mount_h && height<screw_max_length) || continous)
    {
        base_holder_shadow(height=height-(screw_mount_h));
        translate([0,0,height-(screw_mount_h)]) base_holder();
    }
    if((height>screw_mount_h && height>=screw_max_length) )
    {
        // Too long for screw threas
        base_holder();
        // central cylinder
        cylinder(d=cylinder_d, h=height-(screw_mount_h));
        translate([0,0,height-(screw_mount_h)]) 
        {
            base_holder();
            base_holder_width=(screw_outer_translate+screw_outer/2)*2;
            base_holder_width_hyp=sqrt((base_holder_width*base_holder_width)*2)/2;
            // arm to supprt printing
            difference()
            {
                union() intersection()
                {
                    rotate([0,45,0]) cube([base_holder_width_hyp, screw_outer,base_holder_width_hyp], center=true);
                    rotate([180,0,0])  base_holder_shadow(height=base_holder_width_hyp);
                }
                translate([0,0,base_holder_width_hyp]) cube([base_holder_width_hyp*2, screw_outer*2,base_holder_width_hyp*2], center=true);
            }


        }
    }
}


module support_base_array(interval=interval_blocks, text="b", heights=[0,0,0,0,0])
{
    for(i = [0:len(heights)-1])
    {
        // Shift to whole cylinder is on timber 
        //  but not whole base holder as it would be 
        //  too close for end baring 
        translate([-cylinder_d/2,cylinder_d/2+interval*i,0]) base_holder_height(heights[i]);
        
    }
    for(i = [0:len(heights)-2])
    {
        if(heights[i+1]>heights[i])
        {
            translate([-framing_wall,i*interval+interval/2,0]) 
                    cube([framing_wall,interval,heights[i]-(screw_mount_h)]);
        }
        else
        {
            translate([-framing_wall,i*interval+interval/2,0]) 
                    cube([framing_wall,interval,heights[i+1]-(screw_mount_h)]);            
        }
    }
    translate([-timber_construct_h/2,(interval*len(heights))/2,screw_mount_h/2])
    { 
        difference()
        {
            squircle([timber_construct_h,interval*len(heights),screw_mount_h], r=cylinder_d/2);
            squircle([timber_construct_h-screw_mount_h*2,interval*len(heights)-screw_mount_h*2,screw_mount_h*4],r=cylinder_d/2);
        }
        difference()
        {
            union()
            {
                cube([screw_mount_h,interval*len(heights),screw_mount_h], center=true);
                translate([-timber_construct_h/6,-3*interval/2,-screw_mount_h/2]) 
                {
                    cylinder(h=screw_mount_h, d=screw_thread_d+screw_thread_wall);
                }
                translate([0,-3*interval/2,-screw_mount_h/2]) 
                {
                    translate([-timber_construct_h/2,-screw_mount_h/2,0]) cube([timber_construct_h/2, screw_mount_h, screw_mount_h]);
                }
                translate([-timber_construct_h/6,3*interval/2,-screw_mount_h/2]) 
                {
                    cylinder(h=screw_mount_h, d=screw_thread_d+screw_thread_wall);
                }
                translate([0,3*interval/2,-screw_mount_h/2]) 
                {
                    translate([-timber_construct_h/2,-screw_mount_h/2,0]) cube([timber_construct_h/2, screw_mount_h, screw_mount_h]);
                }
            }
            translate([-timber_construct_h/6,-3*interval/2,-screw_mount_h/2]) cylinder(h=screw_mount_h*4, d=screw_thread_inner_d, center=true);
            translate([-timber_construct_h/6,3*interval/2,-screw_mount_h/2]) cylinder(h=screw_mount_h*4, d=screw_thread_inner_d, center=true);
        }
    }
}



module support_base_section(start_x=0, interval=interval_blocks, text="1A", blocks=5, heights=true)
{
    if(heights)
    {
        heights = [ for (i = [0 : blocks-1]) zfromx(start_x+(i*interval))+screw_mount_h ];
        echo(heights); // ECHO: [0, 2, 4, 6, 8, 10]
        support_base_array(interval=interval, text=text, heights=heights);
    }
    else    
    {
        heights = [ for (i = [0 : blocks-1]) 0 ];
        echo(heights); // ECHO: [0, 2, 4, 6, 8, 10]
        support_base_array(interval=interval, text=text, heights=heights);        
    }
        
}

module support_base(interval=interval_blocks, blocks=8, length_top=length_top, offset=1, piece=0, heights=true)
{
    base_y_section = interval*blocks;
    echo(base_y_section);
    translate([0,0,0]) rotate([0,0,-90])
    {
        // need to be less than lenght_top - hence -base_y_section
        for (start_x = [interval*offset: base_y_section: length_top-base_y_section]) 
        {
            if(piece == 0 || ((start_x-interval*offset)/base_y_section)+1 == piece)
            {
                translate([0, start_x,0]) support_base_section(start_x=start_x, interval=interval, blocks=blocks, heights=heights);
            }
        }
    }
}


module turn_support_outer(turn_r=inner_turn_r, interval=interval_blocks, z=0, short_support=true)
{
    
    translate([cylinder_d/2,-interval,-turn_r+zfromx(z)]) rotate([-45,0,0]) difference()
    {
        union()
        {
            for(a = [-45+90/16:90/8:45])
            {
                rotate([a,0,0]) 
                {
                    base_holder_height(height=turn_r, continous=true);
                }
            }
            // circle to link all above rotations
            rotate([0,90,0]) cylinder(h=base_holder_width, r=turn_r-ball_bearing_wall, center=true);
            // Support to timber
            if(short_support) 
            {
                rotate([-45,0,0]) translate([-cylinder_d/2,-turn_r+zfromx(z)-framing_wall,0]) cube([timber_construct_h, framing_wall,interval]);
                rotate([-45,0,0]) translate([-cylinder_d/2,-(turn_r-zfromx(z)+framing_wall),interval]) cube([timber_construct_h, +turn_r-zfromx(z)+framing_wall,framing_wall]); 
            }
            else 
            {
                rotate([-45,0,0]) translate([-cylinder_d/2,-(turn_r-zfromx(z)+framing_wall),interval-timber_construct_w]) cube([timber_construct_h, +turn_r-zfromx(z)+framing_wall,framing_wall+timber_construct_w]); 
                rotate([-45,0,0]) translate([-cylinder_d/2,-(turn_r-zfromx(z)+framing_wall),interval]) cube([timber_construct_h+timber_construct_w, +turn_r-zfromx(z)+framing_wall,framing_wall]); 
            }
        }
        rotate([45,0,0]) translate([0,0,-turn_r]) cube(turn_r*2,center=true);
        rotate([-45,0,0]) 
        {
            translate([0,0,-turn_r]) cube(turn_r*2,center=true);
            if(short_support) translate([-base_holder_width,-1*(turn_r-zfromx(z)), -interval]) cube([base_holder_width*2, 2*(turn_r-zfromx(z)),  interval*2]);
            // Cut bottom of circle
            translate([-cylinder_d/2,turn_r/2,0]) rotate([-45,0,0]) cube([turn_r*2, turn_r*2,turn_r*2], center=true);
            // Scrrew holes
            if(short_support) 
            {
                translate([-cylinder_d/2,-turn_r+zfromx(z)-framing_wall,0])  translate([timber_construct_h-framing_wall*7,0,interval-framing_wall*2.5]) rotate([90,0,0]) cylinder(h=framing_wall*4,d=screw_thread_d, center=true);
                // Scrrew holes
                translate([-cylinder_d/2,-turn_r+zfromx(z)-framing_wall,0])  translate([timber_construct_h-framing_wall*3,0,interval-framing_wall*1.5]) rotate([90,0,0]) cylinder(h=framing_wall*4,d=screw_thread_d, center=true);
            }
            else
            {
                translate([-cylinder_d/2,-turn_r+zfromx(z)-framing_wall,0])  translate([timber_construct_h+timber_construct_w-framing_wall*7,framing_wall*8,interval-framing_wall*3.5]) rotate([0,0,0]) cylinder(h=timber_construct_w,d=screw_thread_d, center=true);
                // Scrrew holes
                translate([-cylinder_d/2,-turn_r+zfromx(z)-framing_wall,0])  translate([timber_construct_h+timber_construct_w-framing_wall*3,framing_wall*3,interval-framing_wall*7]) rotate([0,0,0]) cylinder(h=timber_construct_w*2,d=screw_thread_d, center=true);
            }
                
        }

    // Reduce plastic to print
*                translate([0,0,turn_r*2/4]) rotate([45,0,0]) cube(turn_r/2,center=true);

    }
}

module turn_support_outer_start()
{
    turn_support_outer(interval=interval_blocks, z=0);
}

module turn_support_outer_end(short_support=true)
{
    mirror([0,1,0]) turn_support_outer(interval=interval_blocks*4, z=length_top-(interval_blocks*4), short_support=short_support);
}


module turn_support_inner(turn_r=160, interval=interval_blocks, z=0, guide=true)
{
    inner_r = turn_r+ball_bearing_d+slant_thickness;
    union()
    {
        for(a = [-0+90/16:90/8:95])
        {
            rotate([a,0,0]) 
            {
                translate([0,0,-turn_r-ball_bearing_d-slant_thickness-screw_mount_h]) base_holder();
            }
        }
    }
     difference()
    {

        translate([0,inner_r/2+screw_mount_h,-inner_r/2-screw_mount_h]) squircle([base_holder_width,inner_r+screw_mount_h,inner_r+screw_mount_h],center=true);
        rotate([0,90,0]) cylinder(h=base_holder_width*2,r=inner_r+screw_mount_h, center=true);
    }
    
    if(guide)
    {
        translate([-cylinder_d/2,0,-(inner_r+screw_mount_h*3/2)]) difference()
        {
            union()
            {
                squircle([timber_construct_h,inner_r+screw_mount_h*3/2,screw_mount_h], center=false);
            }
            translate([framing_wall,framing_wall,-screw_mount_h]) squircle([timber_construct_h-framing_wall*2,inner_r+screw_mount_h*3/2-framing_wall*2,screw_mount_h*4], center=false);
         }
        translate([-cylinder_d/2,0,-(inner_r+screw_mount_h*3/2)]) difference()
         {
             union()
             {
                translate([0,(inner_r+screw_mount_h*3/2)*2/3-screw_thread_d/2,0]) cube([timber_construct_h,screw_thread_d,screw_mount_h], center=false);
                translate([0,(inner_r+screw_mount_h*3/2)*1/3-screw_thread_d/2,0]) cube([timber_construct_h,screw_thread_d,screw_mount_h], center=false);
    
                translate([timber_construct_h*3/4,(inner_r+screw_mount_h*3/2)*2/3,screw_mount_h/2]) cylinder(h=screw_mount_h, d=screw_thread_d*3, center=true);
                translate([timber_construct_h*3/4,(inner_r+screw_mount_h*3/2)*1/3,,screw_mount_h/2]) cylinder(h=screw_mount_h, d=screw_thread_d*3, center=true);
    
    
             }
             translate([timber_construct_h*3/4,(inner_r+screw_mount_h*3/2)*2/3,0]) cylinder(h=screw_mount_h*4, d=screw_thread_d, center=true);
             translate([timber_construct_h*3/4,(inner_r+screw_mount_h*3/2)*1/3,0]) cylinder(h=screw_mount_h*4, d=screw_thread_d, center=true);
            
         }
    }
}


module turn_support_inner_split(turn_r=160, interval=interval_blocks, z=0, guide=true)
{
    
    inner_r = turn_r+ball_bearing_d+slant_thickness;
    peg_z_top = -sqrt(inner_r*inner_r*2)-screw_thread_d/2;
    peg_z_bottom = -inner_r-screw_thread_d/2;
    module pegs(reduce=0)
    {
        rotate([45,0,0]) translate([0,0,peg_z_top+base_holder_width/4]) rotate([90,0,0]) cylinder(h=screw_thread_d-reduce*2, d=screw_thread_d-reduce, center=true);
        rotate([45,0,0]) translate([0,0,peg_z_bottom-base_holder_width/4]) rotate([90,0,0]) cylinder(h=screw_thread_d-reduce*2, d=screw_thread_d-reduce, center=true);
        
    }
    difference()
    {
        turn_support_inner(turn_r=turn_r, interval=interval, z=z, guide=guide);
        translate([0,sqrt(inner_r*inner_r*2),0])  rotate([45,0,0])cube([inner_r*2,inner_r*2,inner_r*2], center=true);
        translate([base_holder_width/4,0,0]) pegs();
    }
    translate([-base_holder_width/4,0,0]) pegs(reduce=click_slop*2);
}

module turn_support_inner_split_reconstruct(turn_r=160, interval=interval_blocks, z=0)
{
inner_r = turn_r+ball_bearing_d+slant_thickness;

translate([cylinder_d/2,0,+inner_r+screw_mount_h*3/2])turn_support_inner_split();
translate([cylinder_d/2,0,+inner_r+screw_mount_h*3/2])
    rotate([270,0,180])turn_support_inner_split(guide=false);  
}

module turn_support_inner_split_reconstruct_offset(turn_r=160, interval=interval_blocks, z=0)
{
inner_r = turn_r+ball_bearing_d+slant_thickness;
    translate([0,-inner_r,0]) turn_support_inner_split_reconstruct();
}

module turn_support_outer_end_under()
{
     mirror([0,1,0]) turn_support_outer_end(short_support=false);
}

module belt_connect_hidge(slat_w=90, slat_t=18)
{
    os=screw_thread_d+screw_thread_wall;
    translate([slat_w/2+os/2+framing_wall,0,-framing_wall/2]) difference()
    {
        hull()
        {
            cylinder(d=os, h=framing_wall, center=true);
            translate([-os/2,0,0]) cube([os,os, framing_wall],center=true);
        }
        cylinder(d=screw_thread_d,h=framing_wall*2, center=true);
    }
}

module belt_connect(slat_w=90, slat_t=18)
{
    difference()
    {
        union()
        {
            squircle([slat_w+framing_wall*2, slat_t+framing_wall*2, framing_wall*2], center=true);
            belt_connect_hidge();
            rotate([0,180,0]) belt_connect_hidge();
        }
        translate([0,0,framing_wall*2]) cube([slat_w, slat_t, framing_wall*4], center=true);
        translate([0,0,screw_mount_h/2]) rotate([0,180,0]) screw_hole_pair(countersunk=true, ball_hole=false, shell_hole=false);
        cylinder(h=framing_wall*4, r=radius_base, center=true);
    }
}

belt_connect();


*turn_support_inner_split();
*turn_support_inner_split(guide=false);
*turn_support_inner_split_reconstruct();

//screw_mount_h
*rotate([45,0,45]) turn_support_outer_start();
*rotate([45,0,-45]) turn_support_outer_end_under();



*support_base(piece=0);
*support_base(piece=0, heights=false);
*base_holder();
*bearing_shell();
*ball_bearing() ;