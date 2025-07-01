#!/bin/bash

#################################################################################
#			Sould be executed in the main directory of your C project			#
#################################################################################

#################################################################################
#	This script is intented to facilitate prototyping software in C				#
#	Every time you write a new function, [in a new file],						#
#	[In a new subdirectory], in your source_files directory						#
#	It will update (== create) a header file with all function prototypes.		#
#	You can now just #include this prototype_file.h in your main header file	#
#################################################################################


# You can specify the source_files directory as 1st argument
# If not, it will be called "src" by default
src_dir="${1:-src}"

# The name of the project is the name of the directory in which you execute the script
# Bar some numbers that I personally use for faster shell completion
project=$(echo "${PWD##*/}" | sed -E 's/^[1-9]_//g')

# All header files to be in this directory
inc_dir="./include"

# File names
filename="prototypes_${project}"
header_file="${inc_dir}/${filename}"
header_upper=$(echo "${filename}" | awk '{print toupper($0)}')
last_subdir=""


extract_prototypes() {
    find $src_dir -type f | sort | while read -r file; do

	 	# Get the current subdirectory
        current_subdir=$(dirname "$file") 

        # Print the subdirectory name if it's different from the last one
		# Update last printed subdirectory
        if [ "$current_subdir" != "$last_subdir" ]; then
            printf "\n/*----------------  $current_subdir  ---------------*/\n"
            last_subdir="$current_subdir"
        fi

        # Print the file name
        printf "/* File: ${file##*/} */\n"

        # Extract and print function prototypes from the current file
        grep -E "^[[:space:]]*([0-9a-zA-Z_*]+[[:space:]]+){1,2}[0-9a-zA-Z_*]+\((.|[[:space:]])*\)" "$file" \
            | grep -E -v "[[:space:]]*main\(" \
			| grep -E -v "^[[:space:]]*static[[:space:]]+" \
            | sed "s/$/;/"

		# Print newline
		printf "\n"
    done
}


create_prototype_file() {
	# Create ./include directory if it doesn't exist yet
	[ -d ${inc_dir} ] || mkdir ${inc_dir}

	printf "#ifndef ${header_upper}_H\n"	> ${header_file}.h
	printf "# define ${header_upper}_H\n"	>>${header_file}.h
	printf "\n"								>>${header_file}.h
	printf "#include \"${project}.h\"\n"	>>${header_file}.h
	extract_prototypes						>>${header_file}.h 2>/dev/null
	printf "#endif\n"						>>${header_file}.h
}


get_prototypes() {
	if [ -d  $src_dir ]; then 
		create_prototype_file
	else
		echo "There is no source files directory"
	fi
}

get_prototypes


##############################################################################################################

# /******
# *
# * Credit to : Jveirman from 19 Brussels for the regex and the idea
# *
# ******/

# known issue:
	# doesnt work if there's a newline in the function name 
	# because grep works on a line by line basis
# known issue:
	# in case of existing file with no elligible function
	# eg. a file with only a main function
	# the script will still write the file name in the header file
# known issue:
	# if you want to declare structs in your main header file
	# you'll have to include the prototype file after those
	# and 1942 norm does not like this
	# you'll have to reformat everything before push
# known issue:
	# does not tab-align function names according to 1942 norm
	# ... I'm not good enough at AWK yet ...
