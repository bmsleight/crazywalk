
use <./Whole_Frame.scad>;
use <./crazywalk_parts.scad>;


module printed_baring()
{
    frame3Position() translate([0,0,0])  color("white") support_base();
    frame3Position() translate([0,0,0])  rotate([0,0,90]) color("green") turn_support_outer_start();
    turnNightyOuterFarEndPosition() rotate([0,0,90]) color("green") turn_support_outer_end();
    turnNightyInsidePosition() translate([0,70,0])  color("green")  turn_support_inner_split_reconstruct();   
    
    translate([0,0,-38*4]) turnNightyOuterFarEndPosition() rotate([180,0,90]) color("green") turn_support_outer_end_under();
    
    lowerBaringPosition() color("white")  support_base(heights=false);
}


whole_frame();
printed_baring();
mirror([0,1,0]) printed_baring();



/*
mirror([0,1,0]) frame3Position() translate([0,10,0]) color("white") import("../stl/all_supports.stl", convexity=3);

turnNightyInsidePosition() color("white") import("../stl/turn_night_inside.stl", convexity=3);

mirror([0,1,0]) turnNightyInsidePosition() color("white") import("../stl/turn_night_inside.stl", convexity=3);

* turnNightyInsideFarEndPosition() color("blue") import("../stl/turn_night_inside.stl", convexity=3);
*/