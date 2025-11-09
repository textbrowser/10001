#!/usr/bin/env sh

# Alexis Megas.

# Discover all git repositories from the current directory and
# issue git-diff for each discovered repository.
# Errors are discarded!

for directory in $(find . -name '.git' -type d -exec dirname {} \; 2>/dev/null)
do
    echo "Discovering differences in \"$directory\"."
    git -C "$directory" diff $* 2>/dev/null
done
