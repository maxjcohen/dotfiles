# Dotfiles

This repo contains my system and software configurations in the form of `dotfiles`.

## Installation
By using [`stow`](https://www.gnu.org/software/stow/), we can automate the creation of symlinks from this repo to the home directory. This process _should_ not destroy any existing configuration present on the system, and could even be reversible. In case of conflict, the existing files are moved to this repo, then symlinked to their previous position, thanks to the `--adopt` option. The difference will then appear as a change in this repo, which can be carefully studied using traditional git diff tools.

To install, run:
```bash
make install
```

Note that we can first preview changes to be made by leveraging the `--simulate` option of `stow`. Run:
```bash
make simulate
```

## Uninstallation
To remove added symlinks, run:
```
make clean
```

## Description of files
Config files:
- `.dwm`: [dwm](https://dwm.suckless.org/) config files
- `.gitconfig`: [git](https://git-scm.com/) config
- `.tmux.conf`: [tmux](https://github.com/tmux/tmux) config
- `.vimrc`: [vim](https://www.vim.org/) config (`.vim` folder to come)
- `.xbindkeysrc`: [Xbindkeys](https://wiki.archlinux.org/title/Xbindkeys) config
- `.xinitrc`: [xinit](https://www.x.org/archive/X11R6.8.2/doc/xinit.1.html) config
- `.Xresources`: [xresources](https://wiki.archlinux.org/title/X_resources) config (Nord theme)
- `.dir_colors`: [dir_colors](https://man.archlinux.org/man/dircolors.1.html) colors (Nord theme)
- `.zshrc`: [zsh](https://www.zsh.org/) config
- `.zshenv`: [zsh](https://www.zsh.org/) always loaded, see [manual](https://zsh.sourceforge.io/Intro/intro_3.html) and [thread](https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout#71258)

Config folder `.config`
- `protonvpn/user_configurations.json`: [protonvpn](https://protonvpn.com/) config
- `zathura/zathrarc`: [zathura](https://github.com/pwmt/zathura) config
- `zsh/theme/home.zsh`: homemade zsh theme
- `alacritty/alacritty.yml`: [alacritty](https://github.com/alacritty/alacritty) config
- `htop/htoprc`: [htop](https://htop.dev/) config
- `dunst/dunstrc`: dunst config file


Resources folders:
- `.local`: various local resources (background, fonts, etc.)

Various homemade scripts in `.local/share/bin`:
- `tmux_launch`: launcher for tmux with lots and lots of windows potential
- `fzfmenu`: choose over available executables in PATH with fzf and execute
- `notify_*`: helper scripts to notify current volume and brightness levels
