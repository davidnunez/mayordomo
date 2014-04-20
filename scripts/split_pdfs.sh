## This is installed into hazel

#!/bin/bash

if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then

  source "$HOME/.rvm/scripts/rvm"

elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then

  source "/usr/local/rvm/scripts/rvm"

else

  printf "ERROR: An RVM installation was not found.\n"

fi


docsplit images "$1"
rm "$1"