#!bin/bash

source ../02/output.sh

if ! [ -n "$1" ] || ! [ -n "$2" ] || ! [ -n "$3" ] || ! [ -n "$4" ] ; then
    echo "Error: too few arguments"
    exit 1
else
    if [ "$1" == "$2" ] || [ "$3" == $4 ] ; then
        echo "Error: No equal colors are allowed. Rerun with different"
        exit 1
    else
        color1=$1;
        color2=$2;
        color3=$3;
        color4=$4;
    fi
fi

case "$color1" in
    1 ) color1="\033[37m" ;;
    2 ) color1="\033[31m" ;;
    3 ) color1="\033[32m" ;;
    4 ) color1="\033[36m" ;;
    5 ) color1="\033[35m" ;;
    6 ) color1="\033[30m" ;;
    * ) echo "Error: Colors must be in a range [1 - 6]" ; exit 1 ;;
esac
case "$color3" in
    1 ) color3="\033[37m" ;;
    2 ) color3="\033[31m" ;;
    3 ) color3="\033[32m" ;;
    4 ) color3="\033[36m" ;;
    5 ) color3="\033[35m" ;;
    6 ) color3="\033[30m" ;;
    * ) echo "Error: Colors must be in a range [1 - 6]" ; exit 1 ;;
esac
case "$color2" in
    1 ) color2="\033[47m" ;;
    2 ) color2="\033[41m" ;;
    3 ) color2="\033[42m" ;;
    4 ) color2="\033[46m" ;;
    5 ) color2="\033[45m" ;;
    6 ) color2="\033[40m" ;;
    * ) echo "Error: Colors must be in a range [1 - 6]" ; exit 1 ;;
esac
case "$color4" in
    1 ) color4="\033[47m" ;;
    2 ) color4="\033[41m" ;;
    3 ) color4="\033[42m" ;;
    4 ) color4="\033[46m" ;;
    5 ) color4="\033[45m" ;;
    6 ) color4="\033[40m" ;;
    * ) echo "Error: Colors must be in a range [1 - 6]" ; exit 1 ;;
esac
color1="$color1$color2"
color2=""$color3$color4""
no_color="\033[0m"

hostname="${color1}HOSTNAME${no_color} = ${color2}`hostname`"

timezone="${color1}TIMEZONE${no_color} = ${color2}Europe/Moscow UTC +3"

user="${color1}USER${no_color} = ${color2}`uname`"

os="${color1}OS${no_color} = ${color2}`uname -mrs`"

date="${color1}DATE${no_color} = ${color2}`date +"%d %B %Y %H:%M:%S"`"

uptime="${color1}UPTIME${no_color} = ${color2}`uptime -p`"

uptime_sec=$(awk '{print $1}' /proc/uptime)
uptime_sec="${color1}UPTIME_SEC${no_color} = ${color2}$uptime_sec"

ip="${color1}IP${no_color} = ${color2}`hostname -I`"

mask=$(ip a | grep dynamic | awk '{print $4}')
mask="${color1}MASK${no_color} = ${color2}$mask"

gateway=$(ip route | awk '/default/ { print $3 }')
gateway="${color1}GATEWAY${no_color} = ${color2}$gateway"

ram_tot=$(awk '/MemTotal:/ {print $2}' /proc/meminfo)
ram_free=$(awk '/MemFree:/ {print $2}' /proc/meminfo)

ram_tot=`bc <<<"scale=3; $ram_tot / 1048576"`
ram_free=`bc <<<"scale=3; $ram_free / 1048576"`
ram_used=`bc <<<"scale=3; $ram_tot - $ram_free"`

ram_tot="${color1}RAM_TOT${no_color} = ${color2}$ram_tot GB"
ram_free="${color1}RAM_FREE${no_color} = ${color2}$ram_free GB"
ram_used="${color1}RAM_USED${no_color} = ${color2}$ram_used GB"

space_root=$(df / | grep / | awk '{print $2}')
space_root_used=$(df / | grep / | awk '{print $3}')

space_root=`bc <<<"scale=2; $space_root / 1024"`
space_root_used=`bc <<<"scale=2; $space_root_used / 1024"`
space_root_free=`bc <<<"scale=2; $space_root - $space_root_used"`


space_root_used="${color1}SPACE_ROOT_USED${no_color} = ${color2}$space_root_used MB"
space_root="${color1}SPACE_ROOT${no_color} = ${color2}$space_root MB"
space_root_free="${color1}SPACE_ROOT_FREE${no_color} = ${color2}$space_root_free MB"

output "$hostname" "$timezone" "$user" "$os" "$date" "$uptime"
output "$uptime_sec" "$ip" "$mask" "$gateway" "$ram_tot" "$ram_used" "$ram_free"
output "$space_root" "$space_root_used" "$space_root_free"
echo -e "${no_color}"
exit 0
