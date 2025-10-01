#!/bin/bash

set -e

if [[ $EUID -eq 0 ]]; then
    echo "Do not run this script as root. Please run it as a regular user."
    exit 1
fi

if ! command -v git &> /dev/null; then
    sudo pacman -S --noconfirm git
fi

if ! command -v ansible &> /dev/null; then
    sudo pacman -S --noconfirm ansible
fi

cd ~
git clone https://github.com/HazyAlex/dotfiles.git
git switch wip
cd dotfiles/ansible

echo "Available tasks:"
echo ""
echo "1. Run all tasks"
echo "2. Core server configuration"
echo "3. Docker installation"
echo "4. Git configuration"
echo ""

read -p "Enter your selection: " choice

case $choice in
    1)
        ansible-playbook -K -i inventory/localhost.yml playbooks/base-server.yml
        ansible-playbook -K -i inventory/localhost.yml playbooks/git.yml
        ansible-playbook -K -i inventory/localhost.yml playbooks/docker.yml
        ;;
    2)
        ansible-playbook -K -i inventory/localhost.yml playbooks/base-server.yml
        ;;
    3)
        ansible-playbook -K -i inventory/localhost.yml playbooks/docker.yml
        ;;
    4)
        ansible-playbook -K -i inventory/localhost.yml playbooks/git.yml
        ;;
    *)
        echo "Exiting..."
        exit 1
        ;;
esac