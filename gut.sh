#! /bin/bash

red='\033[0;31m'
white='\033[0;37m'

branches=$(git branch -vv \
	| awk '{ 
		if ($1=="*")	{print $2}
		else			{print $1}
			}'
)

for branch in $branches;
do
	echo "--------------------------------------"
	git checkout $branch --quiet
	git status
	echo ""
	git branch -vv --color=always | grep $branch --color=never
	echo "--------------------------------------"
done
