#!/bin/sh

stow -d ~/dotfiles -t ~ zsh
stow -d ~/dotfiles -t ~/.config config
stow -d ~/dotfiles -t ~/.local/share/bin scripts
stow -d ~/dotfiles -t ~ git
ln -s ~/dotfiles/myconf ~/.config/myconf

echo "Dotfiles linked successfully!"

