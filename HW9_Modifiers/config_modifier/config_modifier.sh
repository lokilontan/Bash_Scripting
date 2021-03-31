#!/bin/bash

target_dir=$1
mode=$2
shift 2

appendMode() {
    # Appends a new field to a given section with a field name and value
    new_string="$2 = $3"
    find "./$target_dir" -name "*.ini" -exec sed -i -E "/$1/a $new_string" {} \;
    # Args
    # $1: Section name
    # $2: New field name
    # $3: New field value
}

deleteMode() {
    # Removes a field from the config file
    find "./$target_dir" -name "*.ini" -exec sed -i "/$1/ d" {} \;
    # Args
    # $1: field_name
}

subMode() {
    # Replaces the value of a particular field with a new one
    
    find "./$target_dir" -name "*.ini" -exec sed -i -E "s:^$1\ =\ .+$:$1 = $2:g" {} \;
    # Args
    # $1: field name
    # $2: new_value
}

case $mode in
    '-a')
        appendMode "$@"
        ;;
    '-d')
        deleteMode "$@"
        ;;
    '-s')
        subMode "$@"
        ;;
    *)
        echo 'Unrecongized flag for first argument'
        exit 2
        ;;
esac

# What command can we use to recursively find all files with an ini extenstion?
# Furthermore, how can we make that command call sed for each file it finds?
