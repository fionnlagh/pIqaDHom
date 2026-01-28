#!/bin/bash
# =============================================================================
# create_base.sh – creates base font from the svg files, maps them onto the letters defined in glyphs.txt and also on the latin ones
# =============================================================================

# (yes, this script was vibecoded. I initially didn't plan to release this but now I did.)
# for better reference on how to script for fontforge:
# https://fontforge.org/docs/scripting/scripting.html

cat << 'EOF' > create_base.py
import fontforge
import sys

font = fontforge.font()
font.fontname   = "pIqaDHom"
font.fullname   = "pIqaDHom"
font.familyname = "pIqaDHom mono"
font.comment    = "pIqaD Klingon 8x8 Font"
font.version    = "1.0"
font.copyright  = "Copyright © 2026 meQ Qentlh"

# Monospace

font.em = 1024
font.ascent = 704
font.descent = 320
font.hhea_ascent = font.ascent
font.hhea_descent = -font.descent
font.os2_typoascent = font.ascent
font.os2_typodescent = -font.descent
font.os2_winascent = font.ascent
font.os2_windescent = font.descent
font.os2_panose = (2, 0, 9, 3, 0, 0, 0, 0, 0, 0)

# =============================================================================
# Mapping: Latin → pIqaD-Glyph-name
# =============================================================================
mapping = {
    'a': 'tlh_a',    'A': 'tlh_a',
    'b': 'tlh_b',    'B': 'tlh_b',
    'c': 'tlh_ch',   'C': 'tlh_ch',
    'd': 'tlh_d',    'D': 'tlh_d',
    'e': 'tlh_e',    'E': 'tlh_e',
    'f': 'tlh_ng',   'F': 'tlh_ng',
    'g': 'tlh_gh',   'G': 'tlh_gh',
    'h': 'tlh_h',    'H': 'tlh_h',
    'i': 'tlh_i',    'I': 'tlh_i',
    'j': 'tlh_j',    'J': 'tlh_j',
    'k': 'tlh_q',    'K': 'tlh_q',
    'l': 'tlh_l',    'L': 'tlh_l',
    'm': 'tlh_m',    'M': 'tlh_m',
    'n': 'tlh_n',    'N': 'tlh_n',
    'o': 'tlh_o',    'O': 'tlh_o',
    'p': 'tlh_p',    'P': 'tlh_p',
    'q': 'tlh_q',    'Q': 'tlh_q_upper',
    'r': 'tlh_r',    'R': 'tlh_r',
    's': 'tlh_s',    'S': 'tlh_s',
    't': 'tlh_t',    'T': 'tlh_t',
    'u': 'tlh_u',    'U': 'tlh_u',
    'v': 'tlh_v',    'V': 'tlh_v',
    'w': 'tlh_w',    'W': 'tlh_w',
    'x': 'tlh_tlh',  'X': 'tlh_tlh',
    'y': 'tlh_y',    'Y': 'tlh_y',
    'z': 'tlh_glottal','Z': 'tlh_glottal',
    '0': 'tlh_0',
    '1': 'tlh_1',
    '2': 'tlh_2',
    '3': 'tlh_3',
    '4': 'tlh_4',
    '5': 'tlh_5',
    '6': 'tlh_6',
    '7': 'tlh_7',
    '8': 'tlh_8',
    '9': 'tlh_9',

    '.': 'tlh_period',
    ',': 'tlh_comma',
    '`': 'tlh_glottal',
    '\'': 'tlh_glottal',

    '~': 'tlh_dash',
    '$': 'tlh_dollar',
    '%': 'tlh_percent',
    '+': 'tlh_plus',
    '-': 'tlh_minus',
    '=': 'tlh_equals',
    '_': 'tlh_underscore',
    ':': 'tlh_comma',
    ';': 'tlh_period',
    '@': 'tlh_at',
    '*': 'tlh_mummification',


}

# =============================================================================
# PUA-Glyphs
# =============================================================================
imported_count = 0
with open('glyphs.txt', 'r') as f:
    for line in f:
        line = line.split('#')[0].strip()
        if not line:
            continue
        parts = line.split()
        if len(parts) != 2:
            print(f"ngoq ghenHa' jIruchbe': {line}")
            continue

        name, hex_code_str = parts
        
        try:
            codepoint = int(hex_code_str, 16)
        except ValueError:
            print(f"wa'maH jav Sep'egh ngoq ghenHa': {hex_code_str}")
            continue

        glyph = font.createChar(codepoint, name)
        svg_path = f"{name}.svg"

        try:
            glyph.importOutlines(svg_path)
            # Calculate bounding box and transform
            bbox = glyph.boundingBox()
            if bbox:
                left, bottom, right, top = bbox
                width = right - left
                height = top - bottom
                
                # Centering where needed
                if name in ['tlh_glottal']:  # Glottal stop on the top. the new klingon rap.
                    shift_x = 0
                    shift_y = -bottom + 500 
                elif name in ['tlh_0']:  # zero is middle
                    shift_x = 0
                    shift_y = -bottom + 350 
                elif name in ['tlh_dash']:  #  sideways qaghwi
                    shift_x = 0
                    shift_y = -bottom + 300 
                else:
                    shift_x = -left + (1024 - width) / 2
                    shift_y = -bottom + 0 
                
                glyph.transform([1, 0, 0, 1, shift_x, shift_y])  # move
                glyph.width = 1024
                print(f"vIHta': {name}  shift_x={shift_x:.1f}  shift_y={shift_y:.1f}")
            glyph.simplify()
            glyph.round()
            imported_count += 1
            print(f"chelta': {name} (U+{codepoint:04X}) ← {svg_path}")
        except Exception as e:
            print(f"Qagh: {svg_path}: {e}")

# =============================================================================
# copy pIqaD to the latin characters (XIFAN)
# =============================================================================
latin_count = 0
glyph_names_lower = {}
for glyph in font.glyphs():
    name = glyph.glyphname
    glyph_names_lower[name.lower()] = name

for latin_name, expected_piqad_name in mapping.items():
    expected_lower = expected_piqad_name.lower()
    if expected_lower in glyph_names_lower:
        real_name = glyph_names_lower[expected_lower]
        
        latin_glyph = font.createChar(ord(latin_name), latin_name)
        latin_glyph.clear() 
        
        latin_glyph.addReference(real_name)
        
        latin_glyph.unlinkRef() 
        latin_glyph.build()  
       
        latin_glyph.width = 1024   # Monospace
        
        latin_count += 1
        print(f"Latin mapped: {latin_name} ← {real_name}")
    else:
        print(f"Warning: no glyph found for '{expected_piqad_name}' – {latin_name} stays empty")
# Space
space = font.createChar(0x0020, "space")
space.width = 1024

total_glyphs = len(list(font.glyphs()))

print(f"\nSummary:")
print(f"  Importierted PUA-Glyphs: {imported_count}")
print(f"  Mapped Latin-glyphs: {latin_count}")
print(f"  Total glyphs: {total_glyphs}")

font.generate('pIqaDHom-Basis.ttf')
print("\nBase-font created: pIqaDHom-Basis.ttf")
print("→ run python ./add_features.py to add ligatures for tlh, gh, ch.")
EOF

fontforge -script create_base.py

echo ""
echo "pItlh."
echo "Qapla'!"
