#!/bin/bash

color1="`grep column1_back color.cfg`"
color2="`grep column1_font color.cfg`"
color3="`grep column2_back color.cfg`"
color4="`grep column2_font color.cfg`"

color1="${color1:19}"
color2="${color2:19}"
color3="${color3:19}"
color4="${color4:19}"

flag1=0
flag2=0
flag3=0
flag4=0
if [ "$color1" == "" ] ; then
    flag1=1
    color1=4
fi

if [ "$color2" == "" ] ; then
    flag2=1
    color2=2
fi

if [ "$color3" == "" ] ; then
    flag3=1
    color3=4
fi

if [ "$color4" == "" ] ; then
    flag4=1
    color4=2
fi

bash ../03/main.sh $color2 $color1 $color4 $color3

if [ "$flag1" == "1" ] ; then
    color1="Column 1 background = default (blue)"
else
    case "$color1" in
        1 ) color1="Column 1 background = 1 (white)" ;;
        2 ) color1="Column 1 background = 2 (red)" ;;
        3 ) color1="Column 1 background = 3 (green)" ;;
        4 ) color1="Column 1 background = 4 (blue)" ;;
        5 ) color1="Column 1 background = 5 (purple)" ;;
        6 ) color1="Column 1 background = 6 (black)" ;;
    esac
fi

if [ "$flag2" == "1" ] ; then
    color2="Column 1 background = default (red)"
else
    case "$color2" in
        1 ) color2="Column 1 font color = 1 (white)" ;;
        2 ) color2="Column 1 font color = 2 (red)" ;;
        3 ) color2="Column 1 font color = 3 (green)" ;;
        4 ) color2="Column 1 font color = 4 (blue)" ;;
        5 ) color2="Column 1 font color = 5 (purple)" ;;
        6 ) color2="Column 1 font color = 6 (black)" ;;
    esac
fi

if [ "$flag3" == "1" ] ; then
    color3="Column 2 font color = default (blue)"
else
    case "$color3" in
        1 ) color3="Column 2 background = 1 (white)" ;;
        2 ) color3="Column 2 background = 2 (red)" ;;
        3 ) color3="Column 2 background = 3 (green)" ;;
        4 ) color3="Column 2 background = 4 (blue)" ;;
        5 ) color3="Column 2 background = 5 (purple)" ;;
        6 ) color3="Column 2 background = 6 (black)" ;;
    esac
fi

if [ "$flag4" == "1" ] ; then
    color4="Column 2 background = default (red)"
else
    case "$color4" in
        1 ) color4="Column 2 font color = 1 (white)" ;;
        2 ) color4="Column 2 font color = 2 (red)" ;;
        3 ) color4="Column 2 font color = 3 (green)" ;;
        4 ) color4="Column 2 font color = 4 (blue)" ;;
        5 ) color4="Column 2 font color = 5 (purple)" ;;
        6 ) color4="Column 2 font color = 6 (black)" ;;
    esac
fi

echo "$color1"
echo "$color2"
echo "$color3"
echo "$color4"
exit 0