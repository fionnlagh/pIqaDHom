#! /bin/bash
# takes glyphs in .png format, converts them to svg. Note that the names of the png files must match glyphs.txt
for file in *.png; do
  scaled="${file%.png}_scaled.bmp"
  svg="${file%.png}.svg"
  convert "$file" -filter box -resize 1200% "$scaled" 
  potrace -s -a 1 "$scaled" -o "$svg"  
  rm "$scaled"  
done
