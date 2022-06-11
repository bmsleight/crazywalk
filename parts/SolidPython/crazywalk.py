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

