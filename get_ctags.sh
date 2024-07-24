#! /bin/bash

if [ -d ./src ]; then

	if [ ! -d ./misc ]; then
		mkdir -p misc
	fi

	cd ./misc
	ctags ../src/*.c
	ctags -a ../src/*/*.c 2>/dev/null
	echo "Tags file created"
	cd ..

else
	echo "You are not in a valid project directory"
fi
