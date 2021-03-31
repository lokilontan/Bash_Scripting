#!/bin/bash

# The only command line argument is a file name
file_name=$1
passed=true

# Iterate over each line of the input file
while IFS= read -r line; do
    # Here's where you can use regex capture groups to extract the info from each line
    # You'll need to capture two pieces of data: the field name and the value of the field.
    # Put your regex with capture groups to the right of the =~ operator
    if [[ $line =~ ^\ +(.+):\ +(.*)$ ]]; then
        # Recall how to access text from regex capture groups
        # See slide 15 from the lecture
        field=${BASH_REMATCH[1]}
        value=${BASH_REMATCH[2]}
    else
        # If nothing could be extraced, then skip the line
       	continue
    fi

    case $field in
	    #Assign an appropriate pattern to a field
	first_name)
	    pattern='^[[:alpha:]]+$'
   	    ;;	
    last_name)
	    pattern='^[[:alpha:]]+$'
	    ;;
    phone_number)
	    pattern='^[[:digit:]]{3}-[[:digit:]]{3}-[[:digit:]]{4}$'
	    ;;
        email)
            pattern='^[[:alnum:]_#-]+@[[:alnum:]-]+\.[[:alnum:]]{2,4}$'
	    ;;
    street_number)
	    pattern='^[[:digit:]]{1,5}$'
	    ;;
    street_name)
	    pattern='^[[:alpha:]\ ]+$'
	    ;;
    apartment_number)
	    pattern='^[[:digit:]]{1,4}$|^$'
	    ;;
    city)
	    pattern='^[[:alpha:]\ ]+$'
	    ;;
    state)
	    pattern='^[A-Z]{2}$'
	    ;;
    zip)
	    pattern='^[[:digit:]]{5}$'
	    ;;
    card_number)
	    pattern='^[[:digit:]]{4}-[[:digit:]]{4}-[[:digit:]]{4}-[[:digit:]]{4}$'
	    ;;
    expiration_month)
	    pattern='^0[1-9]$|^1[0-2]$'
	    ;;
    expiration_year)
	    pattern='^202[1-9]$'
	    ;;
    ccv)
	    pattern='^[[:digit:]]{3}$'
	    ;;
        *) # Case where there the field name didn't match anything
       	continue
            ;;
    esac

    if ! [[ $value =~ $pattern ]]; then
        # We need to print out a message if the field isn't valid
	echo "field ${field} with value ${value} is not valid"
	passed=false
     	fi
        
done < "$file_name"

# We need to print something if all fields were valid
# Remember, booleans are useful for this assignment
if [[ "$passed" = true ]]; then
	echo "purchase is valid"
	exit 0
fi
