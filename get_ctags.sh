#! /bin/bash

src_dir="${1:-src}"
inc_dir="${2:-include}"
libft_dir="${3:-libft}"

if [ -d $src_dir ]; then

	[ ! -d ./misc ] && mkdir -p misc
	cd ./misc
	[ -f tags ] && rm tags

	if ctags --version 2>/dev/null | grep --quiet Universal; then
		ctags -R --sort=yes ../${inc_dir} ../${src_dir} ../${libft_dir}

	elif ! ctags --version 2>/dev/null; then
		find -L ../${inc_dir} ../${src_dir} ../${libft_dir} -type f \( -name "*.c" -o -name "*.h" \) \
			-exec sed -i "" 's/# define/#define/g' {} \; \
			-exec ctags -adtw {} \; \
			-exec sed -i "" 's/#define/# define/g' {} \;
		[ -f tags ] && sort tags -o tags || echo "Tags creation has failed"
	fi

	cd ..

else
	echo "You are not in a valid project directory"
fi
