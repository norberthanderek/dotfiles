#!/bin/bash

GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"

PACKAGES=("clang-format" "black" "flake8" "luarocks")

check_rustup() {
    if ! command -v rustup &> /dev/null; then
        echo -e "${RED}Rustup is not installed. Please install it and try again.${NC}"
        exit 1
    fi
}

detect_package_manager() {
    if command -v nala &> /dev/null; then
        echo "nala"
    elif command -v apt &> /dev/null; then
        echo "apt"
    elif command -v pacman &> /dev/null; then
        echo "pacman"
    elif command -v brew &> /dev/null; then
        echo "brew"
    else
        echo "unsupported"
    fi
}

install_packages() {
    PACKAGE_MANAGER=$1
    case $PACKAGE_MANAGER in
        apt|nala)
            echo -e "${GREEN}Updating package list and installing packages with $PACKAGE_MANAGER...${NC}"
            sudo $PACKAGE_MANAGER update
            sudo $PACKAGE_MANAGER install -y "${PACKAGES[@]}"
            ;;
        pacman)
            echo -e "${GREEN}Updating system and installing packages with pacman...${NC}"
            sudo pacman -S --noconfirm "${PACKAGES[@]}"
            ;;
        brew)
            echo -e "${GREEN}Updating Homebrew and installing packages...${NC}"
            brew update
            brew install "${PACKAGES[@]}"
            ;;
        *)
            echo -e "${RED}Unsupported package manager. Please install packages manually.${NC}"
            exit 1
            ;;
    esac
}

main() {
    check_rustup

    PACKAGE_MANAGER=$(detect_package_manager)

    echo "Detected package manager: $PACKAGE_MANAGER"
    install_packages "$PACKAGE_MANAGER"

    echo "Installing dependencies not related to: $PACKAGE_MANAGER"
    echo -e "${GREEN}rustfmt${NC}"
    rustup update
    rustup component add rustfmt

    echo -e "${GREEN}luacheck${NC}"
    sudo luarocks install luacheck
}
main
