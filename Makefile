dotfolder=~/dotfiles
configfolder=~/.config

help:
	@echo "make dirs          create required directories"
	@echo "make ln            shared symlinks (runs dirs automatically)"
	@echo "make ln_[machine]  machine-specific links (rambo, lisa, fusca, x390)"
	@echo "make rm                    remove all symlinks"
	@echo "make packages_install      install official packages"
	@echo "make packages_install_aur  install AUR packages"
	@echo "make packages_save         save current package list"

dirs:
	mkdir -p ~/.tmux $(configfolder)/nvim $(configfolder)/zathura $(configfolder)/vifm $(configfolder)/fzf-open $(configfolder)/wezterm $(configfolder)/sioyek $(configfolder)/i3 $(configfolder)/i3status

ln: dirs
	ln -sf $(dotfolder)/zsh/zshrc ~/.zshrc
	ln -sf $(dotfolder)/tmux/tmux.conf ~/.tmux.conf
	ln -sf $(dotfolder)/tmux/config.yaml ~/.tmux/config.yaml
	ln -sf $(dotfolder)/nvim/init.lua $(configfolder)/nvim/init.lua
	ln -sf $(dotfolder)/r/Rprofile ~/.Rprofile
	ln -sf $(dotfolder)/x11/XCompose ~/.XCompose
	ln -sf $(dotfolder)/git/gitconfig ~/.gitconfig
	ln -sf $(dotfolder)/zathura/zathurarc $(configfolder)/zathura/zathurarc
	ln -sf $(dotfolder)/desktop/mimeapps.list $(configfolder)/mimeapps.list
	ln -sf $(dotfolder)/r/lintr ~/.lintr
	ln -sf $(dotfolder)/r/styler.R ~/.styler.R
	ln -sf $(dotfolder)/vifm/colors $(configfolder)/vifm/
	ln -sf $(dotfolder)/vifm/favicons.vifm $(configfolder)/vifm/favicons.vifm
	ln -sf $(dotfolder)/vifm/vifmrc $(configfolder)/vifm/vifmrc
	ln -sf $(dotfolder)/fzf-open/lopen.sh $(configfolder)/fzf-open/lopen.sh
	ln -sf $(dotfolder)/wezterm/wezterm.lua $(configfolder)/wezterm/wezterm.lua
	ln -sf $(dotfolder)/sioyek/keys_user.config $(configfolder)/sioyek/keys_user.config
	ln -sf $(dotfolder)/sioyek/theme.sh $(configfolder)/sioyek/theme.sh
	$(configfolder)/sioyek/theme.sh dark
	ln -sf $(dotfolder)/i3/config $(configfolder)/i3/config
	ln -sf $(dotfolder)/x11/Xresources $(configfolder)/.Xresources


ln_lisa:
	ln -sf $(dotfolder)/i3/config_lisa $(configfolder)/i3/config_local
	ln -sf $(dotfolder)/i3status/config_lisa $(configfolder)/i3status/config


ln_rambo:
	ln -sf $(dotfolder)/i3/config_rambo $(configfolder)/i3/config_local
	ln -sf $(dotfolder)/i3status/config_rambo $(configfolder)/i3status/config


ln_fusca:
	ln -sf $(dotfolder)/i3/config_fusca $(configfolder)/i3/config_local
	ln -sf $(dotfolder)/i3status/config $(configfolder)/i3status/config


ln_x390:
	ln -sf $(dotfolder)/i3/config_x390 $(configfolder)/i3/config_local
	ln -sf $(dotfolder)/i3status/config_x390 $(configfolder)/i3status/config

rm:
	rm -f ~/.zshrc
	rm -f ~/.tmux.conf
	rm -f ~/.tmux/config.yaml
	rm -f $(configfolder)/nvim/init.lua
	rm -f ~/.Rprofile
	rm -f ~/.XCompose
	rm -f ~/.gitconfig
	rm -f $(configfolder)/zathura/zathurarc
	rm -f $(configfolder)/mimeapps.list
	rm -rf $(configfolder)/vifm/colors
	rm -f $(configfolder)/vifm/favicons.vifm
	rm -f $(configfolder)/vifm/vifmrc
	rm -f ~/.lintr
	rm -f ~/.styler.R
	rm -f $(configfolder)/.Xresources
	rm -f $(configfolder)/wezterm/wezterm.lua
	rm -f $(configfolder)/fzf-open/lopen.sh
	rm -f $(configfolder)/sioyek/keys_user.config
	rm -f $(configfolder)/sioyek/prefs_user.config
	rm -f $(configfolder)/sioyek/theme.sh
	rm -f $(configfolder)/i3/config
	rm -f $(configfolder)/i3/config_local
	rm -f $(configfolder)/i3status/config

packages_install:
	pacman -S --needed $$(comm -12 <(pacman -Slq | sort) <(grep -v "\[aur\]" pacman/packages_list.txt | awk '{print $$1}'))

packages_install_aur:
	yay -S $$(grep "\[aur\]" pacman/packages_list.txt | awk '{print $$1}')

packages_save:
	{ pacman -Qn | awk '{print $$1 " [official]"}'; pacman -Qm | awk '{print $$1 " [aur]"}'; } | sort > pacman/packages_list.txt

