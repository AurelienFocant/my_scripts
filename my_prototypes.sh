#!/bin/bash

src_dir="./src"
inc_dir="./includes"
project=$(echo "${PWD##*/}" | sed -E 's/[1-9]_//g')
header_f="${inc_dir}/prototypes_${project}"

if [ -d  $src_dir ]; then 

	[ ! -d ${inc_dir} ] && mkdir ${inc_dir}
	echo ${project} | awk '{print "#include " "\"" $0 ".h\""}' >${header_f}.h

	find $src_dir -type f -name "*.c" \
		-exec sh -c \
		'echo "\n/*----------------  ${1##*/}  ---------------*/"; \
		grep -E "^[[:space:]]*([a-zA-Z_*]+[[:space:]]+){1,2}[a-zA-Z_*]+\([^\)]*\)" $1 \
		| grep -vE "^[[:space:]]*static[[:space:]]+" \
		| grep -vE "[[:space:]]*main\(" \
		| sed "s/$/;/";' \
		_ {} \; \
	   	>>${header_f}.h 2>/dev/null

else
	echo "There is no src directory"
fi

src_dir="./src_bonus"
inc_dir="./includes_bonus"

if [ -d  $src_dir ]; then 

	[ ! -d ${inc_dir} ] && mkdir ${inc_dir}
	echo ${project} | awk '{print "#include " "\"" $0 ".h\""}' >${header_f}_bonus.h

	find $src_dir -type f -name "*.c" \
		-exec sh -c \
		'echo "\n/*----------------  ${1##*/}  ---------------*/"; \
		grep -E "^[[:space:]]*([a-zA-Z_*]+[[:space:]]+){1,2}[a-zA-Z_*]+\([^\)]*\)" $1 \
		| grep -vE "^[[:space:]]*static[[:space:]]+" \
		| grep -vE "[[:space:]]*main\(" \
		| sed "s/$/;/";' \
		_ {} \; \
	   	>>${header_f}_bonus.h 2>/dev/null

else
	echo "There is no src_bonus directory"
fi
