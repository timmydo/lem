#!/bin/sh
set -eu

# Get only the regular 'out' output path for ncurses
ncurses_prefix=$(
  guix build ncurses \
    | grep -E -- '-ncurses-[0-9]' \
    | grep -vE -- '(-doc|-static)$'
)

target_file="submodules/cl-charms/src/low-level/curses-bindings.lisp"

# Full path for libncursesw.so
libncursesw_path="$ncurses_prefix/lib/libncursesw.so"

# Replace libncursesw.so if not already replaced
if ! grep -Fq "$libncursesw_path" "$target_file"; then
    sed -i "s|libncursesw\.so|$libncursesw_path|g" "$target_file"
    echo "Replaced 'libncursesw.so' with '$libncursesw_path'."
else
    echo "No replacement needed — file already contains '$libncursesw_path'."
fi