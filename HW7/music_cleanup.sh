#!/bin/bash
# shellcheck disable=SC2086

getArtistName() {
    # I wrote this one to take one argument and set a global variable to the 
    # artist's name with whitespace removed
    # Note that this is where you'll want/need to use ffprobe
    artistName="$(ffprobe -show_format -loglevel quiet $1 | grep -E -- "TAG:artist|TAG:ARTIST" | grep -oP "\=\K.*" | sed "s/ //g")"

   # echo "$artistName"
}

getSongName() {
    # Same deal as getArtistName but with the song name
    # Note that this is where you'll want/need to use ffprobe

    songName=$(ffprobe -show_format -loglevel quiet $1 | grep -E -- 'TAG:TITLE|TAG:title' | grep -oP "\=\K.*" | sed 's/ //g')

    #echo "$songName"

}

doConversion() {
    # This function performs the conversion on a single file

    ffmpeg -i "$1" -f mp3 "$2/$3_$4.mp3"

#    if [[ $? != 0 ]]
#    then 
#	    echo "$1 couldn't be converted to .mp3"
#	    return 1
#    else
#	    echo "$1 was converted to .mp3"
#	    return 0
#   fi
}

# Takes one argument, that being a directory
TARGET_DIR=$1

# Now we should iterate over every file in the directory and do the conversion
# for each file

for i in $TARGET_DIR/*
do
	getArtistName "$i"
	getSongName "$i"
	doConversion "$i" "$1" "$artistName" "$songName" 
	rm "$i"
done
