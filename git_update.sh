#! /bin/bash

# Loop through each subdirectory in the current directory
for dir in */; do
	# Check if the directory contains a .git folder
	if [ -d $dir/.git ]; then
		echo ""
		echo "-----------------------------------------------"
		echo "Entering $PWD/$dir"
		cd $dir

		#Execute git fetch and git status
		echo "Fetching data from remote..."
		git fetch -v
		echo ""

		echo "Checking git status..."
		git status -v

		#Return to the parent directory
		cd ..
		echo "Exiting $PWD/$dir"
		#else
		#	echo "Not a GIT directory: $dir"
		echo "-----------------------------------------------"
	fi
done

echo ""
