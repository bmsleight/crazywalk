#!/bin/bash
echo "Generate all of crazy walks parts."
date

# rm ./stl/*

# We need lots of these 


#!/bin/bash

for MIRROR in false true
do
    for PART in bearing_shell turn_support_inner_split_no_guide \
                turn_support_inner_split turn_support_outer_start \
                turn_support_outer_end
    do 
        openscad -o ./stl/${PART}_Mirror_${MIRROR}.stl -D 'part="'$PART'"' -D 'mirror='${MIRROR} ./crazywalk_parts_select_part.scad 
    done

    PART="support_base"
    for HEIGHTS in true false
    do
        for PIECE in {1..4}
        do 
            openscad -o ./stl/${PART}_${PIECE}_HEIGHTS_${HEIGHTS}_Mirror_${MIRROR}.stl -D 'part="'$PART'"' -D 'piece='$PIECE -D 'heights='${HEIGHTS} -D 'mirror='${MIRROR} ./crazywalk_parts_select_part.scad 
        done
    done
done

date
