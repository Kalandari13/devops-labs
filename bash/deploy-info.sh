#!/bin/bash

current_user=$(whoami)

if [ "$#" -ne 2 ] || [ -z "$1" ] || [ -z "$2" ]; then
	echo "Error: Expected exactly 2 arguments and no empty values"
	exit 1 
fi

if [ "$2" != "development" ] && [ "$2" != "staging" ] && [ "$2" != "production" ]; then 
	echo "Error: accepted environment areguments are: development; staging; production"
	exit 1 
fi 


echo "Application: $1"
echo "Enviroment: $2"
echo "Arguments provided: $#"
echo "Exectured by: $current_user"
echo "Preparing deployment of $1 to $2"
exit 0 


