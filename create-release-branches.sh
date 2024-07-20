#!/bin/bash

# Prepare modules for release
# This script creates the release branch for each module that has a given develop branch

# Argument:
# $1: release tag. Eg: 2024.01

# Variables
MODULES=$HOME/git/modules
DEVELOP_BRANCH=9.x-develop
ORIGIN=$PWD
RELEASE="release/$1.x"

cd $MODULES
for module in $(ls -1 $PWD)
do
	cd $module
	echo $module
	# Do we have a develop branch at all?
	if [[ $(git branch -a | grep $DEVELOP_BRANCH -c ) == 0 ]]
	then
		echo "No $DEVELOP_BRANCH branch for $module. Skipping..."
	else
		# Show the branch we're sitting on
		git status | head -n 1
		# Is it on the develop branch at the moment?
		if [[ $(git branch | grep "* $DEVELOP_BRANCH" -c ) == 0 ]]
		then
			git checkout $DEVELOP_BRANCH
		fi
		# Bring the latest changes (but with no output)
		git pull --quiet
		# Does the last commit in develop coincides with the latest tag?
		# If it does, then nothing was added.
		# Otherwise, create the release branch and push it.
		if [[ $(git log -1 | grep $(git tag --sort=-v:refname | head -n 1) -c )  == 0 ]]
		then
			git checkout -b $RELEASE
			git push -u origin $RELEASE
		else
			echo "No changes in $module. Skipping..."
		fi
	fi
	cd ../
done
cd $ORIGIN
