![Logo](logo_200.png "Logo")

# Nicolas' dotfiles

Versioning together my dotfiles. Some of them may be useful to you, but I doubt
it :)

# Installation

Assuming some debian flavor, this should just work:

```bash
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- -b ~/.local/bin init --apply --ssh nicdumz
```

Afterwards everything is managed via `chezmoi`.

## Irssi

After setting irssi you may want to setup the layout:

```bash
/run autorun/adv_windowlist.pl
/toggle awl_viewer
/save
```

# Notes

I use https://chezmoi.io for dotfiles management, this is the `chezmoi` CLI.

## Regular updates

```bash
chezmoi git pull  # pull latest changes from this repo
chezmoi apply     # apply changes, including diff detection
```

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

## Redshift and apparmor

```
$ cat /etc/apparmor.d/local/usr.bin.redshift
owner @{HOME}/.dotfiles/.config/redshift/redshift.conf r,
```
