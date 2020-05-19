# Dotfiles

![Screenshot of my Tmux configuration](https://raw.githubusercontent.com/wiki/romangauchi/dotfiles/screenshots/dotfiles-01.png)

## Installation

Clone the dotfiles repertory wherever you want and use the `dotfiles-manager.sh` script to synchronize the dotfiles and install dependencies to your personal home directory.

~~~
git clone https://github.com/romangauchi/dotfiles.git
cd dotfiles
./dotfiles-manager.sh -S
~~~

### Dependencies

Install dependencies with the `dotfiles-manager.sh`:

~~~
./dotfiles-manager.sh -I
~~~

The following dependencies will be automatically installed on your system:

- **Nerd Fonts**: font project including glyph (icons) from popular font projects as *Font Awesome*, *Powerline*, *Devicons* [github project](https://github.com/ryanoasis/nerd-fonts).
- **Tmux Plugin Manager**: to support plugins on `Tmux` [github project](https://github.com/tmux-plugins/tpm#installation).

### Archive your environment

Before every modifications your can save your current configuration in a archive (*.tar.gz).

~~~
./dotfiles-manager.sh -A --output <my-dotfiles>
~~~

### `dotfiles-manager.sh` options

~~~
Options:
      --home[=]<dir>    give another home destination directory
                        (default: <your-home-dir>)
      --output[=]<file> give another archive name to save your dotfiles
                        (default: <dotfiles-hostname-date>)
  -n, --dry-run         display status of new/updated/conflicting files
  -f, --force           overwrites files without asking
  -h, --help            display this help and exit
~~~

## Customization

You can freely improve your environment by editing `{zsh|bash|csh}rc.perso` and `{zsh|bash|csh}rc.first` in order to add software or dependency and keeping updates of this project. Those files will never exist in this project, they will not be overwritten.

### New plugins on `Tmux`

1. Add new plugin to `~/.tmux.conf` with `set -g @plugin '...'`
2. Press `prefix` + <kbd>I</kbd> (capital I, as in **I**nstall) to fetch the plugin

You're good to go! The plugin was cloned to `~/.tmux/plugins/` directory and sourced.

### New color theme

Download color configuration files from this [github project](https://github.com/Mayccoll/Gogh), choose your [theme](https://mayccoll.github.io/Gogh/) and download it into your environment with this command.

~~~
wget -nv https://raw.githubusercontent.com/Mayccoll/Gogh/master/themes/solarized-dark.sh -P ~/.themes
~~~

Then you can edit your `{zsh|bash|csh}rc.perso` to define `background`, `dark_theme` and `light_theme` to use.


## Troubleshooting

### Wrong colors in gnome-terminal

1. Go to **Profile Preferences** > **Title and Command** > Check **"Run a custom command instead of my shell"**
2. Enter in **Custom command**: `env TERM=xterm-256color /bin/tcsh`

***Note***: you can directly change the Shell interpreter through this trick... (env TERM=xterm-256color /bin/bash)

## Acknowledgments

- My vimrc is based on [Junegunn Choi's configuration](https://github.com/junegunn/dotfiles/blob/master/vimrc) and [Amir Salihefendic's configuration](https://github.com/amix/vimrc)

## License

Use this setup at your own risk, no guarantee is provided whatsoever

