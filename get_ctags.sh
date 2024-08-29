#! /bin/bash

src_dir="$1"
if [ -z "$src_dir" ]; then
	src_dir="src"
fi

inc_dir="includes"
libft_dir="libft"

if [ -d $src_dir ]; then

	[ ! -d ./misc ] && mkdir -p misc
	cd ./misc
	[ -f tags ] && rm tags

	if ctags --version | grep --quiet Exuberant; then
		find -L ../${inc_dir} ../${src_dir} ../${libft_dir} -type f \( -name "*.c" -o -name "*.h" \) \
			-exec ctags -a {} \;
	else
		find -L ../${inc_dir} ../${src_dir} ../${libft_dir}  -type f \( -name "*.c" -o -name "*.h" \) \
			-exec sed -i "" 's/# define/#define/g' {} \; \
			-exec ctags -adtw {} \; \
			-exec sed -i "" 's/#define/# define/g' {} \;
	fi

	sort tags -o tags
	cd ..

else
	echo "You are not in a valid project directory"
fi
