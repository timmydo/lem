#!/bin/sh
set -eu

# Get only the regular 'out' output path for openssl
openssl_prefix=$(
  guix build openssl \
    | grep -E -- '-openssl-[0-9]' \
    | grep -vE -- '(-doc|-static)$'
)

target_file="submodules/cl+ssl/src/reload.lisp"

# Full paths for both libraries
libcrypto_path="$openssl_prefix/lib/libcrypto.so"
libssl_path="$openssl_prefix/lib/libssl.so"

# Replace libcrypto.so if not already replaced
if ! grep -Fq "$libcrypto_path" "$target_file"; then
    sed -i "s|libcrypto\.so|$libcrypto_path|g" "$target_file"
    echo "Replaced 'libcrypto.so' with '$libcrypto_path'."
else
    echo "No replacement needed — file already contains '$libcrypto_path'."
fi

# Replace libssl.so if not already replaced
if ! grep -Fq "$libssl_path" "$target_file"; then
    sed -i "s|libssl\.so|$libssl_path|g" "$target_file"
    echo "Replaced 'libssl.so' with '$libssl_path'."
else
    echo "No replacement needed — file already contains '$libssl_path'."
fi
