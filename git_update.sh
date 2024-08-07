#! /bin/bash

red='\033[0;31m'
white='\033[0;37m'

git_fetch_and_status () {
	echo ""
	echo "-----------------------------------------------"
	echo "$PWD"

	echo "Fetching changes from remote"
	git fetch
	echo ""

	echo "Checking git status..."
	git status -v
	if git status -v | grep --quiet "behind\|ahead\|diverged"; then
		echo -e "${red}You are not up to date${white}"
	fi

	echo "$PWD"
	echo "-----------------------------------------------"
	echo ""
}

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
		fi
	done
fi
