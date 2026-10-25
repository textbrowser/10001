#!/usr/bin/env sh

# Alexis Megas.

# Discover all git repositories from the current directory and
# issue git-pull for each discovered repository.
# Clean the local repositories.
# Errors are discarded!

for directory in $(find . -name '.git' -type d -exec dirname {} \; 2>/dev/null)
do
    echo "Pulling \"$directory\"."
    git -C "$directory" pull $* 2>/dev/null

    if [ $? -eq 0 ]
    then
	echo "Succeeded."
    else
	echo "Failed. Please pull $directory manually."
    fi

    echo "Housekeeping \"$directory\"."
    git -C "$directory" gc 2>/dev/null
done
