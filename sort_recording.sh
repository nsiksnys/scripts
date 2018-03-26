#!/bin/bash

SEARCH="Audios"
DESTINY=$(date +%Y)
NAMES=("")

function main
{
	searchDir=$1
	parentToDir=$2
	rootDir=$PWD
	
	echo $rootDir
	cd $rootDir/"$searchDir"
	for file in $(ls -1)
	do
		date=$(echo $file | cut -f 1 -d '_')
		time=$(echo $file | cut -f 2 -d '_' | cut -f 1 -d '-')
		
		if date -d "$date" > /dev/null 2>&1; then
			echo $file " not a valid file!"
			continue #process next file
		fi
	
		dow=$(echo $(date -d "$date" +%u)) #day of week (1: monday - 7: sunday)
		if [[ ${NAMES[$dow]+yes} == 'yes' ]]; then #valid name for given day of week in array
			dir=${NAMES[$dow]}
		else
			if date -d "$date" > /dev/null 2>&1; then #valid date
				day=$(echo $(date -d "$date" '+%A'))
				
				if [ $time -lt 12 ]; then
				  shift='morning'
				elif [ $time -lt 18 ]; then
				  shift='afternoon'
				else
				  shift='evening'
				fi

				dir=$day"_"$shift #eg: Tuesday_evening
			fi
		fi
		
		if [[ ${dir:-no} == 'no' ]]; then #no folder name set
			echo "No folder name set!"
			continue #process next file
		fi

		#destiny folder (files will be moved here)
		if [ -n "$parentToDir" ]; then #if there is a parent destiny folder set
			if [ ! -d $rootDir/"$parentToDir" ]; then #if the folder doesn't exist
				mkdir $rootDir/"$parentToDir" #create it
			fi
			cd $rootDir/"$parentToDir" #change to parent destiny folder
		fi

		if [ ! -d "$dir" ]; then #if destiny folder doesn't exist
			mkdir "$dir" #create it
		fi
			
		mv $rootDir/$searchDir/$file "$dir"
		echo $rootDir/$searchDir/$file" => "$dir
		cd
	done
}

main ${1:-$SEARCH} ${2:-$SEARCH}
exit
