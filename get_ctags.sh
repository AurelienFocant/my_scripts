#! /bin/bash

if [ -d ./src ]; then

	if [ ! -d ./misc ]; then
		mkdir -p misc
	fi

	cd ./misc
	find .. -type f -name "*.c" \
		-exec ctags -adtw {} \; \
	&& \
	find .. -type f -name "*.h" \
		-exec sed -i="" 's/# define/#define/g' {} \; \
		-exec ctags -adtw {} \; \
		-exec sed -i="" 's/#define/# define/g' {} \; \
	&& \
	echo "Tags file created"
	cd ..

else
	echo "You are not in a valid project directory"
fi
