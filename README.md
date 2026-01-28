# pIqaDHom - a pixel version of the klingon pIqaD font.

## Description
Monospace pixelated pIqaD font. I actually just wanted to create a pixelated font for use as a template in minecraft or r/places (or pixel-artboards) and somehow ended up making it an actual font. Contains the default known klingon glyphs aswell as some extra characters I have imagined: plus and minus sign, Darsek-sign, at-sign and percent sign which are ligatures of two pIqaD characters. These are not canon, though. As this font is public domain, feel free to edit them out if you don't want them

Dollar (Darsek)-Sign: letter D and S combined, for "DarSeq"

Percent Sign: Letter v and qaghwI' combined, for "vatlhwI'"

Plus sign: Letter b and q combined, for "boq"

minus sign: plus sign upside down, "boqHa'"

Tilde: Sideways qaghwI' lol. 

Underscore: ghargh, a long snake predatorily waiting to attack romuluSngan petaQ. :-)


It also features ligatures, so when you type "tlh", "ch", "ng" or "gh" it turns into the correct pIqaD character depending on where it is used.
I tested that feature in libreoffice, it works there no problem.

## Files
#### characters.xcf
contains the base characters which I had drawn while having insomnia :)
I then saved the characters as 8x8 png files (these aren't included)

#### convert.sh
simply converts the .png files to .svg. yes I know I could have saved them as svg in the first time, duh

#### glyphs.txt
maps glyph names (and filenames) to pIqaD characters (https://www.unicode.org/L2/L2016/16329-piqad-returns.pdf , https://www.evertype.com/standards/csur/klingon.html)

#### create_base.sh
creates the font without the ligatures yet, also maps them to their latin counterpart

#### add_features.py
adds ligatures for tlh, gh,...

#### pIqaDHom.ttf
the font. yISop!

#### (folder) svg
contains svg versions of the characters.


##  ! 
!   
