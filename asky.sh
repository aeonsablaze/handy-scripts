#!/bin/bash
# Script to display image files converted to ascii (good for quick
# file previews within ssh sessions). There are several utilities
# out there for this purpose but most of them are dependant on file
# type. This script should work for any common image format (aka. any
# format compatible with ImageMagick).


# Verify that only one parameter is provided.
if [ $# -gt 1 ]; 
    then echo "Illegal number of parameters provided"
    exit
elif [ $# -eq 0 ];
    then echo "Usage: asky [filename]"
    exit
fi


# Verify that the file is an image.
if [[ $(file -ib $1 | grep 'image') == false ]];
    then echo "Specified file does not seem to be an image."
    exit
fi


# Convert to jpeg via ImageMagick and them ascii via jp2a
convert $1 jpeg:- | jp2a --color -
