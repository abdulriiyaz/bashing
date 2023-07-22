#!/bin/bash

# Check if the script is being run with superuser privileges
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run with superuser privileges. Exiting."
  exit 1
fi

echo "Welcome to the user removal script!"
read -p "Please enter the username of the user you want to remove: " username

# Check if the user exists
if id "$username" &>/dev/null; then
    echo "User '$username' exists. Proceeding with removal..."
else
    echo "User '$username' does not exist. Exiting."
    exit 1
fi

# Check if the user to be removed is the current user
if [[ "$username" == "$(whoami)" ]]; then
  echo "Removing the current user is not allowed. Exiting."
  exit 1
fi

# Remove the user and their home directory
sudo userdel -r "$username"

# Check if the user was successfully removed
if id "$username" &>/dev/null; then
    echo "Failed to remove user '$username'."
    exit 1
else
    echo "User '$username' has been removed successfully."
fi

