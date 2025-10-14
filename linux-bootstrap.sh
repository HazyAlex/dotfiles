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
if [ ! -d "dotfiles" ]; then
    git clone https://github.com/HazyAlex/dotfiles.git
fi
cd dotfiles
git switch wip
git pull
cd ansible

echo "Available tasks:"
echo ""
echo "1. Run all tasks"
echo "2. Core server configuration"
echo "3. Git configuration"
echo "4. Bash configuration"
echo "5. Docker installation"
echo "6. Services configuration"
echo "7. Cloudflare DDNS"
echo ""

read -p "Enter your selection: " choice

case $choice in
    1)
        ansible-playbook -K -i inventory/localhost.yml playbooks/base-server.yml
        ansible-playbook -K -i inventory/localhost.yml playbooks/git.yml
        ansible-playbook -K -i inventory/localhost.yml playbooks/bash.yml
        ansible-playbook -K -i inventory/localhost.yml playbooks/docker.yml
        ansible-playbook -K -i inventory/localhost.yml playbooks/services.yml
        ;;
    2)
        ansible-playbook -K -i inventory/localhost.yml playbooks/base-server.yml
        ;;
    3)
        ansible-playbook -K -i inventory/localhost.yml playbooks/git.yml
        ;;
    4)
        ansible-playbook -K -i inventory/localhost.yml playbooks/bash.yml
        ;;
    5)
        ansible-playbook -K -i inventory/localhost.yml playbooks/docker.yml
        ;;
    6)
        ansible-playbook -K -i inventory/localhost.yml playbooks/services.yml
        ansible-playbook -K -i inventory/localhost.yml playbooks/uptime-kuma.yml
        ansible-playbook -K -i inventory/localhost.yml playbooks/dozzle.yml
        ansible-playbook -K -i inventory/localhost.yml playbooks/glances.yml
        ;;
    7)
        if [ ! -f "group_vars/cloudflare-ddns.yml" ]; then
            echo ""
            echo "⚠️ IMPORTANT: Before proceeding, make sure you have edited the Cloudflare DDNS configuration!"
            echo ""
            echo "An example is available in: dotfiles/ansible/group_vars/cloudflare-ddns.example.yml"
            echo ""
            echo "Copy the example file and edit it:"
            echo "  cp dotfiles/ansible/group_vars/cloudflare-ddns.example.yml dotfiles/ansible/group_vars/cloudflare-ddns.yml"
            echo ""
            exit 1
        fi

        ansible-playbook -K -i inventory/localhost.yml playbooks/cloudflare-ddns.yml
        ;;
    *)
        echo "Exiting..."
        exit 1
        ;;
esac
