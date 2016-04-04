#!/bin/bash
#Searches for a function and shows filename(s), line(s) and line number(s)

#$1 name of the function
#$2 file or folder to exclude (by default the files starting with ".#" and containg ".old" are excluded)

search()
{
	for i in $(grep -Rl "${1}" --exclude=".#*" --exclude="*.old*" ${2} $DIRECTORY); do
		echo $(echo $i | tr [a-z] [A-Z]) #file name to upper case
		grep -n "${1}" $i #show matching line(s) and line number(s)
		echo
	done
}

DIRECTORY=""
if /usr/bin/test "$DIRECTORY" = ""
then
 	echo -en "Error: search directory not set!\n"
	exit 1
fi
if [ ! -d "$DIRECTORY" ]; then
  echo -en "Error: search directory does not exist!\n"
  exit 1
fi

if /usr/bin/test "${1}" = ""
then
 	echo -en "Error: no function specified!\n"
	exit 1
fi

RESULT="search-"${1}

echo -en 'grep -Rl '${1}' --exclude=".#*" --exclude="*.old*" '${2}' '$DIRECTORY' \nSaving serch result(s) to '$RESULT'.txt\n'

search ${1} ${2} > $RESULT.txt
