#!/bin/bash

echo "Welcome to the user creation script!"
read -p "Please enter the desired username: " username

# Check if the user already exists
if id "$username" &>/dev/null; then
    echo "User '$username' already exists. Exiting."
    exit 1
fi

# Prompt for password without echoing characters to the terminal
read -s -p "Please enter the password for the new user: " password
echo

# Prompt for sudo privileges
read -p "Should the user have sudo privileges? (yes/no): " sudo_choice

# Check if the response is 'yes' or 'no'
if [[ "$sudo_choice" == "yes" ]]; then
    sudo_privileges="yes"
else
    sudo_privileges="no"
fi

# Create the user and set password
sudo useradd -m -s /bin/bash "$username"
echo "$username:$password" | sudo chpasswd

# Add the user to the 'wheel' group if they should have sudo privileges
if [[ "$sudo_privileges" == "yes" ]]; then
    sudo usermod -aG wheel "$username"
fi

echo "User '$username' has been created successfully."
if [[ "$sudo_privileges" == "yes" ]]; then
    echo "The user has been added to the 'wheel' group with sudo privileges."
else
    echo "The user does not have sudo privileges."
fi

