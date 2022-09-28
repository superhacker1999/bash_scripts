#!bin/bash
re='^[0-9]+$'
if ! [ -n "$1" ] ; then
	echo "Error: No arguments found"
	exit 1
else
	if [[ $1 =~ $re ]] ; then
		echo "Error: This is a number"
		exit 1
	else
		echo "$1"
	fi
fi
exit 0