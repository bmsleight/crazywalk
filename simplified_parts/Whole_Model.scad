
use <./Whole_Frame.scad>;
use <./crazywalk_parts.scad>;

whole_frame();

* import("./stl/Whole_Model.stl", convexity=3);

frame3Position() translate([0,0,0])  color("white") support_base();
frame3Position() translate([0,0,0])  rotate([0,0,90]) color("green") turn_support_outer_start();
turnNightyInsideFarEndPosition() rotate([0,0,90]) color("green") turn_support_outer_end();
turnNightyInsidePosition() translate([0,70,0])  color("green")  turn_support_inner_split_reconstruct();

lowerBaringPosition()
color("white")  support_base(heights=false);



* mirror([0,1,0]) 
{
    frame3Position() translate([0,0,0])  color("white") support_base();
    frame3Position() translate([0,0,0])  rotate([0,0,90]) color("green") turn_support_outer_start();
    turnNightyInsideFarEndPosition() rotate([0,0,90]) color("green") turn_support_outer_end();
}





/*
mirror([0,1,0]) frame3Position() translate([0,10,0]) color("white") import("../stl/all_supports.stl", convexity=3);

turnNightyInsidePosition() color("white") import("../stl/turn_night_inside.stl", convexity=3);

mirror([0,1,0]) turnNightyInsidePosition() color("white") import("../stl/turn_night_inside.stl", convexity=3);

* turnNightyInsideFarEndPosition() color("blue") import("../stl/turn_night_inside.stl", convexity=3);
*/