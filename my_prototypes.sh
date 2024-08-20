#!/bin/bash

src_dir="./src"

if [ -d  $src_dir ]; then 

	[ ! -d includes ] && mkdir includes
	echo "${PWD##*/}" | sed -E 's/[1-9]_//g' | awk '{print "#include " "\"" $0 ".h\""}' >includes/prototypes.h

	find $src_dir -type f -name "*.c" \
		-exec sh -c \
		'echo "\n/*----------------  ${1##*/}  ---------------*/"; \
		grep -E "^[[:space:]]*([a-zA-Z_*]+[[:space:]]+){1,2}[a-zA-Z_*]+\([^\)]*\)" $1 \
		| grep -vE "^[[:space:]]*static[[:space:]]+" \
		| grep -vE "[[:space:]]*main\(" \
		| sed "s/$/:;/";' \
		_ {} \; \
	   	>>includes/prototypes.h 2>/dev/null

else
	echo "You are not in a valid project directory"
fi
