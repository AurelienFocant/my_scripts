#! /bin/bash

for dir in */; do
	echo "-----------------------------------------------"
	if [ -d $dir/.git ]; then
		echo "Entering $dir"
		cd $dir
		echo "Fetching data from remote"
		git fetch -v
		echo ""
		echo "Checking git status"
		git status -v
		echo "Exiting $dir"
		cd ..
	else
		echo "Not a GIT directory: $dir"
	fi
	echo "-----------------------------------------------"
done

echo ""
echo ""
