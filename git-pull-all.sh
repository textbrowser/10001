#!/usr/bin/env sh
# Alexis Megas.

# Errors are not displayed!

for directory in $(find ~ -name '.git' -type d -exec dirname {} \;)
do
    echo "$directory:"
    git -C $directory pull $* 2>/dev/null
done

exit 0
