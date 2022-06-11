$fn=48;
ball_bearing_d = 16+.25+.25;
height_ball = 0.5;
ball_bearing_wall = 2;

screw_thread_d= 5 ;
screw_thread_wall = 3;
screw_head = 8;
slop=0.2;
layer_height = 0.4;

framing_wall = 3;
wood_width=63;
wood_height=38;

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
    if(connector<3)
    {
        cylinder(d=ball_bearing_d ,
                    h=(height_base+height_ball)*4,
                    center=true
                    );
    }
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

module struts(size=45)
{
    translate([size/2,-8.25,size/2-size])
    {
        difference()
        {
            union()
            {
                rotate([0,45,0]) cube([size*2,3,3], center=true);
                rotate([0,-45,0]) cube([size*2,3,3], center=true);
            }
            translate([0,0,-size]) cube([size*4,size,size], center=true);
            translate([0,0,size]) cube([size*4,size,size], center=true);
        }
    }
}



module support_base(height_c=100, length_c=50, connector=0, text="1A")
{
    top_support = height_c-height_base;
    screw_mount_h = height_base+height_ball;
    cylinder_d = ball_bearing_d+ball_bearing_wall*2;
    
    
    translate([0,0,top_support]) base_holder();

    // Min screw length m5=30 allow 10 to manimulate
    if(height_c<30)
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
    // To add struts to tall supports
    if(connector==0 && height_c>length_c)
    {
        translate([0,0,height_c]) struts(length_c);
    }
}

module belt_connect_hidge(slat_w=90, slat_t=12)
{
    os=screw_thread_d+screw_thread_wall;
    translate([slat_w/2+os/2+framing_wall,0,-framing_wall/2]) difference()
    {
        hull()
        {
            cylinder(d=os, h=framing_wall, center=true);
            translate([-os/4,0,0]) cube([os/2,os, framing_wall],center=true);
        }
        cylinder(d=screw_thread_d,h=framing_wall*2, center=true);
    }
}

module rounded_cube(x,y,z,r)
{
    hull()
    {
        translate([x/2-r, y/2-r, 0]) cylinder(r=r, h=z, center=true);
        translate([x/2-r, -y/2+r, 0]) cylinder(r=r, h=z, center=true);
        translate([-x/2+r, y/2-r, 0]) cylinder(r=r, h=z, center=true);
        translate([-x/2+r, -y/2+r, 0]) cylinder(r=r, h=z, center=true);
    }
}

module belt_connect(slat_w=90, slat_t=12)
{
    difference()
    {
        * cube([slat_w+framing_wall*2, slat_t+framing_wall*2, framing_wall*2], center=true);
        rounded_cube(slat_w+framing_wall*2,
                     slat_t+framing_wall*2,
                     framing_wall*2,
                     framing_wall);
        translate([0,0,framing_wall*2]) cube([slat_w, slat_t, framing_wall*4], center=true);
        screw_hole_pair(connector=3);
    }
    belt_connect_hidge();
    rotate([0,180,0]) belt_connect_hidge();
}

module turn_nighty_bearing_start(diameter_turn=320, notch_h=100, notch_overlap=10)
{
    rotate([0,45,0]) translate([0,0,-notch_overlap*2]) rotate([0,-45,0]) mirror([0,0,0]) turn_nighty_bearing(diameter_turn=diameter_turn, notch_h=(diameter_turn/2)-notch_h-(notch_overlap*2), notch_overlap=notch_overlap);
}


module turn_nighty_bearing(diameter_turn=320, notch_h=100, notch_overlap=10)
{
    union() translate([diameter_turn*sin(45)/2-(notch_h/sin(45)),0,0])
    {
        difference()
        {
            union()
            {
                for (a =[0:15:90-15])
                {
                    translate([0,0,-diameter_turn/2*sin(45)]) rotate([0,a+7.5-45,0]) turn_nighty_bearing_part();
                }
            }
            translate([0,0,-diameter_turn/2])  cube([diameter_turn,screw_outer*4,diameter_turn], center=true);
            //Notch
            translate([0,0,-diameter_turn/2*sin(45)])  
             rotate([0,45,0]) 
              translate([-diameter_turn/2+notch_h+notch_overlap,0,notch_h+notch_overlap])  
                    cube([notch_overlap*2,notch_overlap*4,notch_overlap*2], center=true);
        }
        
         translate([0,0,-diameter_turn/2*sin(45)])  
             rotate([0,45,0]) 
              translate([-diameter_turn/2+notch_h-framing_wall/2,wood_width/2-(ball_bearing_d+ball_bearing_wall*2)/2,notch_h+notch_overlap]) 
                {
                    difference()
                    {
                        cube([framing_wall,wood_width,notch_overlap*2], center=true);
                       translate([0,(ball_bearing_d+ball_bearing_wall*2)/2,0]) rotate([90,0,0]) rotate([0,90,0]) screw_hole_pair(connector=3);
                    }
                    translate([-wood_width/2,0,(framing_wall-notch_overlap*2)/2]) 
                    difference()
                    {
                        cube([wood_width,wood_width,framing_wall], center=true);
                        rotate([0,0,45]) translate([wood_width,wood_width,]) cube([wood_width*4,wood_width*2,framing_wall*4], center=true);
                    }
                }
            }
}


module turn_nighty_bearing_part(diameter_turn=320)
{
    translate([0,0,diameter_turn/2]) base_holder();
    difference()
    {
        translate([0,0,diameter_turn/4]) 
            cube([diameter_turn/4,
                  (ball_bearing_d+ball_bearing_wall*2),
                  diameter_turn/2], center=true);
        
        rotate([0,15/2,0])
            translate([diameter_turn/8,0,diameter_turn/4]) 
            cube([diameter_turn/4,
                  (ball_bearing_d+ball_bearing_wall*2)*2,
                  diameter_turn], center=true);
        rotate([0,-15/2,0])
            translate([-diameter_turn/8,0,diameter_turn/4]) 
            cube([diameter_turn/4,
                  (ball_bearing_d+ball_bearing_wall*2)*2,
                  diameter_turn], center=true);
    }
}



*ball_bearing();
*bearing_shell();
*support_base();
belt_connect();
*rounded_cube(90,16,12,5);
*rotate([0,45,0]) turn_nighty_bearing();
*turn_nighty_bearing(notch_h=160-20-10);
*turn_nighty_bearing_start(notch_h=10);