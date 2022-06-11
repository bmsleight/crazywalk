#!/bin/bash
echo "Generate all of crazy walks parts."
date

# Remove old files as we need to mirror([0,1,0]) new files
echo "Remove old files."
rm ./SolidPython/openscadgenerated/*
rm ./stl/*


# Generate the supports support_base files 
echo "Run python crazywalk.py"
cd SolidPython
python crazywalk.py

cd ..

#Generating
echo "Generate - could take time"
for f in $( ls SolidPython/openscadgenerated/ ); do
	openscad -o ./stl/$f.stl SolidPython/openscadgenerated/$f
    done

#Mirror
echo "Generate - Mirror"
p=$(pwd)
for f in $( ls SolidPython/openscadgenerated/ ); do
    echo "mirror([0,1,0]) import(\""$p"/stl/"$f".stl\");" > SolidPython/openscadgenerated/${f}_mirror.scad
    done
for f in $( ls SolidPython/openscadgenerated/*_mirror.scad ); do
    filename=$(basename -- "$f")
	openscad -o ./stl/${filename}.stl $f
    done


openscad -o ./stl/all_supports.stl SolidPython/crazywalk.scad
 

# We need lots of these 
openscad -o ./stl/bearing_shell.scad.stl ./openscad/bearing_shell.scad

openscad -o ./stl/belt_connect.scad.stl ./openscad/belt_connect.scad

date
