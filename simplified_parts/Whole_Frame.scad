timber_construct_w = 38;
timber_construct_h = 63;
overall_width = 650;
overall_length = 1100;
length_top = 900;
bearing_height = 400;
interval=24;

line_t = 0.4;

use <./beam_holder.scad>;
block_h=5;

module timber_length(length, direction=1, comment="//", center=false)
// direction 1 = along x, z = timber_construct_h, y = timber_construct_w
// direction 2 = along x, z = timber_construct_w, y = timber_construct_h
// direction 3 = along y, x = timber_construct_w, z = timber_construct_h
// direction 4 = along y, x = timber_construct_h, z = timber_construct_w
// direction 5 = along z, x = timber_construct_w, y = timber_construct_h
// direction 6 = along z, x = timber_construct_h, y = timber_construct_w
{
    if(direction==1)
    {
        timber_length_n(length, comment=comment);
    }
    if(direction==2)
    {
        translate([0,timber_construct_h,0]) rotate([90,0,0]) timber_length_n(length, comment=comment);

    }
    if(direction==3)
    {
        translate([timber_construct_w,0,0]) rotate([0,0,90]) timber_length_n(length, comment=comment);
    }
    if(direction==4)
    {
        translate([0,0,0]) rotate([90,0,90]) timber_length_n(length, comment=comment);
    }
    if(direction==5)
    {
        translate([0,0,0]) rotate([270,270,0]) timber_length_n(length, comment=comment);
    }
    if(direction==6)
    {
        translate([timber_construct_h,0,0]) rotate([0,270,0]) timber_length_n(length, comment=comment);
    }
}

module timber_text(length, comment="")
{
    color("red") translate([0,0,0])  
    {
        translate([0,0,-timber_construct_w/2]) linear_extrude(timber_construct_w)
 text(text=str(comment,":", length, "mm"), size=timber_construct_w/2, halign="center", valign="center");
    }
}

module timber_length_n(length, direction=1, comment="", edges=true)
{
    translate([length/2, timber_construct_w/2, timber_construct_h/2])
    {
        color("Goldenrod") cube([length, timber_construct_w, timber_construct_h], center=true);
        // Ends
        color("SaddleBrown") translate([-length/2, 0,0]) cube([0.1, timber_construct_w, timber_construct_h], center=true);
        color("SaddleBrown") translate([length/2, 0,0]) cube([0.1, timber_construct_w, timber_construct_h], center=true);        
        if(edges) 
        {
            color("White") translate([-length/2, timber_construct_w/2,0]) cube([line_t, line_t, timber_construct_h], center=true); 
            color("White") translate([-length/2, -timber_construct_w/2,0]) cube([line_t, line_t, timber_construct_h], center=true); 
            color("White") translate([-length/2, 0,-timber_construct_h/2]) cube([line_t, timber_construct_w, line_t], center=true); 
            color("White") translate([-length/2, 0,timber_construct_h/2]) cube([line_t, timber_construct_w, line_t], center=true); 
            color("White") translate([length/2, timber_construct_w/2,0]) cube([line_t, line_t, timber_construct_h], center=true); 
            color("White") translate([length/2, -timber_construct_w/2,0]) cube([line_t, line_t, timber_construct_h], center=true); 
            color("White") translate([length/2, 0,-timber_construct_h/2]) cube([line_t, timber_construct_w, line_t], center=true); 
            color("White") translate([length/2, 0,timber_construct_h/2]) cube([line_t, timber_construct_w, line_t], center=true); 

            color("White") translate([0, timber_construct_w/2,timber_construct_h/2]) cube([length, line_t, line_t], center=true); 
            color("White") translate([0, -timber_construct_w/2,timber_construct_h/2]) cube([length, line_t, line_t], center=true); 
            color("White") translate([0, -timber_construct_w/2,-timber_construct_h/2]) cube([length, line_t, line_t], center=true);
            color("White") translate([0, timber_construct_w/2,-timber_construct_h/2]) cube([length, line_t, line_t], center=true);
        }

        // Text
        rotate([0,0,0]) translate([0,0,timber_construct_h/2-timber_construct_w/2+line_t]) timber_text(length, comment=comment); 
        rotate([90,0,0]) translate([0,0,line_t]) timber_text(length, comment=comment); 
        rotate([180,0,0]) translate([0,0,timber_construct_h/2-timber_construct_w/2+line_t]) timber_text(length, comment=comment); 
        rotate([270,0,0]) translate([0,0,line_t]) timber_text(length, comment=comment); 
        echo(comment, length);
    }
}


module frame3Position() 
{ 
    translate([165,(overall_width-timber_construct_w*2-timber_construct_h*2)/2,bearing_height]) children(); 
} 

module frame1DEPosition() 
{ 
    frame3Position() 
        translate([0,-overall_width-timber_construct_w+timber_construct_h+timber_construct_w*2,-timber_construct_w*2]) 
        children(); 
} 

module frame4Position() 
{ 
    frame3Position() translate([0,timber_construct_h,-bearing_height+timber_construct_w*1])
        children(); 
}

module frame5Position() 
{ 
    frame3Position() translate([timber_construct_h+block_h,timber_construct_h,-bearing_height+timber_construct_w*1+timber_construct_w])
        children(); 
}

