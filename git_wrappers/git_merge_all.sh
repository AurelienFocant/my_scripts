#! /bin/sh

# needs to be much better thanthis and source all the other functions
# to be able to visualy compartiment every directory

for dir in $PWD/*; do
	cd $dir
	[ -d .git ] && git merge
	cd ..
done
