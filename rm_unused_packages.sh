#!/bin/bash

echo "Removing unused packages for Arch Linux..."

# Remove orphaned packages (unused dependencies)
sudo pacman -Rns $(pacman -Qdtq)

echo "Unused packages have been removed successfully."

