#! /bin/bash

source my_ansi_colors
source git_wrappers.sh

if [ -d .git ]; then
	git_fetch_and_status
else
	# Loop through each subdirectory in the current directory
	for dir in */; do
		# Check if the directory contains a .git folder
		if [ -d $dir/.git ]; then
			cd $dir
			git_fetch_and_status
			cd ..
		else
			echo "not in a git repo"
		fi
	done
fi
