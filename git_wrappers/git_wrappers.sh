#! /bin/bash

source my_ansi_colors

git_status_colored_branch () {
	current_branch=$(git branch --show-current)		
	echo -e "On branch ${green}${current_branch}${no_color}"
	git_status_check_sync
	git -c color.status=always status | awk 'NR > 1'
}

git_status_check_sync () {
	if git status -v | grep --quiet "behind\|ahead\|diverged"; then
		echo -e "${red}This branch is not in sync with its remote${no_color}"
		fi
}

print_pwd () {
	len_pwd=${#PWD}
	char='#'
	len=$((len_pwd + 4))

    printf "%0.s$char" $(seq 1 "$len")
    printf "\n"
    printf "# ${orange}${PWD}${no_color} #\n"
    printf "%0.s$char" $(seq 1 "$len")
    printf "\n"
}

git_check_branches () {
	git branch -avv --color=always | awk '
	{
		if ($0 ~ /\[.*(ahead|behind|diverge).*]/) {
			sub(/\] .*/, "] \033[31mthis branch is not in sync with its remote\033[0m");
			print $0;
		} else {
			print $0;
		}
	}'
}

git_fetch_and_status () {
    printf "\n"
	print_pwd
	for remote in $(git remote -v | awk '{print $1}' | uniq); do
		git fetch -v ${remote}
		printf "\n"
	done
	git_status_colored_branch
	printf "\n"
	git_check_branches
	printf "%0.s$char" $(seq 1 "$len")
	printf "\n"
}
