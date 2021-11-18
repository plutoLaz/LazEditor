{
  http://de.wikipedia.org/wiki/Webfarben
  http://www.uni-magdeburg.de/counter/rgb.txt.shtml
  http://chat.internetworx.de/help/Farbtabelle.html
  http://www.drweb.de/ressourcen/farbnamen.shtml

  Autor   : Michael Springwald
  Erstellt: unbekannt
  Updates : Montag, 16.Juli.2007, Freitag, 20.Juli.2007
            Samstag, 21.Juli.2007
  -----------------------------------------------------------------
  Stellt mehr(649) Farben zu verfügung !
  
  Ich habe die internet seite:
  http://www.uni-magdeburg.de/counter/rgb.txt.shtml
  runtergeladen un gepasst und damit diese Liste erstellt.

  Sie Stellt die Funktionen/Proceduren:
  -----------------------------------------------------------------
  procedure ColorToStringList(var StringList:TStrings);
  Füllt die Angebe StringList Komplet mit den Neuen Farben
  Dabei werden nur die Farbnamen zurück geben.

  Später sollte hierauch noch der Farb Wert zurück geben werden können
  bzw. Beide.
  -----------------------------------------------------------------

  Wandelt einen Farbwert in einen String um.
  Berücksichtig allerdings die Neuen und die Alten Farben
  function Color2ToString(const Color:TColor;const isAltColor:Boolean = True):String;
  -----------------------------------------------------------------
  Wandelt einen String in einem TColor Wert um.
  Berücksichtig allerdings die Neuen und die Alten Farben

  function String2ToColor(const ColorStr:String; const isAltColor:Boolean = True):TColor;
  -----------------------------------------------------------------

  Gibt eine Zufallst Farbe aus einer angeben Liste oder aus TColors2
  Wenn ColorList Leer ist, wird aus Colors2 gewählt, dabei wird dann
  auch der Tolleranz Wert berücksichtig, der Wiederum
  wenn ColorList nicht leer ist nicht berücksichtig Wird.
  --------------------------------------------------------

  NoColor  : Gibt ein Farb wert an der nicht ausgewählt werden darf
  AutoClear: Löscht die Liste die die Häufigkeit der gewählten Farben
             minimieren sollte

  Tolleranzbereich:
  ist ein Wert von der die Farbe maximal abweichen darf

  function RandomColorList(ColorList:array of TColor; noColor:TColor = clNone; const AutoClear:Integer = 10; const TolleranzBereich:Integer = 10):TColor;
  --------------------------------------------------------
}
unit ucolorlist;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Graphics;

