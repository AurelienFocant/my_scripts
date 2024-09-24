#!/bin/bash

inc_dir="./include"
project=$(echo "${PWD##*/}" | sed -E 's/[1-9]_//g')
name="prototypes_${project}"
header_file="${inc_dir}/${name}"
header_upper=$(echo ${name} | awk '{print toupper($0) }')

src_dir="$1"
if [ -z "$src_dir" ]; then
	src_dir="./src"
fi

if [ -d  $src_dir ]; then 

	[ ! -d ${inc_dir} ] && mkdir ${inc_dir}
	printf "#ifndef ${header_upper}_H\n# define ${header_upper}_H\n\n" >${header_file}.h

	printf ${project} | awk '{print "# include " "\"" $0 ".h\""}' >>${header_file}.h

# the rexeg doesnt work if theres a \n in the function name because grep functions on a line by line basis
	find $src_dir -type f -name "*.c" \
		-exec sh -c \
			'echo "\n/*----------------  ${1##*/}  ---------------*/"; \
			grep -E "^[[:space:]]*([a-zA-Z_*]+[[:space:]]+){1,2}[a-zA-Z_*]+\((.|[[:space:]])*\)" $1 \
			| grep -vE "^[[:space:]]*static[[:space:]]+" \
			| grep -vE "[[:space:]]*main\(" \
			| sed "s/$/;/"
			' _ {} \; \
		>>${header_file}.h 2>/dev/null

	printf "\n#endif\n" >>${header_file}.h

else
	echo "There is no src directory"
fi


/******
*
* Credits to : Jveirman from 19 Brussels for the regex and the idea
*
******/
