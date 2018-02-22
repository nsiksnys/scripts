#!/bin/bash

function main
{
	searchDir=$1
	parentToDir=$2
	for filename in $(ls -1 $searchDir)
	do
		filedate=$(echo $filename | cut -f 1 -d '_')
		filetime=$(echo $filename | cut -f 2 -d '_' | cut -f 1 -d '-')

		#if date is valid
		if date -d "$filedate" > /dev/null 2>&1; then
			day=$(echo $(date -d "$filedate" '+%A'))
			
			#just in case date +%p does not work
			if [ $filetime -lt 12 ]; then
			  div='am'
			else
			  div='pm'
			fi

			toDir=$day"_"$div

			if [ -n "$parentToDir" ]; then
				if [ ! -d "$parentToDir" ]; then
					mkdir $parentToDir
				fi
			    cd $parentToDir
			else
				cd $searchDir
			fi

			if [ ! -d "$toDir" ]; then
				mkdir $toDir
			fi
				
			mv $filename $toDir
			echo $filename" => "$toDir
			cd
		fi
	done
}

main $1 $2
exit
