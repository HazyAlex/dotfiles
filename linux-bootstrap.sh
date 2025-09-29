#!/bin/bash

set -e

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

if ! command -v python &> /dev/null; then
    echo "Installing Python.."
    pacman -S --noconfirm python
    echo "Done!"
    echo ""
fi

if ! command -v ansible &> /dev/null; then
    echo "Installing Ansible.."
    pacman -S --noconfirm ansible
    echo "Done!"
    echo ""
fi


cd ansible

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
        ansible-playbook -i inventory/localhost.yml playbooks/base-server.yml
        ansible-playbook -i inventory/localhost.yml playbooks/git.yml
        ansible-playbook -i inventory/localhost.yml playbooks/docker.yml
        ;;
    2)
        ansible-playbook -i inventory/localhost.yml playbooks/base-server.yml
        ;;
    3)
        ansible-playbook -i inventory/localhost.yml playbooks/docker.yml
        ;;
    4)
        ansible-playbook -i inventory/localhost.yml playbooks/git.yml
        ;;
    *)
        echo "Exiting..."
        exit 1
        ;;
esac