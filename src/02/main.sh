#!bin/bash
source output.sh

hostname="HOSTNAME = `hostname`"

timezone="TIMEZONE = `< /etc/timezone`"

user="USER = $USER"

os="OS = `uname -mrs`"

date="DATE = `date +"%d %B %Y %H:%M:%S"`"

uptime="UPTIME = `uptime -p`"

uptime_sec=$(awk '{print $1}' /proc/uptime)
uptime_sec="UPTIME_SEC = $uptime_sec"

ip="IP = `hostname -I`"

mask=$(ip a | grep dynamic | awk '{print $4}')
mask="MASK = $mask"

gateway=$(ip route | awk '/default/ { print $3 }')
gateway="GATEWAY = $gateway"

ram_tot=$(awk '/MemTotal:/ {print $2}' /proc/meminfo)
ram_free=$(awk '/MemFree:/ {print $2}' /proc/meminfo)

ram_tot=`bc <<<"scale=3; $ram_tot / 1048576"`
ram_free=`bc <<<"scale=3; $ram_free / 1048576"`
ram_used=`bc <<<"scale=3; $ram_tot - $ram_free"`

ram_tot="RAM_TOT = $ram_tot GB"
ram_free="RAM_FREE = $ram_free GB"
ram_used="RAM_USED = $ram_used GB"

space_root=$(df / | grep / | awk '{print $2}')
space_root_used=$(df / | grep / | awk '{print $3}')

space_root=`bc <<<"scale=2; $space_root / 1024"`
space_root_used=`bc <<<"scale=2; $space_root_used / 1024"`
space_root_free=`bc <<<"scale=2; $space_root - $space_root_used"`


space_root_used="SPACE_ROOT_USED = $space_root_used MB"
space_root="SPACE_ROOT =  $space_root MB"
space_root_free="SPACE_ROOT_FREE =  $space_root_free MB"

output "$hostname" "$timezone" "$user" "$os" "$date" "$uptime"
output "$uptime_sec" "$ip" "$mask" "$gateway" "$ram_tot" "$ram_used" "$ram_free"
output "$space_root" "$space_root_used" "$space_root_free"
read -p "Do you want to save data in file? type [Y/N]" answer
if [ "$answer" == Y ] || [ "$answer" == y ] ; then
filename="`date +"%d_%m_%Y_%H_%M_%S"`.status"
output "$hostname" "$timezone" "$user" "$os" "$date" "$uptime" >> "$filename"
output "$uptime_sec" "$ip" "$mask" "$gateway" "$ram_tot" "$ram_used" "$ram_free" >> "$filename"
output "$space_root" "$space_root_used" "$space_root_free" >> "$filename"
fi
exit 0
