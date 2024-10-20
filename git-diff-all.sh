#!/usr/bin/env sh
# Alexis Megas.

# Discover all git repositories from the current directory and
# issue git-diff for each discovered repository.
# Errors are discarded!

for directory in $(find . -name '.git' -type d -exec dirname {} \;)
do
    echo "Pulling $directory:"
    git -C $directory diff $* 2>/dev/null
done

exit 0
