#! /bin/bash

for dir in */; do
	echo ""
	echo "-----------------------------------------------"
	if [ -d $dir/.git ]; then
		echo "Entering $PWD/$dir"
		cd $dir
		echo "Fetching data from remote"
		git fetch -v
		echo ""
		echo "Checking git status"
		git status -v
		cd ..
		echo "Exiting $PWD/$dir"
	else
		echo "Not a GIT directory: $dir"
	fi
	echo "-----------------------------------------------"
done

echo ""