const
  pl_black=$00000000;
  pl_AliceBlue=$00FFF8F0;
  pl_BlueViolet=$00E22B8A;
  pl_CadetBlue=$00A09E5F;
  pl_CadetBlue1=$00FFF598;
  pl_CadetBlue2=$00EEE58E;
  pl_CadetBlue3=$00CDC57A;
  pl_CadetBlue4=$008B8653;
  pl_CornflowerBlue=$00ED9564;
  pl_DarkSlateBlue=$008B3D48;
  pl_DarkTurquoise=$00D1CE00;
  pl_DeepSkyBlue=$00FFBF00;
  pl_DeepSkyBlue1=$00FFBF00;
  pl_DeepSkyBlue2=$00EEB200;
  pl_DeepSkyBlue3=$00CD9A00;
  pl_DeepSkyBlue4=$008B6800;
  pl_DodgerBlue=$00FF901E;
  pl_DodgerBlue1=$00FF901E;
  pl_DodgerBlue2=$00EE861C;
  pl_DodgerBlue3=$00CD7418;
  pl_DodgerBlue4=$008B4E10;
  pl_LightBlue=$00E6D8AD;
  pl_LightBlue1=$00FFEFBF;
  pl_LightBlue2=$00EEDFB2;
  pl_LightBlue3=$00CDC09A;
  pl_LightBlue4=$008B8368;
  pl_LightCyan=$00FFFFE0;
  pl_LightCyan1=$00FFFFE0;
  pl_LightCyan2=$00EEEED1;
  pl_LightCyan3=$00CDCDB4;
  pl_LightCyan4=$008B8B7A;
  pl_LightSkyBlue=$00FACE87;
  pl_LightSkyBlue1=$00FFE2B0;
  pl_LightSkyBlue2=$00EED3A4;
  pl_LightSkyBlue3=$00CDB68D;
  pl_LightSkyBlue4=$008B7B60;
  pl_LightSlateBlue=$00FF7084;
  pl_LightSteelBlue=$00DEC4B0;
  pl_LightSteelBlue1=$00FFE1CA;
  pl_LightSteelBlue2=$00EED2BC;
  pl_LightSteelBlue3=$00CDB5A2;
  pl_LightSteelBlue4=$008B7B6E;
  pl_MediumAquamarine=$00AACD66;
  pl_MediumBlue=$00CD0000;
  pl_MediumSlateBlue=$00EE687B;
  pl_MediumTurquoise=$00CCD148;
  pl_MidnightBlue=$00701919;
  pl_NavyBlue=$00800000;
  pl_PaleTurquoise=$00EEEEAF;
  pl_PaleTurquoise1=$00FFFFBB;
  pl_PaleTurquoise2=$00EEEEAE;
  pl_PaleTurquoise3=$00CDCD96;
  pl_PaleTurquoise4=$008B8B66;
  pl_PowderBlue=$00E6E0B0;
  pl_RoyalBlue=$00E16941;
  pl_RoyalBlue1=$00FF7648;
  pl_RoyalBlue2=$00EE6E43;
  pl_RoyalBlue3=$00CD5F3A;
  pl_RoyalBlue4=$008B4027;
  pl_SkyBlue=$00EBCE87;
  pl_SkyBlue1=$00FFCE87;
  pl_SkyBlue2=$00EEC07E;
  pl_SkyBlue3=$00CDA66C;
  pl_SkyBlue4=$008B704A;
  pl_SlateBlue=$00CD5A6A;
  pl_SlateBlue1=$00FF6F83;
  pl_SlateBlue2=$00EE677A;
  pl_SlateBlue3=$00CD5969;
  pl_SlateBlue4=$008B3C47;
  pl_SteelBlue=$00B48246;
  pl_SteelBlue1=$00FFB863;
  pl_SteelBlue2=$00EEAC5C;
  pl_SteelBlue3=$00CD944F;
  pl_SteelBlue4=$008B6436;
  pl_aquamarine=$00D4FF7F;
  pl_aquamarine1=$00D4FF7F;
  pl_aquamarine2=$00C6EE76;
  pl_aquamarine3=$00AACD66;
  pl_aquamarine4=$00748B45;
  pl_azure=$00FFFFF0;
  pl_azure1=$00FFFFF0;
  pl_azure2=$00EEEEE0;
  pl_azure3=$00CDCDC1;
  pl_azure4=$008B8B83;
  pl_blue=$00FF0000;
  pl_blue1=$00FF0000;
  pl_blue2=$00EE0000;
  pl_blue3=$00CD0000;
  pl_blue4=$008B0000;
  pl_cyan=$00FFFF00;
  pl_cyan1=$00FFFF00;
  pl_cyan2=$00EEEE00;
  pl_cyan3=$00CDCD00;
  pl_cyan4=$008B8B00;
  pl_navy=$00800000;
  pl_turquoise=$00D0E040;
  pl_turquoise1=$00FFF500;
  pl_turquoise2=$00EEE500;
  pl_turquoise3=$00CDC500;
  pl_turquoise4=$008B8600;
  pl_RosyBrown=$008F8FBC;
  pl_RosyBrown1=$00C1C1FF;
  pl_RosyBrown2=$00B4B4EE;
  pl_RosyBrown3=$009B9BCD;
  pl_RosyBrown4=$0069698B;
  pl_SaddleBrown=$0013458B;
  pl_SandyBrown=$0060A4F4;
  pl_beige=$00DCF5F5;
  pl_brown=$002A2AA5;
  pl_brown1=$004040FF;
  pl_brown2=$003B3BEE;
  pl_brown3=$003333CD;
  pl_brown4=$0023238B;
  pl_burlywood=$0087B8DE;
  pl_burlywood1=$009BD3FF;
  pl_burlywood2=$0091C5EE;
  pl_burlywood3=$007DAACD;
  pl_burlywood4=$0055738B;
  pl_chocolate=$001E69D2;
  pl_chocolate1=$00247FFF;
  pl_chocolate2=$002176EE;
  pl_chocolate3=$001D66CD;
  pl_chocolate4=$0013458B;
  pl_peru=$003F85CD;
  pl_tan=$008CB4D2;
  pl_tan1=$004FA5FF;
  pl_tan2=$00499AEE;
  pl_tan3=$003F85CD;
  pl_tan4=$002B5A8B;
  pl_DarkSlateGray=$004F4F2F;
  pl_DarkSlateGray1=$00FFFF97;
  pl_DarkSlateGray2=$00EEEE8D;
  pl_DarkSlateGray3=$00CDCD79;
  pl_DarkSlateGray4=$008B8B52;
  pl_DarkSlateGrey=$004F4F2F;
  pl_DimGray=$00696969;
  pl_DimGrey=$00696969;
  pl_LightGray=$00D3D3D3;
  pl_LightGrey=$00D3D3D3;
  pl_LightSlateGray=$00998877;
  pl_LightSlateGrey=$00998877;
  pl_SlateGray=$00908070;
  pl_SlateGray1=$00FFE2C6;
  pl_SlateGray2=$00EED3B9;
  pl_SlateGray3=$00CDB69F;
  pl_SlateGray4=$008B7B6C;
  pl_SlateGrey=$00908070;
  pl_gray=$00BEBEBE;
  pl_gray0=$00000000;
  pl_gray1=$00030303;
  pl_gray10=$001A1A1A;
  pl_gray100=$00FFFFFF;
  pl_gray11=$001C1C1C;
  pl_gray12=$001F1F1F;
  pl_gray13=$00212121;
  pl_gray14=$00242424;
  pl_gray15=$00262626;
  pl_gray16=$00292929;
  pl_gray17=$002B2B2B;
  pl_gray18=$002E2E2E;
  pl_gray19=$00303030;
  pl_gray2=$00050505;
  pl_gray20=$00333333;
  pl_gray21=$00363636;
  pl_gray22=$00383838;
  pl_gray23=$003B3B3B;
  pl_gray24=$003D3D3D;
  pl_gray25=$00404040;
  pl_gray26=$00424242;
  pl_gray27=$00454545;
  pl_gray28=$00474747;
  pl_gray29=$004A4A4A;
  pl_gray3=$00080808;
  pl_gray30=$004D4D4D;
  pl_gray31=$004F4F4F;
  pl_gray32=$00525252;
  pl_gray33=$00545454;
  pl_gray34=$00575757;
  pl_gray35=$00595959;
  pl_gray36=$005C5C5C;
  pl_gray37=$005E5E5E;
  pl_gray38=$00616161;
  pl_gray39=$00636363;
  pl_gray4=$000A0A0A;
  pl_gray40=$00666666;
  pl_gray41=$00696969;
  pl_gray42=$006B6B6B;
  pl_gray43=$006E6E6E;
  pl_gray44=$00707070;
  pl_gray45=$00737373;
  pl_gray46=$00757575;
  pl_gray47=$00787878;
  pl_gray48=$007A7A7A;
  pl_gray49=$007D7D7D;
  pl_gray5=$000D0D0D;
  pl_gray50=$007F7F7F;
  pl_gray51=$00828282;
  pl_gray52=$00858585;
  pl_gray53=$00878787;
  pl_gray54=$008A8A8A;
  pl_gray55=$008C8C8C;
  pl_gray56=$008F8F8F;
  pl_gray57=$00919191;
  pl_gray58=$00949494;
  pl_gray59=$00969696;
  pl_gray6=$000F0F0F;
  pl_gray60=$00999999;
  pl_gray61=$009C9C9C;
  pl_gray62=$009E9E9E;
  pl_gray63=$00A1A1A1;
  pl_gray64=$00A3A3A3;
  pl_gray65=$00A6A6A6;
  pl_gray66=$00A8A8A8;
  pl_gray67=$00ABABAB;
  pl_gray68=$00ADADAD;
  pl_gray69=$00B0B0B0;
  pl_gray7=$00121212;
  pl_gray70=$00B3B3B3;
  pl_gray71=$00B5B5B5;
  pl_gray72=$00B8B8B8;
  pl_gray73=$00BABABA;
  pl_gray74=$00BDBDBD;
  pl_gray75=$00BFBFBF;
  pl_gray76=$00C2C2C2;
  pl_gray77=$00C4C4C4;
  pl_gray78=$00C7C7C7;
  pl_gray79=$00C9C9C9;
  pl_gray8=$00141414;
  pl_gray80=$00CCCCCC;
  pl_gray81=$00CFCFCF;
  pl_gray82=$00D1D1D1;
  pl_gray83=$00D4D4D4;
  pl_gray84=$00D6D6D6;
  pl_gray85=$00D9D9D9;
  pl_gray86=$00DBDBDB;
  pl_gray87=$00DEDEDE;
  pl_gray88=$00E0E0E0;
  pl_gray89=$00E3E3E3;
  pl_gray9=$00171717;
  pl_gray90=$00E5E5E5;
  pl_gray91=$00E8E8E8;
  pl_gray92=$00EBEBEB;
  pl_gray93=$00EDEDED;
  pl_gray94=$00F0F0F0;
  pl_gray95=$00F2F2F2;
  pl_gray96=$00F5F5F5;
  pl_gray97=$00F7F7F7;
  pl_gray98=$00FAFAFA;
  pl_gray99=$00FCFCFC;
  pl_grey=$00BEBEBE;
  pl_grey0=$00000000;
  pl_grey1=$00030303;
  pl_grey10=$001A1A1A;
  pl_grey100=$00FFFFFF;
  pl_grey11=$001C1C1C;
  pl_grey12=$001F1F1F;
  pl_grey13=$00212121;
  pl_grey14=$00242424;
  pl_grey15=$00262626;
  pl_grey16=$00292929;
  pl_grey17=$002B2B2B;
  pl_grey18=$002E2E2E;
  pl_grey19=$00303030;
  pl_grey2=$00050505;
  pl_grey20=$00333333;
  pl_grey21=$00363636;
  pl_grey22=$00383838;
  pl_grey23=$003B3B3B;
  pl_grey24=$003D3D3D;
  pl_grey25=$00404040;
  pl_grey26=$00424242;
  pl_grey27=$00454545;
  pl_grey28=$00474747;
  pl_grey29=$004A4A4A;
  pl_grey3=$00080808;
  pl_grey30=$004D4D4D;
  pl_grey31=$004F4F4F;
  pl_grey32=$00525252;
  pl_grey33=$00545454;
  pl_grey34=$00575757;
  pl_grey35=$00595959;
  pl_grey36=$005C5C5C;
  pl_grey37=$005E5E5E;
  pl_grey38=$00616161;
  pl_grey39=$00636363;
  pl_grey4=$000A0A0A;
  pl_grey40=$00666666;
  pl_grey41=$00696969;
  pl_grey42=$006B6B6B;
  pl_grey43=$006E6E6E;
  pl_grey44=$00707070;
  pl_grey45=$00737373;
  pl_grey46=$00757575;
  pl_grey47=$00787878;
  pl_grey48=$007A7A7A;
  pl_grey49=$007D7D7D;
  pl_grey5=$000D0D0D;
  pl_grey50=$007F7F7F;
  pl_grey51=$00828282;
  pl_grey52=$00858585;
  pl_grey53=$00878787;
  pl_grey54=$008A8A8A;
  pl_grey55=$008C8C8C;
  pl_grey56=$008F8F8F;
  pl_grey57=$00919191;
  pl_grey58=$00949494;
  pl_grey59=$00969696;
  pl_grey6=$000F0F0F;
  pl_grey60=$00999999;
  pl_grey61=$009C9C9C;
  pl_grey62=$009E9E9E;
  pl_grey63=$00A1A1A1;
  pl_grey64=$00A3A3A3;
  pl_grey65=$00A6A6A6;
  pl_grey66=$00A8A8A8;
  pl_grey67=$00ABABAB;
  pl_grey68=$00ADADAD;
  pl_grey69=$00B0B0B0;
  pl_grey7=$00121212;
  pl_grey70=$00B3B3B3;
  pl_grey71=$00B5B5B5;
  pl_grey72=$00B8B8B8;
  pl_grey73=$00BABABA;
  pl_grey74=$00BDBDBD;
  pl_grey75=$00BFBFBF;
  pl_grey76=$00C2C2C2;
  pl_grey77=$00C4C4C4;
  pl_grey78=$00C7C7C7;
  pl_grey79=$00C9C9C9;
  pl_grey8=$00141414;
  pl_grey80=$00CCCCCC;
  pl_grey81=$00CFCFCF;
  pl_grey82=$00D1D1D1;
  pl_grey83=$00D4D4D4;
  pl_grey84=$00D6D6D6;
  pl_grey85=$00D9D9D9;
  pl_grey86=$00DBDBDB;
  pl_grey87=$00DEDEDE;
  pl_grey88=$00E0E0E0;
  pl_grey89=$00E3E3E3;
  pl_grey9=$00171717;
  pl_grey90=$00E5E5E5;
  pl_grey91=$00E8E8E8;
  pl_grey92=$00EBEBEB;
  pl_grey93=$00EDEDED;
  pl_grey94=$00F0F0F0;
  pl_grey95=$00F2F2F2;
  pl_grey96=$00F5F5F5;
  pl_grey97=$00F7F7F7;
  pl_grey98=$00FAFAFA;
  pl_grey99=$00FCFCFC;
  pl_DarkGreen=$00006400;
  pl_DarkKhaki=$006BB7BD;
  pl_DarkOliveGreen=$002F6B55;
  pl_DarkOliveGreen1=$0070FFCA;
  pl_DarkOliveGreen2=$0068EEBC;
  pl_DarkOliveGreen3=$005ACDA2;
  pl_DarkOliveGreen4=$003D8B6E;
  pl_DarkSeaGreen=$008FBC8F;
  pl_DarkSeaGreen1=$00C1FFC1;
  pl_DarkSeaGreen2=$00B4EEB4;
  pl_DarkSeaGreen3=$009BCD9B;
  pl_DarkSeaGreen4=$00698B69;
  pl_ForestGreen=$00228B22;
  pl_GreenYellow=$002FFFAD;
  pl_LawnGreen=$0000FC7C;
  pl_LightSeaGreen=$00AAB220;
  pl_LimeGreen=$0032CD32;
  pl_MediumSeaGreen=$0071B33C;
  pl_MediumSpringGreen=$009AFA00;
  pl_MintCream=$00FAFFF5;
  pl_OliveDrab=$00238E6B;
  pl_OliveDrab1=$003EFFC0;
  pl_OliveDrab2=$003AEEB3;
  pl_OliveDrab3=$0032CD9A;
  pl_OliveDrab4=$00228B69;
  pl_PaleGreen=$0098FB98;
  pl_PaleGreen1=$009AFF9A;
  pl_PaleGreen2=$0090EE90;
  pl_PaleGreen3=$007CCD7C;
  pl_PaleGreen4=$00548B54;
  pl_SeaGreen=$00578B2E;
  pl_SeaGreen1=$009FFF54;
  pl_SeaGreen2=$0094EE4E;
  pl_SeaGreen3=$0080CD43;
  pl_SeaGreen4=$00578B2E;
  pl_SpringGreen=$007FFF00;
  pl_SpringGreen1=$007FFF00;
  pl_SpringGreen2=$0076EE00;
  pl_SpringGreen3=$0066CD00;
  pl_SpringGreen4=$00458B00;
  pl_YellowGreen=$0032CD9A;
  pl_chartreuse=$0000FF7F;
  pl_chartreuse1=$0000FF7F;
  pl_chartreuse2=$0000EE76;
  pl_chartreuse3=$0000CD66;
  pl_chartreuse4=$00008B45;
  pl_green=$0000FF00;
  pl_green1=$0000FF00;
  pl_green2=$0000EE00;
  pl_green3=$0000CD00;
  pl_green4=$00008B00;
  pl_khaki=$008CE6F0;
  pl_khaki1=$008FF6FF;
  pl_khaki2=$0085E6EE;
  pl_khaki3=$0073C6CD;
  pl_khaki4=$004E868B;
  pl_DarkOrange=$00008CFF;
  pl_DarkOrange1=$00007FFF;
  pl_DarkOrange2=$000076EE;
  pl_DarkOrange3=$000066CD;
  pl_DarkOrange4=$0000458B;
  pl_DarkSalmon=$007A96E9;
  pl_LightCoral=$008080F0;
  pl_LightSalmon=$007AA0FF;
  pl_LightSalmon1=$007AA0FF;
  pl_LightSalmon2=$007295EE;
  pl_LightSalmon3=$006281CD;
  pl_LightSalmon4=$0042578B;
  pl_PeachPuff=$00B9DAFF;
  pl_PeachPuff1=$00B9DAFF;
  pl_PeachPuff2=$00ADCBEE;
  pl_PeachPuff3=$0095AFCD;
  pl_PeachPuff4=$0065778B;
  pl_bisque=$00C4E4FF;
  pl_bisque1=$00C4E4FF;
  pl_bisque2=$00B7D5EE;
  pl_bisque3=$009EB7CD;
  pl_bisque4=$006B7D8B;
  pl_coral=$00507FFF;
  pl_coral1=$005672FF;
  pl_coral2=$00506AEE;
  pl_coral3=$00455BCD;
  pl_coral4=$002F3E8B;
  pl_honeydew=$00F0FFF0;
  pl_honeydew1=$00F0FFF0;
  pl_honeydew2=$00E0EEE0;
  pl_honeydew3=$00C1CDC1;
  pl_honeydew4=$00838B83;
  pl_orange=$0000A5FF;
  pl_orange1=$0000A5FF;
  pl_orange2=$00009AEE;
  pl_orange3=$000085CD;
  pl_orange4=$00005A8B;
  pl_salmon=$007280FA;
  pl_salmon1=$00698CFF;
  pl_salmon2=$006282EE;
  pl_salmon3=$005470CD;
  pl_salmon4=$00394C8B;
  pl_sienna=$002D52A0;
  pl_sienna1=$004782FF;
  pl_sienna2=$004279EE;
  pl_sienna3=$003968CD;
  pl_sienna4=$0026478B;
  pl_DeepPink=$009314FF;
  pl_DeepPink1=$009314FF;
  pl_DeepPink2=$008912EE;
  pl_DeepPink3=$007610CD;
  pl_DeepPink4=$00500A8B;
  pl_HotPink=$00B469FF;
  pl_HotPink1=$00B46EFF;
  pl_HotPink2=$00A76AEE;
  pl_HotPink3=$009060CD;
  pl_HotPink4=$00623A8B;
  pl_IndianRed=$005C5CCD;
  pl_IndianRed1=$006A6AFF;
  pl_IndianRed2=$006363EE;
  pl_IndianRed3=$005555CD;
  pl_IndianRed4=$003A3A8B;
  pl_LightPink=$00C1B6FF;
  pl_LightPink1=$00B9AEFF;
  pl_LightPink2=$00ADA2EE;
  pl_LightPink3=$00958CCD;
  pl_LightPink4=$00655F8B;
  pl_MediumVioletRed=$008515C7;
  pl_MistyRose=$00E1E4FF;
  pl_MistyRose1=$00E1E4FF;
  pl_MistyRose2=$00D2D5EE;
  pl_MistyRose3=$00B5B7CD;
  pl_MistyRose4=$007B7D8B;
  pl_OrangeRed=$000045FF;
  pl_OrangeRed1=$000045FF;
  pl_OrangeRed2=$000040EE;
  pl_OrangeRed3=$000037CD;
  pl_OrangeRed4=$0000258B;
  pl_PaleVioletRed=$009370DB;
  pl_PaleVioletRed1=$00AB82FF;
  pl_PaleVioletRed2=$009F79EE;
  pl_PaleVioletRed3=$008968CD;
  pl_PaleVioletRed4=$005D478B;
  pl_VioletRed=$009020D0;
  pl_VioletRed1=$00963EFF;
  pl_VioletRed2=$008C3AEE;
  pl_VioletRed3=$007832CD;
  pl_VioletRed4=$0052228B;
  pl_firebrick=$002222B2;
  pl_firebrick1=$003030FF;
  pl_firebrick2=$002C2CEE;
  pl_firebrick3=$002626CD;
  pl_firebrick4=$001A1A8B;
  pl_pink=$00CBC0FF;
  pl_pink1=$00C5B5FF;
  pl_pink2=$00B8A9EE;
  pl_pink3=$009E91CD;
  pl_pink4=$006C638B;
  pl_red=$000000FF;
  pl_red1=$000000FF;
  pl_red2=$000000EE;
  pl_red3=$000000CD;
  pl_red4=$0000008B;
  pl_tomato=$004763FF;
  pl_tomato1=$004763FF;
  pl_tomato2=$00425CEE;
  pl_tomato3=$00394FCD;
  pl_tomato4=$0026368B;
  pl_DarkOrchid=$00CC3299;
  pl_DarkOrchid1=$00FF3EBF;
  pl_DarkOrchid2=$00EE3AB2;
  pl_DarkOrchid3=$00CD329A;
  pl_DarkOrchid4=$008B2268;
  pl_DarkViolet=$00D30094;
  pl_LavenderBlush=$00F5F0FF;
  pl_LavenderBlush1=$00F5F0FF;
  pl_LavenderBlush2=$00E5E0EE;
  pl_LavenderBlush3=$00C5C1CD;
  pl_LavenderBlush4=$0086838B;
  pl_MediumOrchid=$00D355BA;
  pl_MediumOrchid1=$00FF66E0;
  pl_MediumOrchid2=$00EE5FD1;
  pl_MediumOrchid3=$00CD52B4;
  pl_MediumOrchid4=$008B377A;
  pl_MediumPurple=$00DB7093;
  pl_MediumPurple1=$00FF82AB;
  pl_MediumPurple2=$00EE799F;
  pl_MediumPurple3=$00CD6889;
  pl_MediumPurple4=$008B475D;
  pl_lavender=$00FAE6E6;
  pl_magenta=$00FF00FF;
  pl_magenta1=$00FF00FF;
  pl_magenta2=$00EE00EE;
  pl_magenta3=$00CD00CD;
  pl_magenta4=$008B008B;
  pl_maroon=$006030B0;
  pl_maroon1=$00B334FF;
  pl_maroon2=$00A730EE;
  pl_maroon3=$009029CD;
  pl_maroon4=$00621C8B;
  pl_orchid=$00D670DA;
  pl_orchid1=$00FA83FF;
  pl_orchid2=$00E97AEE;
  pl_orchid3=$00C969CD;
  pl_orchid4=$0089478B;
  pl_plum=$00DDA0DD;
  pl_plum1=$00FFBBFF;
  pl_plum2=$00EEAEEE;
  pl_plum3=$00CD96CD;
  pl_plum4=$008B668B;
  pl_purple=$00F020A0;
  pl_purple1=$00FF309B;
  pl_purple2=$00EE2C91;
  pl_purple3=$00CD267D;
  pl_purple4=$008B1A55;
  pl_thistle=$00D8BFD8;
  pl_thistle1=$00FFE1FF;
  pl_thistle2=$00EED2EE;
  pl_thistle3=$00CDB5CD;
  pl_thistle4=$008B7B8B;
  pl_violet=$00EE82EE;
  pl_AntiqueWhite=$00D7EBFA;
  pl_AntiqueWhite1=$00DBEFFF;
  pl_AntiqueWhite2=$00CCDFEE;
  pl_AntiqueWhite3=$00B0C0CD;
  pl_AntiqueWhite4=$0078838B;
  pl_FloralWhite=$00F0FAFF;
  pl_GhostWhite=$00FFF8F8;
  pl_NavajoWhite=$00ADDEFF;
  pl_NavajoWhite1=$00ADDEFF;
  pl_NavajoWhite2=$00A1CFEE;
  pl_NavajoWhite3=$008BB3CD;
  pl_NavajoWhite4=$005E798B;
  pl_OldLace=$00E6F5FD;
  pl_WhiteSmoke=$00F5F5F5;
  pl_gainsboro=$00DCDCDC;
  pl_ivory=$00F0FFFF;
  pl_ivory1=$00F0FFFF;
  pl_ivory2=$00E0EEEE;
  pl_ivory3=$00C1CDCD;
  pl_ivory4=$00838B8B;
  pl_linen=$00E6F0FA;
  pl_seashell=$00EEF5FF;
  pl_seashell1=$00EEF5FF;
  pl_seashell2=$00DEE5EE;
  pl_seashell3=$00BFC5CD;
  pl_seashell4=$0082868B;
  pl_snow=$00FAFAFF;
  pl_snow1=$00FAFAFF;
  pl_snow2=$00E9E9EE;
  pl_snow3=$00C9C9CD;
  pl_snow4=$0089898B;
  pl_wheat=$00B3DEF5;
  pl_wheat1=$00BAE7FF;
  pl_wheat2=$00AED8EE;
  pl_wheat3=$0096BACD;
  pl_wheat4=$00667E8B;
  pl_white=$00FFFFFF;
  pl_BlanchedAlmond=$00CDEBFF;
  pl_DarkGoldenrod=$000B86B8;
  pl_DarkGoldenrod1=$000FB9FF;
  pl_DarkGoldenrod2=$000EADEE;
  pl_DarkGoldenrod3=$000C95CD;
  pl_DarkGoldenrod4=$0008658B;
  pl_LemonChiffon=$00CDFAFF;
  pl_LemonChiffon1=$00CDFAFF;
  pl_LemonChiffon2=$00BFE9EE;
  pl_LemonChiffon3=$00A5C9CD;
  pl_LemonChiffon4=$0070898B;
  pl_LightGoldenrod=$0082DDEE;
  pl_LightGoldenrod1=$008BECFF;
  pl_LightGoldenrod2=$0082DCEE;
  pl_LightGoldenrod3=$0070BECD;
  pl_LightGoldenrod4=$004C818B;
  pl_LightGoldenrodYellow=$00D2FAFA;
  pl_LightYellow=$00E0FFFF;
  pl_LightYellow1=$00E0FFFF;
  pl_LightYellow2=$00D1EEEE;
  pl_LightYellow3=$00B4CDCD;
  pl_LightYellow4=$007A8B8B;
  pl_PaleGoldenrod=$00AAE8EE;
  pl_PapayaWhip=$00D5EFFF;
  pl_cornsilk=$00DCF8FF;
  pl_cornsilk1=$00DCF8FF;
  pl_cornsilk2=$00CDE8EE;
  pl_cornsilk3=$00B1C8CD;
  pl_cornsilk4=$0078888B;
  pl_gold=$0000D7FF;
  pl_gold1=$0000D7FF;
  pl_gold2=$0000C9EE;
  pl_gold3=$0000ADCD;
  pl_gold4=$0000758B;
  pl_goldenrod=$0020A5DA;
  pl_goldenrod1=$0025C1FF;
  pl_goldenrod2=$0022B4EE;
  pl_goldenrod3=$001D9BCD;
  pl_goldenrod4=$0014698B;
  pl_moccasin=$00B5E4FF;
  pl_yellow=$0000FFFF;
  pl_yellow1=$0000FFFF;
  pl_yellow2=$0000EEEE;
  pl_yellow3=$0000CDCD;
  pl_yellow4=$00008B8B;
  
  Colors2: array[0..649] of TIdentMapEntry = (
  (Value: pl_black; Name: 'pl_black'),
  (Value: pl_AliceBlue; Name: 'pl_AliceBlue'),
  (Value: pl_BlueViolet; Name: 'pl_BlueViolet'),
  (Value: pl_CadetBlue; Name: 'pl_CadetBlue'),
  (Value: pl_CadetBlue1; Name: 'pl_CadetBlue1'),
  (Value: pl_CadetBlue2; Name: 'pl_CadetBlue2'),
  (Value: pl_CadetBlue3; Name: 'pl_CadetBlue3'),
  (Value: pl_CadetBlue4; Name: 'pl_CadetBlue4'),
  (Value: pl_CornflowerBlue; Name: 'pl_CornflowerBlue'),
  (Value: pl_DarkSlateBlue; Name: 'pl_DarkSlateBlue'),
  (Value: pl_DarkTurquoise; Name: 'pl_DarkTurquoise'),
  (Value: pl_DeepSkyBlue; Name: 'pl_DeepSkyBlue'),
  (Value: pl_DeepSkyBlue1; Name: 'pl_DeepSkyBlue1'),
  (Value: pl_DeepSkyBlue2; Name: 'pl_DeepSkyBlue2'),
  (Value: pl_DeepSkyBlue3; Name: 'pl_DeepSkyBlue3'),
  (Value: pl_DeepSkyBlue4; Name: 'pl_DeepSkyBlue4'),
  (Value: pl_DodgerBlue; Name: 'pl_DodgerBlue'),
  (Value: pl_DodgerBlue1; Name: 'pl_DodgerBlue1'),
  (Value: pl_DodgerBlue2; Name: 'pl_DodgerBlue2'),
  (Value: pl_DodgerBlue3; Name: 'pl_DodgerBlue3'),
  (Value: pl_DodgerBlue4; Name: 'pl_DodgerBlue4'),
  (Value: pl_LightBlue; Name: 'pl_LightBlue'),
  (Value: pl_LightBlue1; Name: 'pl_LightBlue1'),
  (Value: pl_LightBlue2; Name: 'pl_LightBlue2'),
  (Value: pl_LightBlue3; Name: 'pl_LightBlue3'),
  (Value: pl_LightBlue4; Name: 'pl_LightBlue4'),
  (Value: pl_LightCyan; Name: 'pl_LightCyan'),
  (Value: pl_LightCyan1; Name: 'pl_LightCyan1'),
  (Value: pl_LightCyan2; Name: 'pl_LightCyan2'),
  (Value: pl_LightCyan3; Name: 'pl_LightCyan3'),
  (Value: pl_LightCyan4; Name: 'pl_LightCyan4'),
  (Value: pl_LightSkyBlue; Name: 'pl_LightSkyBlue'),
  (Value: pl_LightSkyBlue1; Name: 'pl_LightSkyBlue1'),
  (Value: pl_LightSkyBlue2; Name: 'pl_LightSkyBlue2'),
  (Value: pl_LightSkyBlue3; Name: 'pl_LightSkyBlue3'),
  (Value: pl_LightSkyBlue4; Name: 'pl_LightSkyBlue4'),
  (Value: pl_LightSlateBlue; Name: 'pl_LightSlateBlue'),
  (Value: pl_LightSteelBlue; Name: 'pl_LightSteelBlue'),
  (Value: pl_LightSteelBlue1; Name: 'pl_LightSteelBlue1'),
  (Value: pl_LightSteelBlue2; Name: 'pl_LightSteelBlue2'),
  (Value: pl_LightSteelBlue3; Name: 'pl_LightSteelBlue3'),
  (Value: pl_LightSteelBlue4; Name: 'pl_LightSteelBlue4'),
  (Value: pl_MediumAquamarine; Name: 'pl_MediumAquamarine'),
  (Value: pl_MediumBlue; Name: 'pl_MediumBlue'),
  (Value: pl_MediumSlateBlue; Name: 'pl_MediumSlateBlue'),
  (Value: pl_MediumTurquoise; Name: 'pl_MediumTurquoise'),
  (Value: pl_MidnightBlue; Name: 'pl_MidnightBlue'),
  (Value: pl_NavyBlue; Name: 'pl_NavyBlue'),
  (Value: pl_PaleTurquoise; Name: 'pl_PaleTurquoise'),
  (Value: pl_PaleTurquoise1; Name: 'pl_PaleTurquoise1'),
  (Value: pl_PaleTurquoise2; Name: 'pl_PaleTurquoise2'),
  (Value: pl_PaleTurquoise3; Name: 'pl_PaleTurquoise3'),
  (Value: pl_PaleTurquoise4; Name: 'pl_PaleTurquoise4'),
  (Value: pl_PowderBlue; Name: 'pl_PowderBlue'),
  (Value: pl_RoyalBlue; Name: 'pl_RoyalBlue'),
  (Value: pl_RoyalBlue1; Name: 'pl_RoyalBlue1'),
  (Value: pl_RoyalBlue2; Name: 'pl_RoyalBlue2'),
  (Value: pl_RoyalBlue3; Name: 'pl_RoyalBlue3'),
  (Value: pl_RoyalBlue4; Name: 'pl_RoyalBlue4'),
  (Value: pl_SkyBlue; Name: 'pl_SkyBlue'),
  (Value: pl_SkyBlue1; Name: 'pl_SkyBlue1'),
  (Value: pl_SkyBlue2; Name: 'pl_SkyBlue2'),
  (Value: pl_SkyBlue3; Name: 'pl_SkyBlue3'),
  (Value: pl_SkyBlue4; Name: 'pl_SkyBlue4'),
  (Value: pl_SlateBlue; Name: 'pl_SlateBlue'),
  (Value: pl_SlateBlue1; Name: 'pl_SlateBlue1'),
  (Value: pl_SlateBlue2; Name: 'pl_SlateBlue2'),
  (Value: pl_SlateBlue3; Name: 'pl_SlateBlue3'),
  (Value: pl_SlateBlue4; Name: 'pl_SlateBlue4'),
  (Value: pl_SteelBlue; Name: 'pl_SteelBlue'),
  (Value: pl_SteelBlue1; Name: 'pl_SteelBlue1'),
  (Value: pl_SteelBlue2; Name: 'pl_SteelBlue2'),
  (Value: pl_SteelBlue3; Name: 'pl_SteelBlue3'),
  (Value: pl_SteelBlue4; Name: 'pl_SteelBlue4'),
  (Value: pl_aquamarine; Name: 'pl_aquamarine'),
  (Value: pl_aquamarine1; Name: 'pl_aquamarine1'),
  (Value: pl_aquamarine2; Name: 'pl_aquamarine2'),
  (Value: pl_aquamarine3; Name: 'pl_aquamarine3'),
  (Value: pl_aquamarine4; Name: 'pl_aquamarine4'),
  (Value: pl_azure; Name: 'pl_azure'),
  (Value: pl_azure1; Name: 'pl_azure1'),
  (Value: pl_azure2; Name: 'pl_azure2'),
  (Value: pl_azure3; Name: 'pl_azure3'),
  (Value: pl_azure4; Name: 'pl_azure4'),
  (Value: pl_blue; Name: 'pl_blue'),
  (Value: pl_blue1; Name: 'pl_blue1'),
  (Value: pl_blue2; Name: 'pl_blue2'),
  (Value: pl_blue3; Name: 'pl_blue3'),
  (Value: pl_blue4; Name: 'pl_blue4'),
  (Value: pl_cyan; Name: 'pl_cyan'),
  (Value: pl_cyan1; Name: 'pl_cyan1'),
  (Value: pl_cyan2; Name: 'pl_cyan2'),
  (Value: pl_cyan3; Name: 'pl_cyan3'),
  (Value: pl_cyan4; Name: 'pl_cyan4'),
  (Value: pl_navy; Name: 'pl_navy'),
  (Value: pl_turquoise; Name: 'pl_turquoise'),
  (Value: pl_turquoise1; Name: 'pl_turquoise1'),
  (Value: pl_turquoise2; Name: 'pl_turquoise2'),
  (Value: pl_turquoise3; Name: 'pl_turquoise3'),
  (Value: pl_turquoise4; Name: 'pl_turquoise4'),
  (Value: pl_RosyBrown; Name: 'pl_RosyBrown'),
  (Value: pl_RosyBrown1; Name: 'pl_RosyBrown1'),
  (Value: pl_RosyBrown2; Name: 'pl_RosyBrown2'),
  (Value: pl_RosyBrown3; Name: 'pl_RosyBrown3'),
  (Value: pl_RosyBrown4; Name: 'pl_RosyBrown4'),
  (Value: pl_SaddleBrown; Name: 'pl_SaddleBrown'),
  (Value: pl_SandyBrown; Name: 'pl_SandyBrown'),
  (Value: pl_beige; Name: 'pl_beige'),
  (Value: pl_brown; Name: 'pl_brown'),
  (Value: pl_brown1; Name: 'pl_brown1'),
  (Value: pl_brown2; Name: 'pl_brown2'),
  (Value: pl_brown3; Name: 'pl_brown3'),
  (Value: pl_brown4; Name: 'pl_brown4'),
  (Value: pl_burlywood; Name: 'pl_burlywood'),
  (Value: pl_burlywood1; Name: 'pl_burlywood1'),
  (Value: pl_burlywood2; Name: 'pl_burlywood2'),
  (Value: pl_burlywood3; Name: 'pl_burlywood3'),
  (Value: pl_burlywood4; Name: 'pl_burlywood4'),
  (Value: pl_chocolate; Name: 'pl_chocolate'),
  (Value: pl_chocolate1; Name: 'pl_chocolate1'),
  (Value: pl_chocolate2; Name: 'pl_chocolate2'),
  (Value: pl_chocolate3; Name: 'pl_chocolate3'),
  (Value: pl_chocolate4; Name: 'pl_chocolate4'),
  (Value: pl_peru; Name: 'pl_peru'),
  (Value: pl_tan; Name: 'pl_tan'),
  (Value: pl_tan1; Name: 'pl_tan1'),
  (Value: pl_tan2; Name: 'pl_tan2'),
  (Value: pl_tan3; Name: 'pl_tan3'),
  (Value: pl_tan4; Name: 'pl_tan4'),
  (Value: pl_DarkSlateGray; Name: 'pl_DarkSlateGray'),
  (Value: pl_DarkSlateGray1; Name: 'pl_DarkSlateGray1'),
  (Value: pl_DarkSlateGray2; Name: 'pl_DarkSlateGray2'),
  (Value: pl_DarkSlateGray3; Name: 'pl_DarkSlateGray3'),
  (Value: pl_DarkSlateGray4; Name: 'pl_DarkSlateGray4'),
  (Value: pl_DarkSlateGrey; Name: 'pl_DarkSlateGrey'),
  (Value: pl_DimGray; Name: 'pl_DimGray'),
  (Value: pl_DimGrey; Name: 'pl_DimGrey'),
  (Value: pl_LightGray; Name: 'pl_LightGray'),
  (Value: pl_LightGrey; Name: 'pl_LightGrey'),
  (Value: pl_LightSlateGray; Name: 'pl_LightSlateGray'),
  (Value: pl_LightSlateGrey; Name: 'pl_LightSlateGrey'),
  (Value: pl_SlateGray; Name: 'pl_SlateGray'),
  (Value: pl_SlateGray1; Name: 'pl_SlateGray1'),
  (Value: pl_SlateGray2; Name: 'pl_SlateGray2'),
  (Value: pl_SlateGray3; Name: 'pl_SlateGray3'),
  (Value: pl_SlateGray4; Name: 'pl_SlateGray4'),
  (Value: pl_SlateGrey; Name: 'pl_SlateGrey'),
  (Value: pl_gray; Name: 'pl_gray'),
  (Value: pl_gray0; Name: 'pl_gray0'),
  (Value: pl_gray1; Name: 'pl_gray1'),
  (Value: pl_gray10; Name: 'pl_gray10'),
  (Value: pl_gray100; Name: 'pl_gray100'),
  (Value: pl_gray11; Name: 'pl_gray11'),
  (Value: pl_gray12; Name: 'pl_gray12'),
  (Value: pl_gray13; Name: 'pl_gray13'),
  (Value: pl_gray14; Name: 'pl_gray14'),
  (Value: pl_gray15; Name: 'pl_gray15'),
  (Value: pl_gray16; Name: 'pl_gray16'),
  (Value: pl_gray17; Name: 'pl_gray17'),
  (Value: pl_gray18; Name: 'pl_gray18'),
  (Value: pl_gray19; Name: 'pl_gray19'),
  (Value: pl_gray2; Name: 'pl_gray2'),
  (Value: pl_gray20; Name: 'pl_gray20'),
  (Value: pl_gray21; Name: 'pl_gray21'),
  (Value: pl_gray22; Name: 'pl_gray22'),
  (Value: pl_gray23; Name: 'pl_gray23'),
  (Value: pl_gray24; Name: 'pl_gray24'),
  (Value: pl_gray25; Name: 'pl_gray25'),
  (Value: pl_gray26; Name: 'pl_gray26'),
  (Value: pl_gray27; Name: 'pl_gray27'),
  (Value: pl_gray28; Name: 'pl_gray28'),
  (Value: pl_gray29; Name: 'pl_gray29'),
  (Value: pl_gray3; Name: 'pl_gray3'),
  (Value: pl_gray30; Name: 'pl_gray30'),
  (Value: pl_gray31; Name: 'pl_gray31'),
  (Value: pl_gray32; Name: 'pl_gray32'),
  (Value: pl_gray33; Name: 'pl_gray33'),
  (Value: pl_gray34; Name: 'pl_gray34'),
  (Value: pl_gray35; Name: 'pl_gray35'),
  (Value: pl_gray36; Name: 'pl_gray36'),
  (Value: pl_gray37; Name: 'pl_gray37'),
  (Value: pl_gray38; Name: 'pl_gray38'),
  (Value: pl_gray39; Name: 'pl_gray39'),
  (Value: pl_gray4; Name: 'pl_gray4'),
  (Value: pl_gray40; Name: 'pl_gray40'),
  (Value: pl_gray41; Name: 'pl_gray41'),
  (Value: pl_gray42; Name: 'pl_gray42'),
  (Value: pl_gray43; Name: 'pl_gray43'),
  (Value: pl_gray44; Name: 'pl_gray44'),
  (Value: pl_gray45; Name: 'pl_gray45'),
  (Value: pl_gray46; Name: 'pl_gray46'),
  (Value: pl_gray47; Name: 'pl_gray47'),
  (Value: pl_gray48; Name: 'pl_gray48'),
  (Value: pl_gray49; Name: 'pl_gray49'),
  (Value: pl_gray5; Name: 'pl_gray5'),
  (Value: pl_gray50; Name: 'pl_gray50'),
  (Value: pl_gray51; Name: 'pl_gray51'),
  (Value: pl_gray52; Name: 'pl_gray52'),
  (Value: pl_gray53; Name: 'pl_gray53'),
  (Value: pl_gray54; Name: 'pl_gray54'),
  (Value: pl_gray55; Name: 'pl_gray55'),
  (Value: pl_gray56; Name: 'pl_gray56'),
  (Value: pl_gray57; Name: 'pl_gray57'),
  (Value: pl_gray58; Name: 'pl_gray58'),
  (Value: pl_gray59; Name: 'pl_gray59'),
  (Value: pl_gray6; Name: 'pl_gray6'),
  (Value: pl_gray60; Name: 'pl_gray60'),
  (Value: pl_gray61; Name: 'pl_gray61'),
  (Value: pl_gray62; Name: 'pl_gray62'),
  (Value: pl_gray63; Name: 'pl_gray63'),
  (Value: pl_gray64; Name: 'pl_gray64'),
  (Value: pl_gray65; Name: 'pl_gray65'),
  (Value: pl_gray66; Name: 'pl_gray66'),
  (Value: pl_gray67; Name: 'pl_gray67'),
  (Value: pl_gray68; Name: 'pl_gray68'),
  (Value: pl_gray69; Name: 'pl_gray69'),
  (Value: pl_gray7; Name: 'pl_gray7'),
  (Value: pl_gray70; Name: 'pl_gray70'),
  (Value: pl_gray71; Name: 'pl_gray71'),
  (Value: pl_gray72; Name: 'pl_gray72'),
  (Value: pl_gray73; Name: 'pl_gray73'),
  (Value: pl_gray74; Name: 'pl_gray74'),
  (Value: pl_gray75; Name: 'pl_gray75'),
  (Value: pl_gray76; Name: 'pl_gray76'),
  (Value: pl_gray77; Name: 'pl_gray77'),
  (Value: pl_gray78; Name: 'pl_gray78'),
  (Value: pl_gray79; Name: 'pl_gray79'),
  (Value: pl_gray8; Name: 'pl_gray8'),
  (Value: pl_gray80; Name: 'pl_gray80'),
  (Value: pl_gray81; Name: 'pl_gray81'),
  (Value: pl_gray82; Name: 'pl_gray82'),
  (Value: pl_gray83; Name: 'pl_gray83'),
  (Value: pl_gray84; Name: 'pl_gray84'),
  (Value: pl_gray85; Name: 'pl_gray85'),
  (Value: pl_gray86; Name: 'pl_gray86'),
  (Value: pl_gray87; Name: 'pl_gray87'),
  (Value: pl_gray88; Name: 'pl_gray88'),
  (Value: pl_gray89; Name: 'pl_gray89'),
  (Value: pl_gray9; Name: 'pl_gray9'),
  (Value: pl_gray90; Name: 'pl_gray90'),
  (Value: pl_gray91; Name: 'pl_gray91'),
  (Value: pl_gray92; Name: 'pl_gray92'),
  (Value: pl_gray93; Name: 'pl_gray93'),
  (Value: pl_gray94; Name: 'pl_gray94'),
  (Value: pl_gray95; Name: 'pl_gray95'),
  (Value: pl_gray96; Name: 'pl_gray96'),
  (Value: pl_gray97; Name: 'pl_gray97'),
  (Value: pl_gray98; Name: 'pl_gray98'),
  (Value: pl_gray99; Name: 'pl_gray99'),
  (Value: pl_grey; Name: 'pl_grey'),
  (Value: pl_grey0; Name: 'pl_grey0'),
  (Value: pl_grey1; Name: 'pl_grey1'),
  (Value: pl_grey10; Name: 'pl_grey10'),
  (Value: pl_grey100; Name: 'pl_grey100'),
  (Value: pl_grey11; Name: 'pl_grey11'),
  (Value: pl_grey12; Name: 'pl_grey12'),
  (Value: pl_grey13; Name: 'pl_grey13'),
  (Value: pl_grey14; Name: 'pl_grey14'),
  (Value: pl_grey15; Name: 'pl_grey15'),
  (Value: pl_grey16; Name: 'pl_grey16'),
  (Value: pl_grey17; Name: 'pl_grey17'),
  (Value: pl_grey18; Name: 'pl_grey18'),
  (Value: pl_grey19; Name: 'pl_grey19'),
  (Value: pl_grey2; Name: 'pl_grey2'),
  (Value: pl_grey20; Name: 'pl_grey20'),
  (Value: pl_grey21; Name: 'pl_grey21'),
  (Value: pl_grey22; Name: 'pl_grey22'),
  (Value: pl_grey23; Name: 'pl_grey23'),
  (Value: pl_grey24; Name: 'pl_grey24'),
  (Value: pl_grey25; Name: 'pl_grey25'),
  (Value: pl_grey26; Name: 'pl_grey26'),
  (Value: pl_grey27; Name: 'pl_grey27'),
  (Value: pl_grey28; Name: 'pl_grey28'),
  (Value: pl_grey29; Name: 'pl_grey29'),
  (Value: pl_grey3; Name: 'pl_grey3'),
  (Value: pl_grey30; Name: 'pl_grey30'),
  (Value: pl_grey31; Name: 'pl_grey31'),
  (Value: pl_grey32; Name: 'pl_grey32'),
  (Value: pl_grey33; Name: 'pl_grey33'),
  (Value: pl_grey34; Name: 'pl_grey34'),
  (Value: pl_grey35; Name: 'pl_grey35'),
  (Value: pl_grey36; Name: 'pl_grey36'),
  (Value: pl_grey37; Name: 'pl_grey37'),
  (Value: pl_grey38; Name: 'pl_grey38'),
  (Value: pl_grey39; Name: 'pl_grey39'),
  (Value: pl_grey4; Name: 'pl_grey4'),
  (Value: pl_grey40; Name: 'pl_grey40'),
  (Value: pl_grey41; Name: 'pl_grey41'),
  (Value: pl_grey42; Name: 'pl_grey42'),
  (Value: pl_grey43; Name: 'pl_grey43'),
  (Value: pl_grey44; Name: 'pl_grey44'),
  (Value: pl_grey45; Name: 'pl_grey45'),
  (Value: pl_grey46; Name: 'pl_grey46'),
  (Value: pl_grey47; Name: 'pl_grey47'),
  (Value: pl_grey48; Name: 'pl_grey48'),
  (Value: pl_grey49; Name: 'pl_grey49'),
  (Value: pl_grey5; Name: 'pl_grey5'),
  (Value: pl_grey50; Name: 'pl_grey50'),
  (Value: pl_grey51; Name: 'pl_grey51'),
  (Value: pl_grey52; Name: 'pl_grey52'),
  (Value: pl_grey53; Name: 'pl_grey53'),
  (Value: pl_grey54; Name: 'pl_grey54'),
  (Value: pl_grey55; Name: 'pl_grey55'),
  (Value: pl_grey56; Name: 'pl_grey56'),
  (Value: pl_grey57; Name: 'pl_grey57'),
  (Value: pl_grey58; Name: 'pl_grey58'),
  (Value: pl_grey59; Name: 'pl_grey59'),
  (Value: pl_grey6; Name: 'pl_grey6'),
  (Value: pl_grey60; Name: 'pl_grey60'),
  (Value: pl_grey61; Name: 'pl_grey61'),
  (Value: pl_grey62; Name: 'pl_grey62'),
  (Value: pl_grey63; Name: 'pl_grey63'),
  (Value: pl_grey64; Name: 'pl_grey64'),
  (Value: pl_grey65; Name: 'pl_grey65'),
  (Value: pl_grey66; Name: 'pl_grey66'),
  (Value: pl_grey67; Name: 'pl_grey67'),
  (Value: pl_grey68; Name: 'pl_grey68'),
  (Value: pl_grey69; Name: 'pl_grey69'),
  (Value: pl_grey7; Name: 'pl_grey7'),
  (Value: pl_grey70; Name: 'pl_grey70'),
  (Value: pl_grey71; Name: 'pl_grey71'),
  (Value: pl_grey72; Name: 'pl_grey72'),
  (Value: pl_grey73; Name: 'pl_grey73'),
  (Value: pl_grey74; Name: 'pl_grey74'),
  (Value: pl_grey75; Name: 'pl_grey75'),
  (Value: pl_grey76; Name: 'pl_grey76'),
  (Value: pl_grey77; Name: 'pl_grey77'),
  (Value: pl_grey78; Name: 'pl_grey78'),
  (Value: pl_grey79; Name: 'pl_grey79'),
  (Value: pl_grey8; Name: 'pl_grey8'),
  (Value: pl_grey80; Name: 'pl_grey80'),
  (Value: pl_grey81; Name: 'pl_grey81'),
  (Value: pl_grey82; Name: 'pl_grey82'),
  (Value: pl_grey83; Name: 'pl_grey83'),
  (Value: pl_grey84; Name: 'pl_grey84'),
  (Value: pl_grey85; Name: 'pl_grey85'),
  (Value: pl_grey86; Name: 'pl_grey86'),
  (Value: pl_grey87; Name: 'pl_grey87'),
  (Value: pl_grey88; Name: 'pl_grey88'),
  (Value: pl_grey89; Name: 'pl_grey89'),
  (Value: pl_grey9; Name: 'pl_grey9'),
  (Value: pl_grey90; Name: 'pl_grey90'),
  (Value: pl_grey91; Name: 'pl_grey91'),
  (Value: pl_grey92; Name: 'pl_grey92'),
  (Value: pl_grey93; Name: 'pl_grey93'),
  (Value: pl_grey94; Name: 'pl_grey94'),
  (Value: pl_grey95; Name: 'pl_grey95'),
  (Value: pl_grey96; Name: 'pl_grey96'),
  (Value: pl_grey97; Name: 'pl_grey97'),
  (Value: pl_grey98; Name: 'pl_grey98'),
  (Value: pl_grey99; Name: 'pl_grey99'),
  (Value: pl_DarkGreen; Name: 'pl_DarkGreen'),
  (Value: pl_DarkKhaki; Name: 'pl_DarkKhaki'),
  (Value: pl_DarkOliveGreen; Name: 'pl_DarkOliveGreen'),
  (Value: pl_DarkOliveGreen1; Name: 'pl_DarkOliveGreen1'),
  (Value: pl_DarkOliveGreen2; Name: 'pl_DarkOliveGreen2'),
  (Value: pl_DarkOliveGreen3; Name: 'pl_DarkOliveGreen3'),
  (Value: pl_DarkOliveGreen4; Name: 'pl_DarkOliveGreen4'),
  (Value: pl_DarkSeaGreen; Name: 'pl_DarkSeaGreen'),
  (Value: pl_DarkSeaGreen1; Name: 'pl_DarkSeaGreen1'),
  (Value: pl_DarkSeaGreen2; Name: 'pl_DarkSeaGreen2'),
  (Value: pl_DarkSeaGreen3; Name: 'pl_DarkSeaGreen3'),
  (Value: pl_DarkSeaGreen4; Name: 'pl_DarkSeaGreen4'),
  (Value: pl_ForestGreen; Name: 'pl_ForestGreen'),
  (Value: pl_GreenYellow; Name: 'pl_GreenYellow'),
  (Value: pl_LawnGreen; Name: 'pl_LawnGreen'),
  (Value: pl_LightSeaGreen; Name: 'pl_LightSeaGreen'),
  (Value: pl_LimeGreen; Name: 'pl_LimeGreen'),
  (Value: pl_MediumSeaGreen; Name: 'pl_MediumSeaGreen'),
  (Value: pl_MediumSpringGreen; Name: 'pl_MediumSpringGreen'),
  (Value: pl_MintCream; Name: 'pl_MintCream'),
  (Value: pl_OliveDrab; Name: 'pl_OliveDrab'),
  (Value: pl_OliveDrab1; Name: 'pl_OliveDrab1'),
  (Value: pl_OliveDrab2; Name: 'pl_OliveDrab2'),
  (Value: pl_OliveDrab3; Name: 'pl_OliveDrab3'),
  (Value: pl_OliveDrab4; Name: 'pl_OliveDrab4'),
  (Value: pl_PaleGreen; Name: 'pl_PaleGreen'),
  (Value: pl_PaleGreen1; Name: 'pl_PaleGreen1'),
  (Value: pl_PaleGreen2; Name: 'pl_PaleGreen2'),
  (Value: pl_PaleGreen3; Name: 'pl_PaleGreen3'),
  (Value: pl_PaleGreen4; Name: 'pl_PaleGreen4'),
  (Value: pl_SeaGreen; Name: 'pl_SeaGreen'),
  (Value: pl_SeaGreen1; Name: 'pl_SeaGreen1'),
  (Value: pl_SeaGreen2; Name: 'pl_SeaGreen2'),
  (Value: pl_SeaGreen3; Name: 'pl_SeaGreen3'),
  (Value: pl_SeaGreen4; Name: 'pl_SeaGreen4'),
  (Value: pl_SpringGreen; Name: 'pl_SpringGreen'),
  (Value: pl_SpringGreen1; Name: 'pl_SpringGreen1'),
  (Value: pl_SpringGreen2; Name: 'pl_SpringGreen2'),
  (Value: pl_SpringGreen3; Name: 'pl_SpringGreen3'),
  (Value: pl_SpringGreen4; Name: 'pl_SpringGreen4'),
  (Value: pl_YellowGreen; Name: 'pl_YellowGreen'),
  (Value: pl_chartreuse; Name: 'pl_chartreuse'),
  (Value: pl_chartreuse1; Name: 'pl_chartreuse1'),
  (Value: pl_chartreuse2; Name: 'pl_chartreuse2'),
  (Value: pl_chartreuse3; Name: 'pl_chartreuse3'),
  (Value: pl_chartreuse4; Name: 'pl_chartreuse4'),
  (Value: pl_green; Name: 'pl_green'),
  (Value: pl_green1; Name: 'pl_green1'),
  (Value: pl_green2; Name: 'pl_green2'),
  (Value: pl_green3; Name: 'pl_green3'),
  (Value: pl_green4; Name: 'pl_green4'),
  (Value: pl_khaki; Name: 'pl_khaki'),
  (Value: pl_khaki1; Name: 'pl_khaki1'),
  (Value: pl_khaki2; Name: 'pl_khaki2'),
  (Value: pl_khaki3; Name: 'pl_khaki3'),
  (Value: pl_khaki4; Name: 'pl_khaki4'),
  (Value: pl_DarkOrange; Name: 'pl_DarkOrange'),
  (Value: pl_DarkOrange1; Name: 'pl_DarkOrange1'),
  (Value: pl_DarkOrange2; Name: 'pl_DarkOrange2'),
  (Value: pl_DarkOrange3; Name: 'pl_DarkOrange3'),
  (Value: pl_DarkOrange4; Name: 'pl_DarkOrange4'),
  (Value: pl_DarkSalmon; Name: 'pl_DarkSalmon'),
  (Value: pl_LightCoral; Name: 'pl_LightCoral'),
  (Value: pl_LightSalmon; Name: 'pl_LightSalmon'),
  (Value: pl_LightSalmon1; Name: 'pl_LightSalmon1'),
  (Value: pl_LightSalmon2; Name: 'pl_LightSalmon2'),
  (Value: pl_LightSalmon3; Name: 'pl_LightSalmon3'),
  (Value: pl_LightSalmon4; Name: 'pl_LightSalmon4'),
  (Value: pl_PeachPuff; Name: 'pl_PeachPuff'),
  (Value: pl_PeachPuff1; Name: 'pl_PeachPuff1'),
  (Value: pl_PeachPuff2; Name: 'pl_PeachPuff2'),
  (Value: pl_PeachPuff3; Name: 'pl_PeachPuff3'),
  (Value: pl_PeachPuff4; Name: 'pl_PeachPuff4'),
  (Value: pl_bisque; Name: 'pl_bisque'),
  (Value: pl_bisque1; Name: 'pl_bisque1'),
  (Value: pl_bisque2; Name: 'pl_bisque2'),
  (Value: pl_bisque3; Name: 'pl_bisque3'),
  (Value: pl_bisque4; Name: 'pl_bisque4'),
  (Value: pl_coral; Name: 'pl_coral'),
  (Value: pl_coral1; Name: 'pl_coral1'),
  (Value: pl_coral2; Name: 'pl_coral2'),
  (Value: pl_coral3; Name: 'pl_coral3'),
  (Value: pl_coral4; Name: 'pl_coral4'),
  (Value: pl_honeydew; Name: 'pl_honeydew'),
  (Value: pl_honeydew1; Name: 'pl_honeydew1'),
  (Value: pl_honeydew2; Name: 'pl_honeydew2'),
  (Value: pl_honeydew3; Name: 'pl_honeydew3'),
  (Value: pl_honeydew4; Name: 'pl_honeydew4'),
  (Value: pl_orange; Name: 'pl_orange'),
  (Value: pl_orange1; Name: 'pl_orange1'),
  (Value: pl_orange2; Name: 'pl_orange2'),
  (Value: pl_orange3; Name: 'pl_orange3'),
  (Value: pl_orange4; Name: 'pl_orange4'),
  (Value: pl_salmon; Name: 'pl_salmon'),
  (Value: pl_salmon1; Name: 'pl_salmon1'),
  (Value: pl_salmon2; Name: 'pl_salmon2'),
  (Value: pl_salmon3; Name: 'pl_salmon3'),
  (Value: pl_salmon4; Name: 'pl_salmon4'),
  (Value: pl_sienna; Name: 'pl_sienna'),
  (Value: pl_sienna1; Name: 'pl_sienna1'),
  (Value: pl_sienna2; Name: 'pl_sienna2'),
  (Value: pl_sienna3; Name: 'pl_sienna3'),
  (Value: pl_sienna4; Name: 'pl_sienna4'),
  (Value: pl_DeepPink; Name: 'pl_DeepPink'),
  (Value: pl_DeepPink1; Name: 'pl_DeepPink1'),
  (Value: pl_DeepPink2; Name: 'pl_DeepPink2'),
  (Value: pl_DeepPink3; Name: 'pl_DeepPink3'),
  (Value: pl_DeepPink4; Name: 'pl_DeepPink4'),
  (Value: pl_HotPink; Name: 'pl_HotPink'),
  (Value: pl_HotPink1; Name: 'pl_HotPink1'),
  (Value: pl_HotPink2; Name: 'pl_HotPink2'),
  (Value: pl_HotPink3; Name: 'pl_HotPink3'),
  (Value: pl_HotPink4; Name: 'pl_HotPink4'),
  (Value: pl_IndianRed; Name: 'pl_IndianRed'),
  (Value: pl_IndianRed1; Name: 'pl_IndianRed1'),
  (Value: pl_IndianRed2; Name: 'pl_IndianRed2'),
  (Value: pl_IndianRed3; Name: 'pl_IndianRed3'),
  (Value: pl_IndianRed4; Name: 'pl_IndianRed4'),
  (Value: pl_LightPink; Name: 'pl_LightPink'),
  (Value: pl_LightPink1; Name: 'pl_LightPink1'),
  (Value: pl_LightPink2; Name: 'pl_LightPink2'),
  (Value: pl_LightPink3; Name: 'pl_LightPink3'),
  (Value: pl_LightPink4; Name: 'pl_LightPink4'),
  (Value: pl_MediumVioletRed; Name: 'pl_MediumVioletRed'),
  (Value: pl_MistyRose; Name: 'pl_MistyRose'),
  (Value: pl_MistyRose1; Name: 'pl_MistyRose1'),
  (Value: pl_MistyRose2; Name: 'pl_MistyRose2'),
  (Value: pl_MistyRose3; Name: 'pl_MistyRose3'),
  (Value: pl_MistyRose4; Name: 'pl_MistyRose4'),
  (Value: pl_OrangeRed; Name: 'pl_OrangeRed'),
  (Value: pl_OrangeRed1; Name: 'pl_OrangeRed1'),
  (Value: pl_OrangeRed2; Name: 'pl_OrangeRed2'),
  (Value: pl_OrangeRed3; Name: 'pl_OrangeRed3'),
  (Value: pl_OrangeRed4; Name: 'pl_OrangeRed4'),
  (Value: pl_PaleVioletRed; Name: 'pl_PaleVioletRed'),
  (Value: pl_PaleVioletRed1; Name: 'pl_PaleVioletRed1'),
  (Value: pl_PaleVioletRed2; Name: 'pl_PaleVioletRed2'),
  (Value: pl_PaleVioletRed3; Name: 'pl_PaleVioletRed3'),
  (Value: pl_PaleVioletRed4; Name: 'pl_PaleVioletRed4'),
  (Value: pl_VioletRed; Name: 'pl_VioletRed'),
  (Value: pl_VioletRed1; Name: 'pl_VioletRed1'),
  (Value: pl_VioletRed2; Name: 'pl_VioletRed2'),
  (Value: pl_VioletRed3; Name: 'pl_VioletRed3'),
  (Value: pl_VioletRed4; Name: 'pl_VioletRed4'),
  (Value: pl_firebrick; Name: 'pl_firebrick'),
  (Value: pl_firebrick1; Name: 'pl_firebrick1'),
  (Value: pl_firebrick2; Name: 'pl_firebrick2'),
  (Value: pl_firebrick3; Name: 'pl_firebrick3'),
  (Value: pl_firebrick4; Name: 'pl_firebrick4'),
  (Value: pl_pink; Name: 'pl_pink'),
  (Value: pl_pink1; Name: 'pl_pink1'),
  (Value: pl_pink2; Name: 'pl_pink2'),
  (Value: pl_pink3; Name: 'pl_pink3'),
  (Value: pl_pink4; Name: 'pl_pink4'),
  (Value: pl_red; Name: 'pl_red'),
  (Value: pl_red1; Name: 'pl_red1'),
  (Value: pl_red2; Name: 'pl_red2'),
  (Value: pl_red3; Name: 'pl_red3'),
  (Value: pl_red4; Name: 'pl_red4'),
  (Value: pl_tomato; Name: 'pl_tomato'),
  (Value: pl_tomato1; Name: 'pl_tomato1'),
  (Value: pl_tomato2; Name: 'pl_tomato2'),
  (Value: pl_tomato3; Name: 'pl_tomato3'),
  (Value: pl_tomato4; Name: 'pl_tomato4'),
  (Value: pl_DarkOrchid; Name: 'pl_DarkOrchid'),
  (Value: pl_DarkOrchid1; Name: 'pl_DarkOrchid1'),
  (Value: pl_DarkOrchid2; Name: 'pl_DarkOrchid2'),
  (Value: pl_DarkOrchid3; Name: 'pl_DarkOrchid3'),
  (Value: pl_DarkOrchid4; Name: 'pl_DarkOrchid4'),
  (Value: pl_DarkViolet; Name: 'pl_DarkViolet'),
  (Value: pl_LavenderBlush; Name: 'pl_LavenderBlush'),
  (Value: pl_LavenderBlush1; Name: 'pl_LavenderBlush1'),
  (Value: pl_LavenderBlush2; Name: 'pl_LavenderBlush2'),
  (Value: pl_LavenderBlush3; Name: 'pl_LavenderBlush3'),
  (Value: pl_LavenderBlush4; Name: 'pl_LavenderBlush4'),
  (Value: pl_MediumOrchid; Name: 'pl_MediumOrchid'),
  (Value: pl_MediumOrchid1; Name: 'pl_MediumOrchid1'),
  (Value: pl_MediumOrchid2; Name: 'pl_MediumOrchid2'),
  (Value: pl_MediumOrchid3; Name: 'pl_MediumOrchid3'),
  (Value: pl_MediumOrchid4; Name: 'pl_MediumOrchid4'),
  (Value: pl_MediumPurple; Name: 'pl_MediumPurple'),
  (Value: pl_MediumPurple1; Name: 'pl_MediumPurple1'),
  (Value: pl_MediumPurple2; Name: 'pl_MediumPurple2'),
  (Value: pl_MediumPurple3; Name: 'pl_MediumPurple3'),
  (Value: pl_MediumPurple4; Name: 'pl_MediumPurple4'),
  (Value: pl_lavender; Name: 'pl_lavender'),
  (Value: pl_magenta; Name: 'pl_magenta'),
  (Value: pl_magenta1; Name: 'pl_magenta1'),
  (Value: pl_magenta2; Name: 'pl_magenta2'),
  (Value: pl_magenta3; Name: 'pl_magenta3'),
  (Value: pl_magenta4; Name: 'pl_magenta4'),
  (Value: pl_maroon; Name: 'pl_maroon'),
  (Value: pl_maroon1; Name: 'pl_maroon1'),
  (Value: pl_maroon2; Name: 'pl_maroon2'),
  (Value: pl_maroon3; Name: 'pl_maroon3'),
  (Value: pl_maroon4; Name: 'pl_maroon4'),
  (Value: pl_orchid; Name: 'pl_orchid'),
  (Value: pl_orchid1; Name: 'pl_orchid1'),
  (Value: pl_orchid2; Name: 'pl_orchid2'),
  (Value: pl_orchid3; Name: 'pl_orchid3'),
  (Value: pl_orchid4; Name: 'pl_orchid4'),
  (Value: pl_plum; Name: 'pl_plum'),
  (Value: pl_plum1; Name: 'pl_plum1'),
  (Value: pl_plum2; Name: 'pl_plum2'),
  (Value: pl_plum3; Name: 'pl_plum3'),
  (Value: pl_plum4; Name: 'pl_plum4'),
  (Value: pl_purple; Name: 'pl_purple'),
  (Value: pl_purple1; Name: 'pl_purple1'),
  (Value: pl_purple2; Name: 'pl_purple2'),
  (Value: pl_purple3; Name: 'pl_purple3'),
  (Value: pl_purple4; Name: 'pl_purple4'),
  (Value: pl_thistle; Name: 'pl_thistle'),
  (Value: pl_thistle1; Name: 'pl_thistle1'),
  (Value: pl_thistle2; Name: 'pl_thistle2'),
  (Value: pl_thistle3; Name: 'pl_thistle3'),
  (Value: pl_thistle4; Name: 'pl_thistle4'),
  (Value: pl_violet; Name: 'pl_violet'),
  (Value: pl_AntiqueWhite; Name: 'pl_AntiqueWhite'),
  (Value: pl_AntiqueWhite1; Name: 'pl_AntiqueWhite1'),
  (Value: pl_AntiqueWhite2; Name: 'pl_AntiqueWhite2'),
  (Value: pl_AntiqueWhite3; Name: 'pl_AntiqueWhite3'),
  (Value: pl_AntiqueWhite4; Name: 'pl_AntiqueWhite4'),
  (Value: pl_FloralWhite; Name: 'pl_FloralWhite'),
  (Value: pl_GhostWhite; Name: 'pl_GhostWhite'),
  (Value: pl_NavajoWhite; Name: 'pl_NavajoWhite'),
  (Value: pl_NavajoWhite1; Name: 'pl_NavajoWhite1'),
  (Value: pl_NavajoWhite2; Name: 'pl_NavajoWhite2'),
  (Value: pl_NavajoWhite3; Name: 'pl_NavajoWhite3'),
  (Value: pl_NavajoWhite4; Name: 'pl_NavajoWhite4'),
  (Value: pl_OldLace; Name: 'pl_OldLace'),
  (Value: pl_WhiteSmoke; Name: 'pl_WhiteSmoke'),
  (Value: pl_gainsboro; Name: 'pl_gainsboro'),
  (Value: pl_ivory; Name: 'pl_ivory'),
  (Value: pl_ivory1; Name: 'pl_ivory1'),
  (Value: pl_ivory2; Name: 'pl_ivory2'),
  (Value: pl_ivory3; Name: 'pl_ivory3'),
  (Value: pl_ivory4; Name: 'pl_ivory4'),
  (Value: pl_linen; Name: 'pl_linen'),
  (Value: pl_seashell; Name: 'pl_seashell'),
  (Value: pl_seashell1; Name: 'pl_seashell1'),
  (Value: pl_seashell2; Name: 'pl_seashell2'),
  (Value: pl_seashell3; Name: 'pl_seashell3'),
  (Value: pl_seashell4; Name: 'pl_seashell4'),
  (Value: pl_snow; Name: 'pl_snow'),
  (Value: pl_snow1; Name: 'pl_snow1'),
  (Value: pl_snow2; Name: 'pl_snow2'),
  (Value: pl_snow3; Name: 'pl_snow3'),
  (Value: pl_snow4; Name: 'pl_snow4'),
  (Value: pl_wheat; Name: 'pl_wheat'),
  (Value: pl_wheat1; Name: 'pl_wheat1'),
  (Value: pl_wheat2; Name: 'pl_wheat2'),
  (Value: pl_wheat3; Name: 'pl_wheat3'),
  (Value: pl_wheat4; Name: 'pl_wheat4'),
  (Value: pl_white; Name: 'pl_white'),
  (Value: pl_BlanchedAlmond; Name: 'pl_BlanchedAlmond'),
  (Value: pl_DarkGoldenrod; Name: 'pl_DarkGoldenrod'),
  (Value: pl_DarkGoldenrod1; Name: 'pl_DarkGoldenrod1'),
  (Value: pl_DarkGoldenrod2; Name: 'pl_DarkGoldenrod2'),
  (Value: pl_DarkGoldenrod3; Name: 'pl_DarkGoldenrod3'),
  (Value: pl_DarkGoldenrod4; Name: 'pl_DarkGoldenrod4'),
  (Value: pl_LemonChiffon; Name: 'pl_LemonChiffon'),
  (Value: pl_LemonChiffon1; Name: 'pl_LemonChiffon1'),
  (Value: pl_LemonChiffon2; Name: 'pl_LemonChiffon2'),
  (Value: pl_LemonChiffon3; Name: 'pl_LemonChiffon3'),
  (Value: pl_LemonChiffon4; Name: 'pl_LemonChiffon4'),
  (Value: pl_LightGoldenrod; Name: 'pl_LightGoldenrod'),
  (Value: pl_LightGoldenrod1; Name: 'pl_LightGoldenrod1'),
  (Value: pl_LightGoldenrod2; Name: 'pl_LightGoldenrod2'),
  (Value: pl_LightGoldenrod3; Name: 'pl_LightGoldenrod3'),
  (Value: pl_LightGoldenrod4; Name: 'pl_LightGoldenrod4'),
  (Value: pl_LightGoldenrodYellow; Name: 'pl_LightGoldenrodYellow'),
  (Value: pl_LightYellow; Name: 'pl_LightYellow'),
  (Value: pl_LightYellow1; Name: 'pl_LightYellow1'),
  (Value: pl_LightYellow2; Name: 'pl_LightYellow2'),
  (Value: pl_LightYellow3; Name: 'pl_LightYellow3'),
  (Value: pl_LightYellow4; Name: 'pl_LightYellow4'),
  (Value: pl_PaleGoldenrod; Name: 'pl_PaleGoldenrod'),
  (Value: pl_PapayaWhip; Name: 'pl_PapayaWhip'),
  (Value: pl_cornsilk; Name: 'pl_cornsilk'),
  (Value: pl_cornsilk1; Name: 'pl_cornsilk1'),
  (Value: pl_cornsilk2; Name: 'pl_cornsilk2'),
  (Value: pl_cornsilk3; Name: 'pl_cornsilk3'),
  (Value: pl_cornsilk4; Name: 'pl_cornsilk4'),
  (Value: pl_gold; Name: 'pl_gold'),
  (Value: pl_gold1; Name: 'pl_gold1'),
  (Value: pl_gold2; Name: 'pl_gold2'),
  (Value: pl_gold3; Name: 'pl_gold3'),
  (Value: pl_gold4; Name: 'pl_gold4'),
  (Value: pl_goldenrod; Name: 'pl_goldenrod'),
  (Value: pl_goldenrod1; Name: 'pl_goldenrod1'),
  (Value: pl_goldenrod2; Name: 'pl_goldenrod2'),
  (Value: pl_goldenrod3; Name: 'pl_goldenrod3'),
  (Value: pl_goldenrod4; Name: 'pl_goldenrod4'),
  (Value: pl_moccasin; Name: 'pl_moccasin'),
  (Value: pl_yellow; Name: 'pl_yellow'),
  (Value: pl_yellow1; Name: 'pl_yellow1'),
  (Value: pl_yellow2; Name: 'pl_yellow2'),
  (Value: pl_yellow3; Name: 'pl_yellow3'),
  (Value: pl_yellow4; Name: 'pl_yellow4'));
