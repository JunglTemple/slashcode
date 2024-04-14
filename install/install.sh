#!/bin/bash

# ---------------
# | SLASHCODE INSTALLER
# |-- version: dev-2

echo "---------------"
echo "| SLASHCODE INSTALLER"
echo "|-- versions: installer one"
echo "|----         slashcode dev-1"

# Function to check if a command is available
command_exists() {
    command -v "$1" &> /dev/null
}

echo ""
# Check if user has sudo access
if command_exists sudo && sudo -n true &> /dev/null; then
    echo "| SUDO access detected. Proceeding with system-wide installation."
    SUDO_CMD="sudo"
else
    echo "| No SUDO access detected. Installing gem into user's home directory."
    SUDO_CMD=""
fi

echo ""
# Install Ruby if not already installed
if ! command_exists ruby; then
    echo "| Ruby not found. Installing Ruby..."
    # Install Ruby using the appropriate package manager
    if command_exists apt-get; then
        $SUDO_CMD apt-get update
        $SUDO_CMD apt-get install ruby -y
    elif command_exists pacman; then
        $SUDO_CMD pacman -Sy ruby
    else
        echo "| Error"
        echo "|-- Unsupported package manager"
        echo "|-- Please install Ruby manually."
        exit 1
    fi
fi

echo ""
# Install RubyGems if not already installed
if ! command_exists gem; then
    echo "| RubyGems not found. Installing RubyGems..."
    # Install RubyGems using the appropriate package manager
    if command_exists apt-get; then
        $SUDO_CMD apt-get update
        $SUDO_CMD apt-get install rubygems -y
    elif command_exists pacman; then
        $SUDO_CMD pacman -Sy rubygems
    else
        echo "| Error"
        echo "|-- Unsupported package manager."
        echo "|-- Please install RubyGems manually."
        exit 1
    fi
fi

echo ""
# Install slashcode gem
echo "| Installing slashcode gem..."
$SUDO_CMD gem install slashcode

echo "| Installation complete!"
echo ""
