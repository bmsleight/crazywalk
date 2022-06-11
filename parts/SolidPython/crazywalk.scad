// Generated by SolidPython 1.1.1 on 2022-06-07 22:05:47
$fn = 48;
use </home/bms/crazywalk/parts/SolidPython/../openscad/belt.scad>
use </home/bms/crazywalk/parts/SolidPython/../openscad/bearing.scad>


union() {
	union() {
		translate(v = [45.0000000000, 0, 6.7600000000]) {
			ball_bearing();
		}
		translate(v = [45.0000000000, 0, 6.7600000000]) {
			color(alpha = 1.0000000000, c = "#B2997E") {
				bearing_shell();
			}
		}
		translate(v = [-45.0000000000, 0, 0]) {
			color(alpha = 1.0000000000, c = "#DBC8BD") {
				union() {
					translate(v = [90.0000000000, 0, 0]) {
						support_base(connector = 1, height_c = 9.7600000000, length_c = 45.0000000000, text = "2");
					}
				}
			}
		}
		translate(v = [90.0000000000, 0, 4.6225000000]) {
			ball_bearing();
		}
		translate(v = [90.0000000000, 0, 4.6225000000]) {
			color(alpha = 1.0000000000, c = "#98BCA6") {
				bearing_shell();
			}
		}
		translate(v = [135.0000000000, 0, 2.8900000000]) {
			ball_bearing();
		}
		translate(v = [135.0000000000, 0, 2.8900000000]) {
			color(alpha = 1.0000000000, c = "#6DAECF") {
				bearing_shell();
			}
		}
		translate(v = [180.0000000000, 0, 1.5625000000]) {
			ball_bearing();
		}
		translate(v = [180.0000000000, 0, 1.5625000000]) {
			color(alpha = 1.0000000000, c = "#A7B8A6") {
				bearing_shell();
			}
		}
		translate(v = [90.0000000000, 0, 0]) {
			color(alpha = 1.0000000000, c = "#EFB1A3") {
				union() {
					translate(v = [0.0000000000, 0, 0]) {
						support_base(connector = 0, height_c = 7.6225000000, length_c = 45.0000000000, text = "3");
					}
					translate(v = [45.0000000000, 0, 0]) {
						support_base(connector = 0, height_c = 5.8900000000, length_c = 45.0000000000, text = "4");
					}
					translate(v = [90.0000000000, 0, 0]) {
						support_base(connector = 1, height_c = 4.5625000000, length_c = 45.0000000000, text = "5");
					}
				}
			}
		}
		translate(v = [225.0000000000, 0, 0.6400000000]) {
			ball_bearing();
		}
		translate(v = [225.0000000000, 0, 0.6400000000]) {
			color(alpha = 1.0000000000, c = "#DEA9EA") {
				bearing_shell();
			}
		}
		translate(v = [270.0000000000, 0, 0.1225000000]) {
			ball_bearing();
		}
		translate(v = [270.0000000000, 0, 0.1225000000]) {
			color(alpha = 1.0000000000, c = "#C8C18E") {
				bearing_shell();
			}
		}
		translate(v = [315.0000000000, 0, 0.0100000000]) {
			ball_bearing();
		}
		translate(v = [315.0000000000, 0, 0.0100000000]) {
			color(alpha = 1.0000000000, c = "#70FBF9") {
				bearing_shell();
			}
		}
		translate(v = [225.0000000000, 0, 0]) {
			color(alpha = 1.0000000000, c = "#7D8798") {
				union() {
					translate(v = [0.0000000000, 0, 0]) {
						support_base(connector = 0, height_c = 3.6400000000, length_c = 45.0000000000, text = "6");
					}
					translate(v = [45.0000000000, 0, 0]) {
						support_base(connector = 0, height_c = 3.1225000000, length_c = 45.0000000000, text = "7");
					}
					translate(v = [90.0000000000, 0, 0]) {
						support_base(connector = 1, height_c = 3.0100000000, length_c = 45.0000000000, text = "8");
					}
				}
			}
		}
		translate(v = [360.0000000000, 0, 0.3025000000]) {
			ball_bearing();
		}
		translate(v = [360.0000000000, 0, 0.3025000000]) {
			color(alpha = 1.0000000000, c = "#6B6DEB") {
				bearing_shell();
			}
		}
		translate(v = [405.0000000000, 0, 1.0000000000]) {
			ball_bearing();
		}
		translate(v = [405.0000000000, 0, 1.0000000000]) {
			color(alpha = 1.0000000000, c = "#E471CC") {
				bearing_shell();
			}
		}
		translate(v = [450.0000000000, 0, 2.1025000000]) {
			ball_bearing();
		}
		translate(v = [450.0000000000, 0, 2.1025000000]) {
			color(alpha = 1.0000000000, c = "#81EA7A") {
				bearing_shell();
			}
		}
		translate(v = [360.0000000000, 0, 0]) {
			color(alpha = 1.0000000000, c = "#73C0F5") {
				union() {
					translate(v = [0.0000000000, 0, 0]) {
						support_base(connector = 0, height_c = 3.3025000000, length_c = 45.0000000000, text = "9");
					}
					translate(v = [45.0000000000, 0, 0]) {
						support_base(connector = 0, height_c = 4.0000000000, length_c = 45.0000000000, text = "A");
					}
					translate(v = [90.0000000000, 0, 0]) {
						support_base(connector = 1, height_c = 5.1025000000, length_c = 45.0000000000, text = "B");
					}
				}
			}
		}
		translate(v = [495.0000000000, 0, 3.6100000000]) {
			ball_bearing();
		}
		translate(v = [495.0000000000, 0, 3.6100000000]) {
			color(alpha = 1.0000000000, c = "#FFF282") {
				bearing_shell();
			}
		}
		translate(v = [540.0000000000, 0, 5.5225000000]) {
			ball_bearing();
		}
		translate(v = [540.0000000000, 0, 5.5225000000]) {
			color(alpha = 1.0000000000, c = "#81F4A3") {
				bearing_shell();
			}
		}
		translate(v = [585.0000000000, 0, 7.8400000000]) {
			ball_bearing();
		}
		translate(v = [585.0000000000, 0, 7.8400000000]) {
			color(alpha = 1.0000000000, c = "#D0A8F9") {
				bearing_shell();
			}
		}
		translate(v = [495.0000000000, 0, 0]) {
			color(alpha = 1.0000000000, c = "#F281CF") {
				union() {
					translate(v = [0.0000000000, 0, 0]) {
						support_base(connector = 0, height_c = 6.6100000000, length_c = 45.0000000000, text = "C");
					}
					translate(v = [45.0000000000, 0, 0]) {
						support_base(connector = 0, height_c = 8.5225000000, length_c = 45.0000000000, text = "D");
					}
					translate(v = [90.0000000000, 0, 0]) {
						support_base(connector = 1, height_c = 10.8400000000, length_c = 45.0000000000, text = "E");
					}
				}
			}
		}
		translate(v = [630.0000000000, 0, 10.5625000000]) {
			ball_bearing();
		}
		translate(v = [630.0000000000, 0, 10.5625000000]) {
			color(alpha = 1.0000000000, c = "#A1D37C") {
				bearing_shell();
			}
		}
		translate(v = [675.0000000000, 0, 13.6900000000]) {
			ball_bearing();
		}
		translate(v = [675.0000000000, 0, 13.6900000000]) {
			color(alpha = 1.0000000000, c = "#7C94DB") {
				bearing_shell();
			}
		}
		translate(v = [720.0000000000, 0, 17.2225000000]) {
			ball_bearing();
		}
		translate(v = [720.0000000000, 0, 17.2225000000]) {
			color(alpha = 1.0000000000, c = "#65B2C7") {
				bearing_shell();
			}
		}
		translate(v = [630.0000000000, 0, 0]) {
			color(alpha = 1.0000000000, c = "#A76783") {
				union() {
					translate(v = [0.0000000000, 0, 0]) {
						support_base(connector = 0, height_c = 13.5625000000, length_c = 45.0000000000, text = "F");
					}
					translate(v = [45.0000000000, 0, 0]) {
						support_base(connector = 0, height_c = 16.6900000000, length_c = 45.0000000000, text = "10");
					}
					translate(v = [90.0000000000, 0, 0]) {
						support_base(connector = 1, height_c = 20.2225000000, length_c = 45.0000000000, text = "11");
					}
				}
			}
		}
		translate(v = [765.0000000000, 0, 21.1600000000]) {
			ball_bearing();
		}
		translate(v = [765.0000000000, 0, 21.1600000000]) {
			color(alpha = 1.0000000000, c = "#7764EB") {
				bearing_shell();
			}
		}
		translate(v = [810.0000000000, 0, 25.5025000000]) {
			ball_bearing();
		}
		translate(v = [810.0000000000, 0, 25.5025000000]) {
			color(alpha = 1.0000000000, c = "#90E866") {
				bearing_shell();
			}
		}
		translate(v = [855.0000000000, 0, 30.2500000000]) {
			ball_bearing();
		}
		translate(v = [855.0000000000, 0, 30.2500000000]) {
			color(alpha = 1.0000000000, c = "#90EB65") {
				bearing_shell();
			}
		}
		translate(v = [765.0000000000, 0, 0]) {
			color(alpha = 1.0000000000, c = "#E4B96D") {
				union() {
					translate(v = [0.0000000000, 0, 0]) {
						support_base(connector = 0, height_c = 24.1600000000, length_c = 45.0000000000, text = "12");
					}
					translate(v = [45.0000000000, 0, 0]) {
						support_base(connector = 0, height_c = 28.5025000000, length_c = 45.0000000000, text = "13");
					}
					translate(v = [90.0000000000, 0, 0]) {
						support_base(connector = 1, height_c = 33.2500000000, length_c = 45.0000000000, text = "14");
					}
				}
			}
		}
		translate(v = [900.0000000000, 0, 35.4025000000]) {
			ball_bearing();
		}
		translate(v = [900.0000000000, 0, 35.4025000000]) {
			color(alpha = 1.0000000000, c = "#D0B9DD") {
				bearing_shell();
			}
		}
		translate(v = [945.0000000000, 0, 40.9600000000]) {
			ball_bearing();
		}
		translate(v = [945.0000000000, 0, 40.9600000000]) {
			color(alpha = 1.0000000000, c = "#97E8F3") {
				bearing_shell();
			}
		}
		translate(v = [990.0000000000, 0, 46.9225000000]) {
			ball_bearing();
		}
		translate(v = [990.0000000000, 0, 46.9225000000]) {
			color(alpha = 1.0000000000, c = "#7CA3E2") {
				bearing_shell();
			}
		}
		translate(v = [900.0000000000, 0, 0]) {
			color(alpha = 1.0000000000, c = "#97E2CD") {
				union() {
					translate(v = [0.0000000000, 0, 0]) {
						support_base(connector = 0, height_c = 38.4025000000, length_c = 45.0000000000, text = "15");
					}
					translate(v = [45.0000000000, 0, 0]) {
						support_base(connector = 0, height_c = 43.9600000000, length_c = 45.0000000000, text = "16");
					}
					translate(v = [90.0000000000, 0, 0]) {
						support_base(connector = 1, height_c = 49.9225000000, length_c = 45.0000000000, text = "17");
					}
				}
			}
		}
		translate(v = [1035.0000000000, 0, 53.2900000000]) {
			ball_bearing();
		}
		translate(v = [1035.0000000000, 0, 53.2900000000]) {
			color(alpha = 1.0000000000, c = "#EFF575") {
				bearing_shell();
			}
		}
		translate(v = [1080.0000000000, 0, 60.0625000000]) {
			ball_bearing();
		}
		translate(v = [1080.0000000000, 0, 60.0625000000]) {
			color(alpha = 1.0000000000, c = "#DF96C0") {
				bearing_shell();
			}
		}
		translate(v = [1125.0000000000, 0, 67.2400000000]) {
			ball_bearing();
		}
		translate(v = [1125.0000000000, 0, 67.2400000000]) {
			color(alpha = 1.0000000000, c = "#CBCAD2") {
				bearing_shell();
			}
		}
		translate(v = [1035.0000000000, 0, 0]) {
			color(alpha = 1.0000000000, c = "#D8ED7F") {
				union() {
					translate(v = [0.0000000000, 0, 0]) {
						support_base(connector = 0, height_c = 56.2900000000, length_c = 45.0000000000, text = "18");
					}
					translate(v = [45.0000000000, 0, 0]) {
						support_base(connector = 0, height_c = 63.0625000000, length_c = 45.0000000000, text = "19");
					}
					translate(v = [90.0000000000, 0, 0]) {
						support_base(connector = 1, height_c = 70.2400000000, length_c = 45.0000000000, text = "1A");
					}
				}
			}
		}
		translate(v = [1170.0000000000, 0, 74.8225000000]) {
			ball_bearing();
		}
		translate(v = [1170.0000000000, 0, 74.8225000000]) {
			color(alpha = 1.0000000000, c = "#ED7CAD") {
				bearing_shell();
			}
		}
		translate(v = [1215.0000000000, 0, 82.8100000000]) {
			ball_bearing();
		}
		translate(v = [1215.0000000000, 0, 82.8100000000]) {
			color(alpha = 1.0000000000, c = "#A772AD") {
				bearing_shell();
			}
		}
		translate(v = [1260.0000000000, 0, 91.2025000000]) {
			ball_bearing();
		}
		translate(v = [1260.0000000000, 0, 91.2025000000]) {
			color(alpha = 1.0000000000, c = "#CD7176") {
				bearing_shell();
			}
		}
		translate(v = [1170.0000000000, 0, 0]) {
			color(alpha = 1.0000000000, c = "#C37166") {
				union() {
					translate(v = [0.0000000000, 0, 0]) {
						support_base(connector = 0, height_c = 77.8225000000, length_c = 45.0000000000, text = "1B");
					}
					translate(v = [45.0000000000, 0, 0]) {
						support_base(connector = 0, height_c = 85.8100000000, length_c = 45.0000000000, text = "1C");
					}
					translate(v = [90.0000000000, 0, 0]) {
						support_base(connector = 1, height_c = 94.2025000000, length_c = 45.0000000000, text = "1D");
					}
				}
			}
		}
	}
	union() {
		translate(v = [1400, 0, 0]) {
			rotate(a = [0, 45, 0]) {
				turn_nighty_bearing(diameter_turn = 320, notch_h = 100);
			}
		}
		translate(v = [0, 0, 0]) {
			rotate(a = [0, -45, 0]) {
				turn_nighty_bearing_start(diameter_turn = 320, notch_h = 10);
			}
		}
	}
	union() {
		translate(v = [0, 30, 34.7500000000]) {
			rotate(a = [0, 3.4168533669, 0]) {
				belt_connect_assembley(move = 1);
			}
		}
		translate(v = [104, 30, 28.5516000000]) {
			rotate(a = [0, 2.2236344080, 0]) {
				belt_connect_assembley(move = 1);
			}
		}
		translate(v = [208, 30, 24.5164000000]) {
			rotate(a = [0, 1.0313797309, 0]) {
				belt_connect_assembley(move = 1);
			}
		}
		translate(v = [312, 30, 22.6444000000]) {
			rotate(a = [0, -0.1604283923, 0]) {
				belt_connect_assembley(move = 1);
			}
		}
		translate(v = [416, 30, 22.9356000000]) {
			rotate(a = [0, -1.3523059464, 0]) {
				belt_connect_assembley(move = 1);
			}
		}
		translate(v = [520, 30, 25.3900000000]) {
			rotate(a = [0, -2.5447691872, 0]) {
				belt_connect_assembley(move = 1);
			}
		}
		translate(v = [624, 30, 30.0076000000]) {
			rotate(a = [0, -3.7383366579, 0]) {
				belt_connect_assembley(move = 1);
			}
		}
		translate(v = [728, 30, 36.7884000000]) {
			rotate(a = [0, -4.9335312301, 0]) {
				belt_connect_assembley(move = 1);
			}
		}
		translate(v = [832, 30, 45.7324000000]) {
			rotate(a = [0, -6.1308821931, 0]) {
				belt_connect_assembley(move = 1);
			}
		}
		translate(v = [936, 30, 56.8396000000]) {
			rotate(a = [0, -7.3309274136, 0]) {
				belt_connect_assembley(move = 1);
			}
		}
		translate(v = [1040, 30, 70.1100000000]) {
			rotate(a = [0, -8.5342155905, 0]) {
				belt_connect_assembley(move = 1);
			}
		}
		translate(v = [1144, 30, 85.5436000000]) {
			rotate(a = [0, -9.7413086345, 0]) {
				belt_connect_assembley(move = 1);
			}
		}
	}
}
/***********************************************
*********      SolidPython code:      **********
************************************************
 
#! /usr/bin/env python3

from solid import *
import random, math
bearing = import_scad('../openscad/bearing.scad')
belt = import_scad('../openscad/belt.scad')

SEGMENTS = 48

outline_x = 640
outline_y = 1400
outline_z = 400


slat_width = 90;
ball_interval = slat_width/2
diameter_turn = 320
slat_width_with_holder = 104;


parts_max_multiples_of_interval = 3

def zfromy(y):
    z = (y-outline_y*0.25)*(y-outline_y*0.25)/10000
    return z

def ballYZ(position, interval = ball_interval):
    y = interval * position
    z = zfromy(y)
    return y,z


def random_color():
    rand = lambda: random.randint(100, 255)
    return '#%02X%02X%02X' % (rand(), rand(), rand())

def maxPosition(interval = ball_interval):
    return int(outline_y / interval)-1

def maxPositionBelt():
    return int(outline_y / slat_width_with_holder)-1
    
def lowestBall():
    (y, low_z) = ballYZ(0)
    position = 0
    for i in range(1, maxPosition() ):
        (y,z) = ballYZ(i)
        if z<low_z:
            low_z = z
            position = i
        print(i,y,z)
    return position


def base_holder_all():
    a = union();
    p = []
    p.append(a)
    connected_parts = int((maxPosition()+2) % parts_max_multiples_of_interval)
    unconnected_parts=union()
    for i in range(2, maxPosition()):
        (y,z) = ballYZ(i)
        if(connected_parts==parts_max_multiples_of_interval-1):
            connector=1
        elif(i==maxPosition()-1):
            connector=1      
        else:
            connector=0

        support_base = bearing.support_base(height_c=z+3, length_c=ball_interval, connector=connector, text= hex(i)[2:].upper() )
        unconnected_parts = unconnected_parts + translate([ball_interval*connected_parts,0,0])(support_base)
        connected_parts = connected_parts + 1
        
        a = a + translate([(i-1)*ball_interval,0,z])(bearing.ball_bearing())
        a = a + translate([(i-1)*ball_interval,0,z])(color(random_color())(bearing.bearing_shell()))
        if(connected_parts==parts_max_multiples_of_interval or i==maxPosition()-1):
            new_p = color(random_color())(unconnected_parts)
            p.append(new_p)
            a = a + translate([ (i-connected_parts)*ball_interval,0,0 ])(new_p)
            unconnected_parts=union()
            connected_parts = 0
    return (a, p)




def turn_nighty_all():
    a = union();
    p = []
    tn = bearing.turn_nighty_bearing(diameter_turn=diameter_turn, notch_h=100)
    p.append(tn)
    a = a + translate([outline_y,0,0])(rotate([0,45,0])(tn))
    tn = bearing.turn_nighty_bearing_start(diameter_turn=diameter_turn, notch_h=10)
    a = a + translate([0,0,0])(rotate([0,-45,0])(tn))
    p.append(tn)

    #outline_y
    #//rotate([0,45,0]) turn_nighty_bearing();
    return (a, p)




def build(section, assembly, prints):
    (add_assembly,new_prints) = section()
    prints = prints + new_prints
    assembly =  assembly + add_assembly
    return (assembly, prints)

def assembly():
    assembly = union()
    prints = []
    (assembly, prints) = build(base_holder_all, assembly, prints)
    (assembly, prints) = build(turn_nighty_all, assembly, prints)
    return (assembly, prints)

def assembly_belt():
    assembly = union()
    # maxPositionBelt():
    for i in range(0, maxPosition(interval=slat_width_with_holder)):
        (y2,z2) = ballYZ(i+1,interval=slat_width_with_holder)
        (y,z) = ballYZ(i,interval=slat_width_with_holder)
        deg = math.degrees(math.asin((z2-z)/slat_width_with_holder))
        assembly = assembly + translate([(i)*slat_width_with_holder,30,z+22.5])(rotate([0,-deg,0])(belt.belt_connect_assembley(move=1)))
        print(z)
    print(assembly)
    return assembly

if __name__ == '__main__':
    (assembly, prints) = assembly()
    print(assembly, prints)
    lowestBall()
    
    i = 0
    for aprint in prints:
        i += 1
        scad_render_to_file(aprint, "openscadgenerated/support_base_" + str(i) + ".scad", file_header=f'$fn = {SEGMENTS};', include_orig_code=False)

    assembly = assembly + assembly_belt()
    scad_render_to_file(assembly, file_header=f'$fn = {SEGMENTS};', include_orig_code=True)

 
 
************************************************/
