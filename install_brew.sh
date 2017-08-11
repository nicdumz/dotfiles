#!/bin/sh

if [ -d "$HOME/Library" ]; then
    # Poor man's OS detection -- this is Mac.
    if [ -d "$HOME/brew" ]; then
        pushd ~/brew
        git pull origin master
        popd
    else
        git clone https://github.com/Homebrew/brew.git ~/brew
    fi
    cat ~/.dotfiles/brew_recipes.txt | xargs -n 1 ~/brew/bin/brew install
    cat ~/.dotfiles/brew_taps.txt | xargs -n 1 ~/brew/bin/brew tap
    cat ~/.dotfiles/brew_casks.txt | xargs -n 1 ~/brew/bin/brew cask install
    ~/brew/bin/brew update
    ~/brew/bin/brew upgrade
fi
