#!/bin/bash

# Update and install dependencies
# no sudo should be needed for this!
# sudo apt update
# sudo apt install -y python3-pip git

# Install pipx
python3 -m pip install --user pipx
python3 -m pipx ensurepath

# Install Ansible using pipx
pipx install ansible

# Clone your dotfiles repository
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles

# Change to the playbooks directory
cd ~/dotfiles/playbooks

# Run the Ansible playbook
ansible-playbook site.yml

