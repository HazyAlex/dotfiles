#!/bin/bash

set -e

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

echo "Installing Python and Ansible..."
pacman -S --noconfirm python ansible
echo "Done!"

cd ansible

echo "Available playbooks:"
echo "1. Run all playbooks"
echo "2. Core server configuration"
echo "3. Docker installation"
echo "4. Git configuration"

read -p "Enter your selection: " choice

case $choice in
    1)
        ansible-playbook -i inventory/localhost.yml playbooks/base-server.yml
        ansible-playbook -i inventory/localhost.yml playbooks/docker.yml
        ansible-playbook -i inventory/localhost.yml playbooks/git.yml
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