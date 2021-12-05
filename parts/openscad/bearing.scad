$fn=48;
ball_bearing_d = 16+.25;
height_ball = 0.5;
ball_bearing_wall = 2;

screw_thread_d= 5 ;
screw_thread_wall = 3;
screw_head = 8;
slop=0.2;
layer_height = 0.4;

framing_wall = 3;
wood_width=63;
screw_near_edge=10;


angle_of_support = 45;
angle_of_top = 45+15;

screw_outer=screw_thread_d+screw_thread_wall*2;
screw_outer_translate=(ball_bearing_d+screw_outer)/2+ball_bearing_wall;


// http://www.ambrsoft.com/TrigoCalc/Sphere/Cap/SphereCap.htm
// h=R(1-cosTheta)
// r=RsinTheta
height_base=(ball_bearing_d/2)*(1-cos(angle_of_support));
radius_base=(ball_bearing_d/2)*(sin(angle_of_support));



module ball_bearing() {
    translate([0,0, height_ball + ball_bearing_d/2])
        color(alpha = 0.95, c = "Blue") 
            sphere(d = ball_bearing_d);
}

module tube(d1, d2, h)
{
    difference() {
        cylinder(d=d1, h=h);
        cylinder(d=d2, h=h*4, center=true);
    }
}

module screw_hole(connector=0)
{
    if(connector==1)
    {
        cylinder(d=screw_thread_d+
                    screw_thread_wall/2+slop*2,
                 h=(height_base+height_ball)*4,
                 center=true
                 );
    }
    else
    {
        cylinder(d=screw_thread_d,
                 h=(height_base+height_ball)*4,
                 center=true
                 );
    }    
}

module screw_hole_pair(connector=0)
{
        translate([screw_outer_translate,
                    0,
                    0]) 
            screw_hole(connector=connector);
        translate([-screw_outer_translate,
                    0,
                    0]) 
            screw_hole(connector=connector);
        cylinder(d=ball_bearing_d ,
                    h=(height_base+height_ball)*4,
                    center=true
                    );
}




module screw_mount(connector=0)
{
    
    difference()
    {
        union()
        {
            hull()
            {
                translate([screw_outer_translate,
                            0,
                            0]) 
                    cylinder(d=screw_outer,
                            h=height_base+height_ball
                            );
                translate([-screw_outer_translate,
                            0,
                            0]) 
                    cylinder(d=screw_outer,
                            h=height_base+height_ball
                            );
            }
            if(connector==2)
            {
               translate([-screw_outer_translate,
                      0,
                      0]) 
                cylinder(
                    d=screw_thread_d+screw_thread_wall/2,
                    h=height_base*1.5+height_ball
                    );
               translate([screw_outer_translate,
                      0,
                      0]) 
                cylinder(
                    d=screw_thread_d+screw_thread_wall/2,
                    h=height_base*1.5+height_ball
                    );
            }
        }
        screw_hole_pair(connector=connector);
    }
}

module bearing_shell()
{
    screw_outer = ball_bearing_d + ball_bearing_wall*2;
    translate([0,0, height_ball + ball_bearing_d/2])difference()
    {
        sphere(d = screw_outer);    
        sphere(d = ball_bearing_d);
        translate([0,0,-screw_outer/2]) cube(screw_outer, center=true);
        translate([0,0,screw_outer-ball_bearing_wall-height_base*1.5]) cube(screw_outer, center=true);        
    }
    translate([0,0, height_ball + height_base]) difference()
    {
        tube(screw_outer, ball_bearing_d, ball_bearing_d/2-height_base);
    }
    translate([0,0,height_base+height_ball]) screw_mount(connector=1);

}


module base_holder(){
    tube(ball_bearing_d+ball_bearing_wall*2, radius_base*2, height_base+height_ball);
    screw_mount(connector=2);
}

// Used by python scripts



module support_base(height_c=100, length_c=50, connector=0, text="1A")
{
    top_support = height_c-height_base;
    screw_mount_h = height_base+height_ball;
    cylinder_d = ball_bearing_d+ball_bearing_wall*2;
    
    
    translate([0,0,top_support]) base_holder();

