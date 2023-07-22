#!/bin/bash

echo "Welcome to the password generator script!"

# Ask the user for the desired password length
read -p "Please enter the desired length of the password: " password_length

# Generate the random password using /dev/random
password=$(tr -dc 'A-Za-z0-9!@#$%^&*()' < /dev/random | head -c "$password_length")

# Estimate the time to crack the password
character_set_size=70 # Alphanumeric characters and special symbols
cracking_attempts_per_second=1000000000 # Assumed cracking speed (1 billion attempts per second)

# Calculate the number of possible combinations for the password
possible_combinations=$(bc <<< "$character_set_size ^ $password_length")

# Calculate the number of seconds it would take to try all combinations
seconds_to_crack=$(bc <<< "$possible_combinations / $cracking_attempts_per_second")

# Calculate the number of days and years to crack the password
seconds_per_day=86400
seconds_per_year=$((seconds_per_day * 365))
days_to_crack=$(bc <<< "$seconds_to_crack / $seconds_per_day")
years_to_crack=$(bc <<< "$seconds_to_crack / $seconds_per_year")

echo "Generated Password: $password"
echo "Estimated Time to Crack:"
echo "  - Days: $days_to_crack"
echo "  - Years: $years_to_crack"
