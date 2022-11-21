use <./crazywalk_parts.scad>;

part = "support_base";
piece = 1;
heights = true;
mirror = false;

echo("Part:", part,"Piece:", piece,"Heights:", heights, "Mirror:", mirror);

module apply_mirror()
{
    if(mirror)
    {
        mirror([0,1,0]) children(); 
    }
    else
    {
        mirror([0,0,0]) children(); 
    }
}


if(part=="bearing_shell")
    bearing_shell();

if(part=="turn_support_inner_split_no_guide")
    apply_mirror() turn_support_inner_split(guide=false);

if(part=="turn_support_inner_split")
    apply_mirror() turn_support_inner_split(guide=true);

if(part=="turn_support_outer_start")
    apply_mirror() rotate([45,0,45]) turn_support_outer_start();

if(part=="turn_support_outer_end")
    apply_mirror() rotate([-45,0,45]) turn_support_outer_end();

if(part=="support_base")
    apply_mirror() support_base(piece=piece, heights=heights);