module frame6Position() 
{ 
    frame4Position()  translate([length_top-overall_length+timber_construct_h+block_h,0,bearing_height-timber_construct_w*3-timber_construct_h])
        children(); 
}


module frame1ABCPosition()
{
    frame4Position() translate([length_top-overall_length,timber_construct_w-overall_width,-timber_construct_w]) 
        children();     
}

module frame2ABPosition()
{
    frame1ABCPosition() translate([0,+timber_construct_w,timber_construct_w]) 
        children();     
}

module beamHolderPosition6() 
{
    translate([block_h/2-block_h,timber_construct_w/2,timber_construct_h/2]) rotate([0,270,0])
        children();
}

module beamHolderPosition5() 
{
    translate([-block_h,0,timber_construct_h]) rotate([0,180,0]) beamHolderPosition6() 
        children();
}

module turnNightyInsidePosition()
{
    frame5Position() translate([0,-timber_construct_h,0]) rotate([0,0,90])  children();
}

module turnNightyInsideFarEndPosition() 
{
    frame3Position()  translate([length_top,0,0])
    children();
}

module lowerBaringPosition()
{
    frame3Position() translate([-interval,0,-bearing_height+timber_construct_w*2]) 
    children();
}



module frame_3A()
{
    frame3Position()
    {
        translate([0, 0,-timber_construct_w]) timber_length(length_top, direction=2, comment="3A");
    }
}

module frame_3B()
{    frame3Position()
    {
            translate([0, timber_construct_w*2+timber_construct_h-overall_width,-timber_construct_w]) timber_length(length_top, direction=2, comment="3B");
    }
}

module frame_1DE()
{
    frame1DEPosition()
    {
        timber_length(overall_width, direction=4, comment="1D");
        translate([length_top-timber_construct_h, 0, 0]) timber_length(overall_width, direction=4, comment="1E");
    }

}

module frame_4()
{
    frame4Position()
    {

        translate([0,0,0]) 
            timber_length(bearing_height-timber_construct_w*3, direction=6, comment="4B");
        translate([length_top-timber_construct_h,0,0]) 
            timber_length(bearing_height-timber_construct_w*3, direction=6, comment="4C");
        translate([0,-overall_width+timber_construct_w,0]) 
            timber_length(bearing_height-timber_construct_w*3, direction=6, comment="4E");
        translate([length_top-timber_construct_h,-overall_width+timber_construct_w,0]) 
            timber_length(bearing_height-timber_construct_w*3, direction=6, comment="4F");
        translate([length_top-overall_length,0,0]) 
            timber_length(bearing_height-timber_construct_w*3, direction=6, comment="4A");
        translate([length_top-overall_length,-overall_width+timber_construct_w,0]) 
            timber_length(bearing_height-timber_construct_w*3, direction=6, comment="4B");

    }

}


module frame_5()
{
    frame5Position()
    {
        frame_5_length = length_top-timber_construct_h-timber_construct_h-block_h*2;
        translate([0,0,0]) {
            timber_length(frame_5_length, direction=1, comment="5A");
            beamHolderPosition5() beam_holder(beam_units=2);
            translate([frame_5_length+block_h,0,0])beamHolderPosition5() beam_holder_mirror(beam_units=2);
        }
        translate([0,-overall_width+timber_construct_w,0])
        {
            timber_length(length_top-timber_construct_h-timber_construct_h, direction=1, comment="5B");
            beamHolderPosition5() rotate([180,0,0]) beam_holder_mirror(beam_units=2);
            translate([frame_5_length+block_h,0,0])beamHolderPosition5() rotate([180,0,0]) beam_holder(beam_units=2);
        }
    }
}

module frame_6()
{
    frame6Position()
    {
        frame_6_length = overall_length-length_top-timber_construct_h-block_h*2;
        translate([0,0,0]) 
        {
            timber_length(frame_6_length, direction=1, comment="6A");
        beamHolderPosition6() beam_holder_mirror(beam_units=0);
            translate([frame_6_length+block_h,0,0]) beamHolderPosition6() beam_holder(beam_units=0);
        }

        translate([0,-overall_width+timber_construct_w,0])
        { 
            timber_length(frame_6_length, direction=1, comment="6B");
            beamHolderPosition6() beam_holder_mirror(beam_units=0);
        translate([frame_6_length+block_h,0,0]) beamHolderPosition6() beam_holder(beam_units=0);
        }

    }
}



module frame_1ABC()
{
    frame1ABCPosition() 
    {
        translate([0,0,0]) 
            timber_length(overall_width, direction=4, comment="1A");    
        translate([overall_length-length_top,0,0]) 
            timber_length(overall_width, direction=4, comment="1B");    
        translate([overall_length-timber_construct_h,0,0]) 
            timber_length(overall_width, direction=4, comment="1C");    
    }
}

module frame_2ABC()
{
    frame2ABPosition()
    {
        translate([0,0,0]) 
            timber_length(overall_length, direction=2, comment="2B");
        translate([0,overall_width-timber_construct_w*2-timber_construct_h,0]) 
            timber_length(overall_length, direction=2, comment="2A");
    }
}

//translate([0,0,400]) color("green") import("../stl/all_supports.stl", convexity=3);
//#cube([1400,640,400]);

module whole_frame()
{
    frame_3A();
    frame_3B();
    frame_1DE();
    frame_1ABC();
    frame_4();
    frame_2ABC();
    frame_5();
    frame_6();
}

whole_frame();