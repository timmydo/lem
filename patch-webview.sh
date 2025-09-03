#!/bin/sh

(cd submodules/webview && guix shell --network --container nss-certs bash git coreutils webkitgtk gcc-toolchain cmake ninja pkg-config -- sh -c "cd c/ && rm -rf build/ && cmake -G Ninja -B build -S . -D CMAKE_BUILD_TYPE=Release && cmake --build build && cd .. && cp -r c/build/lib/* lib/linux/x64/ && echo success")
