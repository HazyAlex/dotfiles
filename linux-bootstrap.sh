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
echo "1. Core server configuration"
echo "2. Git configuration"
echo "3. Bash configuration"
echo "4. Docker installation"
echo "5. Services configuration"
echo "6. Cloudflare DDNS"
echo "7. Caddy (reverse proxy)"
echo "8. WireGuard (VPN)"
echo ""

read -p "Enter your selection: " choice

case $choice in
    1)
        ansible-playbook -K -i inventory/localhost.yml playbooks/base-server.yml
        ;;
    2)
        ansible-playbook -K -i inventory/localhost.yml playbooks/git.yml
        ;;
    3)
        ansible-playbook -K -i inventory/localhost.yml playbooks/bash.yml
        ;;
    4)
        ansible-playbook -K -i inventory/localhost.yml playbooks/docker.yml
        ;;
    5)
        ansible-playbook -K -i inventory/localhost.yml playbooks/services.yml
        ansible-playbook -K -i inventory/localhost.yml playbooks/uptime-kuma.yml
        ansible-playbook -K -i inventory/localhost.yml playbooks/dozzle.yml
        ansible-playbook -K -i inventory/localhost.yml playbooks/glances.yml
        ansible-playbook -K -i inventory/localhost.yml playbooks/watchyourlan.yml
        ansible-playbook -K -i inventory/localhost.yml playbooks/linkding.yml
        ansible-playbook -K -i inventory/localhost.yml playbooks/navidrome.yml
        ansible-playbook -K -i inventory/localhost.yml playbooks/jellyfin.yml
        ansible-playbook -K -i inventory/localhost.yml playbooks/kavita.yml
        ansible-playbook -K -i inventory/localhost.yml playbooks/blocky.yml
        ansible-playbook -K -i inventory/localhost.yml playbooks/gitea.yml
        ansible-playbook -K -i inventory/localhost.yml playbooks/transmissionbt.yml
        ansible-playbook -K -i inventory/localhost.yml playbooks/baikal.yml
        ;;
    6)
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
    7)
        ansible-playbook -K -i inventory/localhost.yml playbooks/caddy.yml
        ;;
    8)
        ansible-playbook -K -i inventory/localhost.yml playbooks/wireguard.yml
        ;;
    *)
        echo "Exiting..."
        exit 1
        ;;
esac