type
  TColorList = array of TColor;
  
  
  procedure ColorToStringList(var StringList:TStrings);

  // isAlt Bedeutet das auch farben wie clred gefunden werden
  function Color2ToString(const Color:TColor;const isAltColor:Boolean = True):String;
  function String2ToColor(const ColorStr:String; const isAltColor:Boolean = True):TColor;

  function RandomColorList(ColorList:array of TColor; noColor:TColor = clNone; const AutoClear:Integer = 10; const TolleranzBereich:Integer = 10):TColor;
  procedure ClearUsrColor;
  
implementation

var
  UsrColor:array of TColor;
  z:Integer = 0;

procedure ColorToStringList(var StringList: TStrings);
var
  i:Integer;
begin
  for i:=0 to High(Colors2) do begin
    Stringlist.Add(Colors2[i].Name);
  end;
end;

function Color2ToString(const Color: TColor; const isAltColor:Boolean = True): String;
var
  i:Integer;
  str:String;
begin
  str:='';
  for i:=0 to High(Colors2) do begin
    if Colors2[i].Value = Color then begin
      str:=Colors2[i].Name;
      break;
    end;
  end;
  
  if (str = '') and (isAltColor) then
    str:=ColorToString(color);
  
  result:=str;
end;

function String2ToColor(const ColorStr:String; const isAltColor: Boolean
  ): TColor;
