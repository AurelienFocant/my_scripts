#!/bin/bash

project=$(echo "${PWD##*/}" | sed -E 's/[1-9]_//g')
#src_dir="./src"
inc_dir="./includes"
header_file="${inc_dir}/prototypes_${project}"

src_dir="$1"
if [ -z "$dir" ]; then
	src_dir="./src"
fi

if [ -d  $src_dir ]; then 

	[ ! -d ${inc_dir} ] && mkdir ${inc_dir}
	echo ${project} | awk '{print "#include " "\"" $0 ".h\""}' >${header_file}.h

	find $src_dir -type f -name "*.c" \
		-exec sh -c \
		'echo "\n/*----------------  ${1##*/}  ---------------*/"; \
		grep -E "^[[:space:]]*([a-zA-Z_*]+[[:space:]]+){1,2}[a-zA-Z_*]+\([^\)]*\)" $1 \
		| grep -vE "^[[:space:]]*static[[:space:]]+" \
		| grep -vE "[[:space:]]*main\(" \
		| sed "s/$/;/";' \
		_ {} \; \
		>>${header_file}.h 2>/dev/null

else
	echo "There is no src directory"
fi
