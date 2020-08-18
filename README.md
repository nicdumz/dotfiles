![Logo](logo_200.png "Logo")

# Nicolas' dotfiles

Versioning together my dotfiles. Some of them may be useful to you, but I doubt
it :)

# Installation

    git clone https://github.com/nicdumz/dotfiles.git ~/.dotfiles
    ~/.dotfiles/install.sh

## Irssi

After setting irssi you may want to setup the layout:

    /run autorun/adv_windowlist.pl
    /toggle awl_viewer
    /save

# Notes

## Base16

I seem to always forget, but I actually quite like the base16 color themes:

-   http://chriskempson.github.io/base16/#flat
-   http://chriskempson.github.io/base16/#monokai
-   http://chriskempson.github.io/base16/#solarized

https://github.com/chriskempson/base16-gnome-terminal is nice and easy for gnome
terminal profiles.

## Nova

https://trevordmiller.com/projects/nova is actually nice too, it makes sense to
create a 'Nova' terminal profile and follow instructions there to set it up.

# Included as subrepos

-   Setup colors for bash: https://github.com/chriskempson/base16-shell.git
-   Custom [Powerline fonts](https://github.com/powerline/fonts) for vim status
    line.
-   I'm using [dotbot](https://github.com/anishathalye/dotbot) for dotfiles
    management/setup.
-   [Vundle](https://github.com/gmarik/vundle) for vim plugin management.
-   [gibo](https://github.com/simonwhitaker/gibo) to generate
    .gitconfig/hgignore files.
-   [fontinstall](https://github.com/nicdumz/fontinstall) to easily install
    fonts accross systems.
