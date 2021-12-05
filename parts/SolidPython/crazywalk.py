#! /usr/bin/env python3

from solid import *
import random
bearing = import_scad('../openscad/bearing.scad')

SEGMENTS = 48

outline_x = 640
outline_y = 1400
outline_z = 400
outline_ball_lowest = outline_z - 140

slat_width = 100;
ball_interval = slat_width/2;


parts_max_multiples_of_interval = 3

def ballYZ(position):
    y = ball_interval * position
    z = (y-outline_y*0.25)*(y-outline_y*0.25)/10000
    return y,z

def random_color():
    rand = lambda: random.randint(100, 255)
    return '#%02X%02X%02X' % (rand(), rand(), rand())

def maxPosition():
    return int(outline_y / ball_interval)
    
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
    connected_parts = int(0)
    unconnected_parts=union()
    for i in range(1, maxPosition() ):
        (y,z) = ballYZ(i)
        if(connected_parts==parts_max_multiples_of_interval-1):
            connector=1
        else:
            connector=0
        support_base = bearing.support_base(height_c=z+3, length_c=ball_interval, connector=connector, text= hex(i)[2:].upper() )
        unconnected_parts = unconnected_parts + translate([ball_interval*connected_parts,0,0])(support_base)
        connected_parts = connected_parts + 1
        
        a = a + translate([(i-1)*ball_interval,0,z])(bearing.ball_bearing())
        a = a + translate([(i-1)*ball_interval,0,z])(color(random_color())(bearing.bearing_shell()))
        
        if(connected_parts==parts_max_multiples_of_interval or i==maxPosition()):
            new_p = color(random_color())(unconnected_parts)
            p.append(new_p)
            a = a + translate([ (i-connected_parts)*ball_interval,0,0 ])(new_p)
            unconnected_parts=union()
            connected_parts = 0
    return (a, p)




def base_holder_height(height=0):
    a = union() + bearing.support_base(height_c=100);
    p = []
    p.append(a)
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
    return (assembly, prints)


if __name__ == '__main__':
    (assembly, prints) = assembly()
    print(assembly, prints)
    lowestBall()
    
    scad_render_to_file(assembly, file_header=f'$fn = {SEGMENTS};', include_orig_code=True)
    i = 0
    for aprint in prints:
        i += 1
        scad_render_to_file(aprint, "openscadgenerated/prints_" + str(i) + ".scad", file_header=f'$fn = {SEGMENTS};', include_orig_code=False)
