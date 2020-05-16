# Dotfiles

## Installation

Clone the dotfiles repertory wherever you want and use the `dotfiles-manager.sh` script to synchronize (install) the files to your personal home directory.

~~~
Usage: dotfiles-manager.sh <operations> [options]

Operations:
  -S, --sync            synchronize dotfiles to the HOME directory
  -U, --upload          upload dotfiles from the HOME directory

Options:
      --home[=]<dir>    give another home destination directory
                        (default: <your-home-dir>)
  -n, --dry-run         display status of new/updated/conflicting files
  -f, --force           overwrites files without asking
  -h, --help            display this help and exit
~~~

## Dependencies

### Powerline Fonts

Install all powerlines fonts to your environment with this [github project](https://github.com/powerline/fonts#quick-installation).

~~~
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts
ln -s ~/.local/share/fonts .fonts
fc-cache -vf
~~~

Resources are stored in the X server, so have to only be read once.
Load a resource file, and merge with the current settings [archlinux](https://wiki.archlinux.org/index.php/X_resources#Usage):

~~~
xrdb -merge ~/.Xresources
~~~

### Tmux Plugin Manager

Installs and loads `Tmux` plugins with this [github project](https://github.com/tmux-plugins/tpm#installation).

~~~
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
~~~

Installing plugins with `Tmux`:

1. Add new plugin to `~/.tmux.conf` with `set -g @plugin '...'`
2. Press `prefix` + <kbd>I</kbd> (capital I, as in **I**nstall) to fetch the plugin.

You're good to go! The plugin was cloned to `~/.tmux/plugins/` directory and sourced.


## Customization

You can freely improve your environment by editing `{zsh|bash|csh}rc.perso` and `{zsh|bash|csh}rc.first` in order to add software or dependency and keeping updates of this project. Those files will never exist in this project, they will not be overwritten.

### Color Scheme for Gnome Terminal, Pantheon Terminal and Tilix

Download color configuration files from this [github project](https://github.com/Mayccoll/Gogh), choose your [theme](https://mayccoll.github.io/Gogh/) and download it into your environment with this command.

~~~
wget -nv https://raw.githubusercontent.com/Mayccoll/Gogh/master/themes/solarized-dark.sh -P ~/.themes
~~~

Then you can edit your `{zsh|bash|csh}rc.perso` to define `background`, `dark_theme` and `light_theme` to use.

## Troubleshooting

### Wrong colors in gnome-terminal

In **Profile Preferences** > **Title and Command** > Check **"Run a custom command instead of my shell"**

In the box of **Custom command:** `env TERM=xterm-256color /bin/tcsh`

***Note***: you can directly change the Shell interpreter through this trick... (env TERM=xterm-256color /bin/bash)

## Acknowledgments

- My vimrc is based on [Junegunn Choi's configuration](https://github.com/junegunn/dotfiles/blob/master/vimrc) and [Amir Salihefendic's configuration](https://github.com/amix/vimrc)

## License

Use this setup at your own risk, no guarantee is provided whatsoever

