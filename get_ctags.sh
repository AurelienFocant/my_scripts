#! /bin/bash

if [ -d ./src ]; then

	[ ! -d ./misc ] && mkdir -p misc
	cd ./misc
	[ -f tags ] && rm tags

	find .. -type f \( -name "*.c" -o -name "*.h" \) \
		-exec sed -i "" 's/# define/#define/g' {} \; \
		-exec ctags -adtw {} \; \
		-exec sed -i "" 's/#define/# define/g' {} \; \
	&& \
	echo "Tags file created"

	cd ..

else
	echo "You are not in a valid project directory"
fi
