#!/bin/bash

# Function to check if two numbers are relatively prime
function is_relatively_prime() {
    local num1=$1
    local num2=$2
    local smaller=$((num1 < num2 ? num1 : num2))

    for ((i=2; i<=smaller; i++)); do
        if ((num1 % i == 0 && num2 % i == 0)); then
            return 1
        fi
    done

    return 0
}

# Function to generate a random number greater than a specified value
function generate_number() {
    local min=$1
    local number

    while true; do
        number=$((RANDOM % 90000 + min))
        if is_relatively_prime $number $min; then
            echo $number
            return
        fi
    done
}

# Generate input_data file
filename="rp_input_data"
num_lines=1000

rm -f $filename  # Remove the file if it already exists

for ((i=1; i<=num_lines; i++)); do
    num1=$(generate_number 10000)
    num2=$(generate_number 10000)

    echo "$num1 $num2" >> $filename
done

echo "Generated $num_lines lines in $filename"