var
  i:Integer;
  Farbe:TColor;
begin
  Farbe:=clNone;
  
  for i:=0 to High(Colors2) do begin
    if UpperCase(Colors2[i].Name) = upperCase(ColorStr) then begin
      Farbe:=Colors2[i].Value;
      break;
    end;
  end;

  if (Farbe = clNone) and (isAltColor) then
    Farbe:=StringToColor(colorStr);

  result:=Farbe;
end;

function CheckedColorList(const Value:TColor):Boolean;
var
  i:Integer;
  ok:Boolean;
begin
  ok:=False;
  for i:=0 to High(UsrColor) do begin
    if UsrColor[i] = Value then begin
      ok:=True;
      break;
    end;
  end;
  result:=ok;
end;

{
  Diese Funktion bestimmt die Helligkeit/Dunkelheit von Farben
  und berreichnet einen Tolleranz Wert.
  
  Datum: 21.Juli.2007 von guinnes
  http://forum.dsdt.info/viewtopic.php?p=213255#213255

  Vielen Dank Dafür !
}

function CheckColorTol(const Value, Value2:TColor; const Toler:Integer):Boolean;
begin
  Result := (Abs(Red(Value) - Red(Value2)) <= Toler) and
            (Abs(Green(Value) - Green(Value2)) <= Toler) and
            (Abs(Blue(Value) - Blue(Value2)) <= Toler);
