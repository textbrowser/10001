#!/usr/bin/env sh

# Alexis Megas.

# Clone all repositories for a GitHub account.

if [ -z "$(which curl)" ]
then
    echo "Please install curl."
    exit 1
fi

if [ -z "$(which git)" ]
then
    echo "Please install git."
    exit 1
fi

account="$1"

if [ -z "$account" ]
then
    echo "Usage: git-clone-all account."
    exit 1
fi

site="https://api.github.com/users/$account/repos"

for i in $(curl --silent $site 2>/dev/null | grep clone_url)
do
    url=$(echo $i | sed s/,*\"*//g)

    if [ ! -z "$(echo $url | grep https://)" ]
    then
	name=$(echo $url | rev | cut -d '/' -f 1 | rev 2>/dev/null)

	if [ -z "$name" ]
	then
	   echo "Could not parse the name of the repository $url."
	   continue
	fi

	if [ ! -e ./tmp.d ]
	then
	    echo "Creating the directory ./tmp.d."
	    mkdir tmp.d

	    if [ ! $? -eq 0 ]
	    then
		echo "Could not create the directory ./tmp.d."
		exit 1
	    fi
	fi

	directory="./tmp.d/$name"

	if [ -e "$directory" ]
	then
	    echo -n "The directory $directory already exists. Performing " \
		    "a GIT-PULL instead... "
	    git -C "$directory" pull -q 2>/dev/null

	    if [ $? -eq 0 ]
	    then
		echo "Success."
	    else
		echo "Failure."
	    fi

	    continue
	fi

	echo "Cloning $url into $directory..."
	git clone -q "$url" "$directory" 2>/dev/null

	if [ $? -eq 0 ]
	then
	    echo "Successfully cloned $url into $directory."
	else
	    echo "Error cloning $url into $directory."
	fi
    fi
done
