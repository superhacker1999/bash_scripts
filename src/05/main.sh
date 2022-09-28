#!/bin/bash

#swap path <-> size
reg='/$'
if ! [ -n "$1" ] ; then
	echo "Error: No parameters found."
	exit 1
fi
if ! [ -d "$1" ] ; then
	echo "Error: No such directory $1"
	exit 1
fi
if ! [[ $1 =~ $reg ]] ; then
	echo "Error: Path should ends with /"
	exit 1
fi

START=$(awk '{print $1}' /proc/uptime)

echo "Total number of folders (including all nested ones) = `ls -lR "$1" | grep -c "^d"`"

echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
echo "1 - `du -h "$1" | sort -hr | awk 'NR == 2{print $2}'`, `du -h "$1" | sort -hr | awk 'NR == 2{print $1}'`"
echo "2 - `du -h "$1" | sort -hr | awk 'NR == 3{print $2}'`, `du -h "$1" | sort -hr | awk 'NR == 3{print $1}'`"
echo "3 - `du -h "$1" | sort -hr | awk 'NR == 4{print $2}'`, `du -h "$1" | sort -hr | awk 'NR == 4{print $1}'`"
echo "4 - `du -h "$1" | sort -hr | awk 'NR == 5{print $2}'`, `du -h "$1" | sort -hr | awk 'NR == 5{print $1}'`"
echo "5 - `du -h "$1" | sort -hr | awk 'NR == 6{print $2}'`, `du -h "$1" | sort -hr | awk 'NR == 6{print $1}'`"

echo "Total number of files = `ls -lR "$1" | grep -c "^-"`"

echo "Number of:"
echo "Configuration file (with the .conf extension = `ls -lR "$1" | grep -c -e ".conf" -e ".cfg"`"
echo "Text files = `ls -lR "$1" | grep -c ".txt"`"
echo "Executable files = `ls -lR "$1" | grep " 1 " | grep -c "[w-]x"`"
echo "Log files (with the extensions .log) = `ls -lR "$1" | grep -c ".log"`"
echo "Archive files = `ls -lR "$1" | grep -c ".tar"`"
echo "Symbolic links = `ls -lR "$1" | grep -c -e "->"`"

echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
string=`find "$1" -type f -not -path '*/\.*' -exec du -h {} + | sort -hr | head -n 10`
IFS=$'\n'
count=0
for i in $string ; do
	((count += 1))
	file=$(echo "$i" | awk '{print $2}')
	size=$(echo "$i" | awk '{print $1}' | sed 's:K: Kb:g' | sed 's:M: Mb:g' | sed 's:G: Gb:g')
	type=$(echo "$i" | awk '{ tp =split($2, type, "."); print type[tp]}')
	echo "$count - $file , $size , $type"
done

echo "TOP 10 executable files ot the maximum size arranged in descending order (path, size and MD5 has of file)"
string1=`find "$1" -type f -executable -not -path '*/\.*' -exec du -h {} + | sort -hr | head -n 10`
count=0
for i in $string1 ; do
	((count += 1))
	path=$(echo "$i" | awk '{print $2}')
	size=$(echo "$i" | awk '{print $1}' | sed 's:K: Kb:g' | sed 's:M: Mb:g' | sed 's:G: Gb:g')
	MD5_hash=$(md5sum "$path" | awk '{print $1}')
	echo "$count - $path , $size , $MD5_hash"
done


END=$(awk '{print $1}' /proc/uptime)
DIFF=`bc <<<"scale=1; $END - $START"`
echo "Script execution time (in seconds) = $DIFF"
exit 0
