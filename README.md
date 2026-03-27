
# Dotfiles

Personal configuration files synchronized across multiple machines. This repository contains settings for a terminal-focused workflow with [i3wm](https://i3wm.org/), [Neovim](https://neovim.io/), [tmux](https://github.com/tmux/tmux), and various development tools.

## Quick Start

```bash
# Clone the repository
git clone <repository-url> ~/dotfiles
cd ~/dotfiles

# See available commands
make help

# Create shared symbolic links
make ln

# Create machine-specific links (choose one)
make ln_rambo    # Production desktop workstation
make ln_lisa     # Production desktop workstation
make ln_fusca    # Data server
make ln_x390     # ThinkPad X390 laptop
```

## Structure

```
dotfiles/
├── bin/                    # Custom scripts and utilities
├── desktop/               # XDG desktop entries (mimeapps.list)
├── fzf-open/              # FZF-based file opener
├── git/                   # Git configuration
├── i3/                    # i3wm shared config + per-machine overrides
│   ├── config             # Shared config (included by all machines)
│   ├── config_rambo       # Machine-specific: audio, keyboard, screens
│   ├── config_lisa
│   ├── config_fusca
│   └── config_x390
├── i3status/              # i3status bar configs (per-machine)
├── nvim/                  # Neovim configuration
├── pacman/                # Arch/Manjaro package list
├── r/                     # R configuration (Rprofile, lintr, styler)
├── sioyek/                # PDF viewer config (theme generated at install)
├── tmux/                  # Terminal multiplexer config
├── vifm/                  # File manager configs and themes
├── wezterm/               # Terminal emulator config
├── x11/                   # X11 resources (Xresources, XCompose)
├── zathura/               # PDF viewer (Zathura) config
├── zsh/                   # Zsh configuration
└── Makefile               # Installation automation
```

## How it works

The Makefile manages symlinks from `~/dotfiles` into their expected locations (`~`, `~/.config`, etc.).

- **`make ln`** creates shared symlinks common to all machines (runs `make dirs` automatically)
- **`make ln_[machine]`** adds machine-specific links (i3 config_local, i3status)
- i3 uses `include ~/.config/i3/config_local` to load machine-specific settings (audio, keyboard, screens) from a symlink that points to the correct `config_*` file
- Sioyek theme colors are generated (not symlinked) so switching themes doesn't dirty the repo

## Supported Machines

- **rambo**: Production desktop workstation
- **lisa**: Production desktop workstation
- **fusca**: Data server
- **mini**: Data server
- **x390**: ThinkPad X390 laptop
- **mbp-m1**: Macbook Pro laptop

## Core Tools

- **Shell**: Zsh with [Oh My Zsh](https://ohmyz.sh/)
- **Editor**: [Neovim](https://neovim.io/) with Lua configuration
- **Terminal Multiplexer**: [Tmux](https://github.com/tmux/tmux) with TPM plugin manager
- **Window Manager**: [i3wm](https://i3wm.org/) (Linux machines)
- **File Manager**: [Vifm](https://github.com/vifm/vifm)
- **Browser**: [Firefox](https://www.firefox.com)
- **PDF Viewer**: [Sioyek](https://sioyek.info/) / [Zathura](https://github.com/pwmt/zathura)
- **Terminal**: [WezTerm](https://wezterm.org)

## Package Management

Package management targets use `pacman` and `yay`, available only on Arch/Manjaro Linux.

```bash
# Install official packages
make packages_install

# Install AUR packages (requires yay)
make packages_install_aur

# Save current package list
make packages_save
```

## Maintenance

```bash
# Remove all symlinks
make rm
```

To update configurations: edit files in `~/dotfiles`, commit, and pull on other machines. Symlinks automatically use the updated files.
