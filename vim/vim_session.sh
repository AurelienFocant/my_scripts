#! /bin/bash

# [ -d misc ] && dir="misc" || dir="."
# vim -S $dir/Session.vim -c 'Le | Le'

nvim -S misc/Session.vim -c "NvimTreeToggle"
