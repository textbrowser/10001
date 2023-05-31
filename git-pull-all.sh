#!/usr/bin/env sh
# Alexis Megas.

# Discover all git repositories from the current directory and
# issue git-pull for each discovered repository.
# Errors are discarded!

for directory in $(find . -name '.git' -type d -exec dirname {} \;)
do
    echo "$directory:"
    git -C $directory pull $* 2>/dev/null
done

exit 0
