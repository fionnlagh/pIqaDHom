# add_features.py – adds ligatures. 
from fontTools.ttLib import TTFont
from fontTools.feaLib.builder import addOpenTypeFeaturesFromString

font = TTFont("pIqaDHom-Basis.ttf")

# Features as .fea-String
fea_content = """
languagesystem DFLT dflt;
languagesystem latn dflt;

feature liga {
    sub t l h by tlh_tlh;
    sub T l h by tlh_tlh;
    sub t L h by tlh_tlh;
    sub t l H by tlh_tlh;
    sub T L h by tlh_tlh;
    sub t L H by tlh_tlh;
    sub T l H by tlh_tlh;
    sub T L H by tlh_tlh;
    sub g h    by tlh_gh;
    sub c h    by tlh_ch;
    sub n g    by tlh_ng;
    sub G h    by tlh_gh;
    sub C h    by tlh_ch;
    sub N g    by tlh_ng;
    sub g H    by tlh_gh;
    sub c H    by tlh_ch;
    sub n G    by tlh_ng;
    sub G H    by tlh_gh;
    sub C H    by tlh_ch;
    sub N G    by tlh_ng;
    sub tlh_t tlh_l tlh_h by tlh_tlh;
    sub tlh_gh tlh_h    by tlh_gh;
    sub tlh_ch tlh_h    by tlh_ch;
    sub tlh_n tlh_gh    by tlh_ng;
} liga;

feature calt {
    sub t l h by tlh_tlh;
    sub T l h by tlh_tlh;
    sub t L h by tlh_tlh;
    sub t l H by tlh_tlh;
    sub T L h by tlh_tlh;
    sub t L H by tlh_tlh;
    sub T l H by tlh_tlh;
    sub T L H by tlh_tlh;
    sub g h    by tlh_gh;
    sub c h    by tlh_ch;
    sub n g    by tlh_ng;
    sub G h    by tlh_gh;
    sub C h    by tlh_ch;
    sub N g    by tlh_ng;
    sub g H    by tlh_gh;
    sub c H    by tlh_ch;
    sub n G    by tlh_ng;
    sub G H    by tlh_gh;
    sub C H    by tlh_ch;
    sub N G    by tlh_ng;
    sub tlh_t tlh_l tlh_h by tlh_tlh;
    sub tlh_gh tlh_h    by tlh_gh;
    sub tlh_ch tlh_h    by tlh_ch;
    sub tlh_n tlh_gh    by tlh_ng;
} calt;


"""

# Insert features
addOpenTypeFeaturesFromString(font, fea_content)

# Save
font.save("pIqaDHom-Final.ttf")
print("Saved font with featurss: pIqaDHom-Final.ttf")
