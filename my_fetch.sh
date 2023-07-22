#!/bin/bash

echo "System Information"
echo "------------------"

# Get terminal information
terminal=$(basename "$SHELL")

# Get shell information
shell=$(echo "$SHELL" | awk -F/ '{print $NF}')

# Get kernel version
kernel=$(uname -r)

# Get operating system and distribution information
if [ -f "/etc/os-release" ]; then
  source /etc/os-release
  os=$NAME
  distro=$PRETTY_NAME
else
  os=$(uname -s)
  distro=$(uname -s)
fi

# Function to count installed packages for Debian-based systems
count_debian_packages() {
  if command -v dpkg &>/dev/null; then
    packages=$(dpkg -l | grep '^ii' | wc -l)
  else
    packages="N/A"
  fi
}

# Function to count installed packages for Red Hat-based systems
count_redhat_packages() {
  if command -v rpm &>/dev/null; then
    packages=$(rpm -qa | wc -l)
  else
    packages="N/A"
  fi
}

# Function to count installed packages for Arch Linux
count_arch_packages() {
  if command -v pacman &>/dev/null; then
    packages=$(pacman -Q | wc -l)
  else
    packages="N/A"
  fi
}

# Count installed packages based on distribution
case "$os" in
  "Ubuntu" | "Debian" | "Linux Mint" | "elementary OS")
    count_debian_packages
    ;;
  "Fedora" | "CentOS" | "Red Hat Enterprise Linux" | "openSUSE")
    count_redhat_packages
    ;;
  "Arch Linux" | "Manjaro Linux")
    count_arch_packages
    ;;
  *)
    packages="N/A"
    ;;
esac

# Display the collected information
echo "Terminal: $terminal"
echo "Shell: $shell"
echo "Kernel Version: $kernel"
echo "OS: $os"
echo "Distribution: $distro"
echo "Installed Packages: $packages (packages listed with -l)"

