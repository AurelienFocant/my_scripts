#! /bin/bash

if [ -d ./misc ] && [ -d ./src ]; then
	cd ./misc
	ctags ../src/*.c
	ctags -a ../src/*/*.c
	cd ..
else
	echo "You are not in a valid project directory"
fi
