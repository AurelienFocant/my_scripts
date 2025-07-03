#!/bin/bash

dirs=(".icons" ".ssh" "dotfiles" "common_core_19" "my_scripts" "source_code")

for dir in ${dirs[@]}; do
	cp -r ${HOME}/${dir} /sgoinfre/students/afocant
done

touch ${HOME}.reset
