#! /bin/bash

if [ -d ./src ]; then

	[ ! -d ./misc ] && mkdir -p misc
	cd ./misc
	[ -f tags ] && rm tags

if uname | grep --quiet Linux; then
	find -L .. -type f \( -name "*.c" -o -name "*.h" \) \
		-exec sed -i 's/# define/#define/g' {} \; \
		-exec ctags -a {} \; \
		-exec sed -i 's/#define/# define/g' {} \;
else
	find -L .. -type f \( -name "*.c" -o -name "*.h" \) \
		-exec sed -i "" 's/# define/#define/g' {} \; \
		-exec ctags -adtw {} \; \
		-exec sed -i "" 's/#define/# define/g' {} \;
fi

	sort tags -o tags

	echo "Tags file created"

	cd ..

else
	echo "You are not in a valid project directory"
fi
