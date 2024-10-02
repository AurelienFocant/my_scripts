#!/bin/sh

# /******
# *
# * Credits to : Jveirman from 19 Brussels for the regex and the idea
# *
# ******/

# known issue: 
	# doesnt work if there's a newline in the function name 
	# because grep works on a line by line basis
# known issue: 
	# does not tab-align function names according to 19 norm
	# ... I'm not good enough at AWK yet ...


inc_dir="./include"
project=$(echo "${PWD##*/}" | sed -E 's/[1-9]_//g')
filename="prototypes_${project}"
header_file="${inc_dir}/${filename}"
header_upper=$(echo ${filename} | awk '{print toupper($0) }')

src_dir="$1"
if [ -z "$src_dir" ]; then
	src_dir="./src"
fi


function extract_prototypes {
	find $src_dir -type f -name "*.c" \
		-exec sh -c \
			'echo "\n/*----------------  ${1##*/}  ---------------*/"; \
			grep -E "^[[:space:]]*([a-zA-Z_*]+[[:space:]]+){1,2}[a-zA-Z_*]+\((.|[[:space:]])*\)" $1 \
			| grep -vE "^[[:space:]]*static[[:space:]]+" \
			| grep -vE "[[:space:]]*main\(" \
			| sed "s/$/;/"
			' _ {} \; \
		>>${header_file}.h 2>/dev/null
}

function create_prototype_file {
		[ ! -d ${inc_dir} ] && mkdir ${inc_dir}
		printf "#ifndef ${header_upper}_H\n# define ${header_upper}_H\n\n" >${header_file}.h
		printf ${project} | awk '{print "# include " "\"" $0 ".h\""}' >>${header_file}.h
		extract_prototypes
		printf "\n#endif\n" >>${header_file}.h
}


function get_prototypes {
	if [ -d  $src_dir ]; then 
		create_prototype_file
	else
		echo "There is no src directory"
	fi
}

get_prototypes
