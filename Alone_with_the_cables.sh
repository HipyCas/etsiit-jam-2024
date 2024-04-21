#!/bin/sh
echo -ne '\033c\033]0;Alone with the cables\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Alone_with_the_cables.x86_64" "$@"