    // Min screw length m5=30 allow 10 to manimulate
    if(height_c<40)
    {
        scale_z = top_support/(screw_mount_h);
        scale([1,1,scale_z]) screw_mount();
    }
    else
    {
        scale([1,1,2]) screw_mount();
        // Need support for high screw_mount
        translate([0,0,top_support-layer_height*2]) 
        {
            difference()
            {
                rotate([0,45,0])
                    cube([(screw_outer_translate*2+screw_outer*1)*sin(45), 
                        screw_outer,
                        (screw_outer_translate*2+screw_outer*1)*sin(45)], 
                        center=true);
                rotate([0,45,0])
                    cube([(screw_outer_translate*2+screw_outer*1), 
                        screw_head,
                        (screw_outer_translate*2+screw_outer*1)], 
                        center=true);
               translate([0,0,(screw_outer_translate*2+screw_outer*1)/2]) cube(screw_outer_translate*2+screw_outer*1, center=true);
            
            }
            // Print a square hole below the circle to ease printing
            translate([0,0,layer_height])  difference() 
            {                
                cube([screw_outer_translate*2+screw_outer*1,
                    screw_outer, 
                    layer_height*2],
                    center=true
                );
                translate([screw_outer_translate,0,-layer_height/2])
                    cube([screw_thread_d,
                        screw_head, 
                        layer_height],
                        center=true
                    );
                translate([screw_outer_translate,0,+layer_height/2])
                    cube([screw_thread_d,
                        screw_thread_d, 
                        layer_height],
                        center=true
                    );
                translate([-screw_outer_translate,0,-layer_height/2])
                    cube([screw_thread_d,
                        screw_head, 
                        layer_height],
                        center=true
                    );
                translate([-screw_outer_translate,0,+layer_height/2])
                    cube([screw_thread_d,
                        screw_thread_d, 
                        layer_height],
                        center=true
                    );

            }
        }
    }

    // main support Cylinder
    cylinder(d=cylinder_d,
            h=top_support);


    // spacer between cylinders
    difference()
    {
        translate([0,0,framing_wall/2]) cube([length_c,framing_wall,framing_wall], center=true);
        screw_hole_pair();
    }

    // Part to macth edge of support wood (wood_width) with screw_hole
    difference() {
         translate([(screw_outer)/2,wood_width/2-cylinder_d/2,framing_wall/2])
            cube([screw_outer+framing_wall,wood_width,framing_wall], center=true);
         cylinder(r=radius_base, h=framing_wall*4, center=true);
        translate([0, -cylinder_d/2, 0])  cube([(screw_outer+framing_wall)*2, cylinder_d/2,framing_wall*4], center=true);
        translate([(screw_outer+framing_wall)/2, wood_width-cylinder_d/2-screw_near_edge, 0]) screw_hole();
    }
    // Diagnal rib
    difference() {
        translate([0,-cylinder_d/2,framing_wall]) 
        rotate([45,0,0]) cube([framing_wall, wood_width*cos(45)*2, wood_width*cos(45)*2], center=true);
        translate([0,-wood_width*1+cylinder_d/3, 0]) cube([framing_wall*2, wood_width*2, wood_width*4], center=true);
        translate([0,0, -wood_width]) cube([framing_wall*2, wood_width*4, wood_width*2], center=true);
        if(height_c<wood_width)
        {
        translate([0,wood_width+cylinder_d/2,wood_width-(wood_width-height_c)-framing_wall]) 
        rotate([45,0,0]) cube([framing_wall*2, wood_width*cos(45)*2, wood_width*cos(45)*4], center=true);
        }
            
    }
    // text 
    translate([framing_wall/2,wood_width/2,0]) linear_extrude(framing_wall+layer_height) text(text, size=screw_outer/2);


    // to align to side of support 1 of 2
  *  translate([-length_c/2+framing_wall,
                -cylinder_d/4,
                framing_wall/4]) 
            cube([framing_wall,
                  cylinder_d/2,
                  framing_wall/2], 
                  center=true);    
    if(connector==1){
    // to align to side of support 2 of 2
   *     translate([+length_c/2-framing_wall,
                -cylinder_d/4,
                framing_wall/4]) 
            cube([framing_wall,
                  cylinder_d/2,
                  framing_wall/2], 
                  center=true);

        // connector between cylinders
         translate([length_c/2,0,framing_wall/2]) 
        {
            difference()
            {
                cube([framing_wall,framing_wall*3,framing_wall], center=true);
                translate([framing_wall/2,0,0]) cube([framing_wall,framing_wall+slop,framing_wall*4], center=true);
            }
        }
    }
}





*color("red") translate([16,0,6]) cylinder(d=8, h=5);
*ball_bearing();
;
*support_base(height_c=3, connector=0,length_c=100);
*color("red") translate([50,0,0])  support_base(height_c=51, connector=0);
*translate([0,-(ball_bearing_d+ball_bearing_wall*2)/2,0]) cube([20, 63,10]);
