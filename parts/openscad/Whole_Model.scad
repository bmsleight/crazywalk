
timber_construct_w = 38;
timber_construct_h = 63;

module cube_named(size,comment="//", center=false)
{
    if (comment != "//")
        echo(comment);
    // Cube - but will echo dimensions in order of size
    if( (size[0]>size[1]) && (size[1]>=size[2]) )
       echo( size[0], size[1], size[2]);
    if( (size[0]>size[2]) && (size[2]>size[1]) )
       echo( size[0], size[2], size[1]);
    
    if( (size[1]>size[0]) && (size[0]>=size[2]) )
       echo( size[1], size[0], size[2]);
    if( (size[1]>size[2]) && (size[2]>size[0]) )
       echo( size[1], size[2], size[0]);
    
    if( (size[2]>size[0]) && (size[0]>=size[1]) )
       echo( size[2], size[0], size[1]);
    if( (size[2]>size[1]) && (size[1]>size[0]) )
       echo( size[2], size[1], size[0]);

    cube(size, center=center);
}


module timber_length(length, direction=1, comment="//", center=false)
// direction 1 = along x, z = timber_construct_h, y = timber_construct_w
// direction 2 = along x, z = timber_construct_w, y = timber_construct_h
// direction 3 = along y, x = timber_construct_w, z = timber_construct_h
// direction 4 = along y, x = timber_construct_h, z = timber_construct_w
// direction 5 = along z, x = timber_construct_w, y = timber_construct_h
// direction 6 = along z, x = timber_construct_h, y = timber_construct_w
{
    if(direction==1)
        cube_named([length, timber_construct_w, timber_construct_h],
                    comment=comment, center=center);
    if(direction==2)
        cube_named([length, timber_construct_h, timber_construct_w],
                    comment=comment, center=center);
    if(direction==3)
        cube_named([timber_construct_w, length, timber_construct_h],
                    comment=comment, center=center);
    if(direction==4)
        cube_named([timber_construct_h, length, timber_construct_w],
                    comment=comment, center=center);
    if(direction==5)
        cube_named([timber_construct_w, timber_construct_h, length],
                    comment=comment, center=center);
    if(direction==6)
        cube_named([timber_construct_h, timber_construct_w, length],
                    comment=comment, center=center);
}



module left_side_bar()
{
    translate([165,+600-timber_construct_h,300])
    {
        translate([0,10,0]) color("green") import("../stl/all_supports.stl", convexity=3);
        translate([0, 0,-timber_construct_w]) timber_length(1420, direction=2, comment="Side Bar Support");
        translate([0, -600+timber_construct_h, -12]) middle_panel();
    }
}

module right_side_bar()
{
    mirror([0,1,0]) translate([165,-timber_construct_h,300])
    {
        translate([0,10,0]) color("green") import("../stl/all_supports.stl", convexity=3);
        translate([0, +timber_construct_h,-timber_construct_w]) mirror([0,1,0]) timber_length(1420, direction=2, comment="Side Bar Support");
    }
}


module side_panel()
{
    cube_named([1400+200+50,12,450], comment="Side Panel");
}

module middle_panel()
{
        translate([0, 0,-timber_construct_w]) cube_named([1420, 600, 12], comment="Side Bar Support");
}


//translate([0,0,400]) color("green") import("../stl/all_supports.stl", convexity=3);
//#cube([1400,640,400]);

left_side_bar();
right_side_bar();
translate([0,600,0]) side_panel();
translate([0,-12,0]) side_panel();
