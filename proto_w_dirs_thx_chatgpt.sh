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
    last_subdir=""
    find $src_dir -type f -name "*.c" | while read -r file; do
        current_subdir=$(dirname "$file")  # Get the current subdirectory
        current_subdir=${current_subdir##*/}  # Extract the last part of the path

        # Print the subdirectory name if it's different from the last one
        if [ "$current_subdir" != "$last_subdir" ]; then
            echo "\n/*----------------  $current_subdir  ---------------*/"
            last_subdir="$current_subdir"  # Update last printed subdirectory
        fi
        
        # Print the file name
        echo "/* File: ${file##*/} */"
        
        # Extract and print function prototypes from the current file
        grep -E "^[[:space:]]*([a-zA-Z_*]+[[:space:]]+){1,2}[a-zA-Z_*]+\((.|[[:space:]])*\)" "$file" \
            | grep -vE "^[[:space:]]*static[[:space:]]+" \
            | grep -vE "[[:space:]]*main\(" \
            | sed "s/$/;/"

		echo ""

    done >> "${header_file}.h" 2>/dev/null
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
