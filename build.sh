#!/bin/sh
this_dir=$(dirname "$(readlink -f "$0")")
export CL_SOURCE_REGISTRY="$this_dir//"
set -x
# cannot use --non-interactive because of divide-by-zero error
sbcl  --no-userinit \
	--eval '(require "asdf")' \
	--eval "(asdf:load-system :lem-webview)" \
	--eval "(lem:init-at-build-time)" \
	--eval "(sb-ext:save-lisp-and-die \"lem\" :toplevel #'lem-webview:main :executable t)"

