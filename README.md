# Description

This is my collection of dotfiles and related

This is work in progress and by far nohwere close I want it, but I can work with it quite well so far!

## Installation

This is meant for my own usage and just copying my config is at your own risk!

Currently I use dotbot, which is tracked as a submodule, nad thus cecked out when also checking
submodules!
To get my configs up and running, just clone this repo including submodule on the target system into 
`~/dofiles`. Then run `./install` and everythin will hopefully be set up

# Roadmap

- change project structure to better separate configs and project management
- include Makefile for little tasks
   - e.g. handling of lesskey compiling
   - maybe bootsraping the install
- add install script, I can run via rawlink in curl and it bootsraps config from terminal
  - have a minimal option, so I can have a simple but usefull setup for remote machines or docker containers
- change in neovim to lua config and some other modern options (LSP, lazy.nvim, .. )
- add ansible playbooks to install and set up some usefull programs or options
- move from dotbot to gnu stow (it is very simple, easy to use and follows the folder structure, so no config drift)