end;

function RandomColorList(ColorList:array of TColor; noColor:TColor = clNone; const AutoClear:Integer = 10; const TolleranzBereich:Integer = 10): TColor;
var
  Value:TColor;
  z1:Integer;
  function GetValue:TColor;
  begin
    if High(ColorList) = -1 then begin
      result:=Colors2[Random(High(Colors2))].Value;
    end
    else begin
      result:=ColorList[Random(High(ColorList))];
    end;
  end;

begin
  Value:=GetValue;
// Auf schon verwendet Farben Prüfen
// um die häufigkeit von Farben zu reduzieren
   Randomize;

// Hier wird gepürft ob die Fabre nicht zu dunkel ist zum hintergrund
  if (High(ColorList) = -1) and (not CheckColorTol(Value,noColor,TolleranzBereich)) then begin
    repeat
      Value:=GetValue;
    until (not CheckColorTol(Value,nocolor,TolleranzBereich)) and (not CheckedColorList(Value));
  end
  else begin
    if (High(ColorList) = -1) then begin
      if CheckedColorList(Value) then begin
        z1:=-1;
        repeat
          inc(z1);
          Value:=Colors2[Random(High(Colors2))].Value;
        until (not CheckedColorList(Value)) or (z1 > 16) ;
      end;
    end;
  end;

  if z >= AutoClear then begin
    SetLength(UsrColor,0);
    SetLength(UsrColor,1);
  end
  else
    SetLength(UsrColor,high(UsrColor)+2);

  UsrColor[high(UsrColor)]:=Value;
  result:=Value;
end;

procedure ClearUsrColor;
begin
  SetLength(UsrColor,0);
end;


end.

