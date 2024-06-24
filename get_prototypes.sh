/******
*
* Credits to : Jveirman from 19 Brussels
*
******/

function prototype() {
    local dir="$1"
    if [ -z "$dir" ]; then
        dir="."
    fi
    find "$dir" -type f -name "*.c" -exec sh -c 'echo "\033[1;32m\n/*----------------  ${1##*/}  ---------------*/\033[0m"; grep -E "^[[:space:]]*([a-zA-Z_*]+[[:space:]]+){1,2}[a-zA-Z_*]+\([^\)]*\)" $1 | grep -vE "^[[:space:]]*static[[:space:]]+" | sed "s/$/;/";' _ {} \;
}

prototype
echo ""
