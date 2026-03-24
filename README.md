
# Dotfiles

Personal configuration files synchronized across multiple machines. This repository contains settings for a terminal-focused workflow with [i3wm](https://i3wm.org/), [Neovim](https://neovim.io/), [tmux](https://github.com/tmux/tmux), and various development tools.

## 🚀 Quick Start

```bash
# Clone the repository
git clone <repository-url> ~/dotfiles
cd ~/dotfiles

# Create general symbolic links
make ln

# Create machine-specific links (choose one)
make ln_lisa     # Production desktop workstation
make ln_rambo    # Production desktop workstation  
make ln_fusca    # Data server
make ln_x390     # ThinkPad X390 laptop
make ln_macos    # MacBook Pro M1 (macOS)
```

## 📁 Structure

```
dotfiles/
├── bin/                    # Custom scripts and utilities
├── fzf-open/              # FZF-based file opener
├── i3/                    # i3 window manager configs
├── i3status/              # i3status bar configs
├── newsboat/              # RSS feed reader configs
├── nvim/                  # Neovim configuration
├── wezterm/               # Terminal emulator configs
├── tmux/                  # Terminal multiplexer configs
├── vifm/                  # File manager configs and themes
├── xresources/            # X11 resources
├── sioyek/                # PDF viewer (Sioyek) configs
├── zathura/               # PDF viewer (Zathura) configs
├── Makefile               # Installation automation
├── pacman_packages_list.txt # Arch Linux package list
└── Various dotfiles       # .zshrc, .gitconfig, .Rprofile, etc.
```

## 🖥️ Supported Machines

### Production Machines

- **lisa**: Production desktop workstation
- **rambo**: Production desktop workstation

### Server

- **fusca**: Data server, setup for server management [syncthing](https://syncthing.net/)

### Laptops

- **x390**: ThinkPad X390 laptop 
- **macos**: MacBook Pro M1 (mbp-m1) with macOS-compatible subset of configurations

## ⚙️ Configuration Details

### Core Tools

- **Shell**: Zsh with [Oh My Zsh](https://ohmyz.sh/)
- **Editor**: [Neovim](https://neovim.io/) with Lua configuration
- **Terminal Multiplexer**: [Tmux](https://github.com/tmux/tmux) with TPM plugin manager
- **Window Manager**: [i3wm](https://i3wm.org/) (Linux machines)
- **File Manager**: [Vifm](https://github.com/vifm/vifm) 
- **Browser**: [Firefox](https://www.firefox.com)
- **PDF Viewer**: [Sioyek](https://sioyek.info/) / [Zathura](https://github.com/pwmt/zathura)
- **Terminal**: [WezTerm](https://wezterm.org)

### Custom Scripts

- `apple_keyboard.sh` - Apple keyboard mapping
- `x390_keyboard.sh` - ThinkPad X390 keyboard settings
- `foot_switch.sh` - USB foot switch configuration
- `volumeicon.sh` - Volume control
- `getLattes_update.sh` - Lattes curriculum updater
- Various R scripts for reference management

## 📦 Package Management

### Manjaro Linux

Install packages from the provided list:

```bash
# Install all packages from the list (official repos only)
pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(grep -v "\[aur\]" pacman_packages_list.txt | awk '{print $1}'))

# Generate current package list with source information
{
  pacman -Qn | awk '{print $1 " [official]"}'
  pacman -Qm | awk '{print $1 " [aur]"}'
} | sort > pacman_packages_list.txt
```

### Package Source Information

The package list includes source indicators:
- `[official]` - Packages from official Arch/Manjaro repositories
- `[aur]` - Packages from Arch User Repository (AUR)

To install AUR packages, use an AUR helper like `yay` or `paru`:

```bash
# Install AUR packages only
yay -S $(grep "\[aur\]" pacman_packages_list.txt | awk '{print $1}')

# Install all packages (requires AUR helper)
pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(grep -v "\[aur\]" pacman_packages_list.txt | awk '{print $1}'))
yay -S $(grep "\[aur\]" pacman_packages_list.txt | awk '{print $1}')
```

### Required Dependencies

```bash
# Python packages
python3 -m pip install pynvim

# Essential tools
pacman -S riprep fd fzf
```

- [pynvim](https://github.com/neovim/pynvim)
- [riprep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
- [fzf](https://github.com/junegunn/fzf)

## 🛠️ Manual Installations

### Plugin Managers

- [vim-plug](https://github.com/junegunn/vim-plug): Neovim plugin manager
- [tpm](https://github.com/tmux-plugins/tpm): tmux plugin manager

### Additional Tools

- [ripgrep](https://github.com/BurntSushi/ripgrep) - Fast text search
- [fd](https://github.com/sharkdp/fd) - User-friendly file finder
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - Zsh autosuggestions
- [pandoc](https://pandoc.org/) - Document conversion
- [quarto](https://quarto.org/) - Scientific publishing
- [translate-shell](https://github.com/soimort/translate-shell) - Translation tool
- [goldendict](http://www.goldendict.org/) - Dictionary application

## 🔧 Maintenance

### Remove Symbolic Links

```bash
# Remove all general links
make rm

# Remove machine-specific links
make rm_lisa
make rm_rambo
make rm_fusca
make rm_x390
make rm_macos
```

### Update Configurations

1. Make changes to files in `~/dotfiles`
2. Commit changes to git repository
3. Pull updates on other machines
4. Links will automatically use updated files

## 📚 Key Features

- **Multi-environment**: Supports production workstations, servers, and laptops
- **Cross-platform**: Works on Linux (Manjaro/Arch) and macOS
- **Machine-specific**: Tailored configurations for different hardware roles
- **Terminal-first**: Optimized for keyboard-driven workflow
- **Academic-focused**: Tools for research and writing
- **Minimalist**: Clean, efficient configurations
- **Version controlled**: All settings tracked in [git](https://git-scm.com)

## 🌟 Workflow Highlights

- [i3wm](https://i3wm.org/): Tiling window manager for productivity
- [neovim](https://neovim.io/): Modern Vim configuration with Lua
- [tmux](https://github.com/tmux/tmux): Persistent terminal sessions
- [vifm](https://github.com/vifm/vifm): Powerful file manager with Vim-like bindings
- [fzf](https://github.com/junegunn/fzf): Fuzzy finding for everything
- **R scripts**: Custom reference management tools as `bin/reference_manager.R`
- **Academic tools**: [LaTeX](https://yihui.org/tinytex/), [Pandoc](https://pandoc.org/), [Quarto](https://quarto.org/) integration

