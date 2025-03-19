# como utilizar
#
# make ln 					## para links gerais, e depois
# make ln _[máquina] 		## para máquina de desejo
# 
# make rm					## remover links
# make rm_[máquina]			## remover links para máquina específica

dotfolder=~/dotfiles
configfolder=~/.config

ln:
	ln -s $(dotfolder)/zshrc ~/.zshrc
	ln -s $(dotfolder)/tmux/tmux.conf ~/.tmux.conf
	ln -s $(dotfolder)/tmux/config.yaml ~/.tmux/config.yaml
	ln -s $(dotfolder)/nvim/init.lua ~/.config/nvim/init.lua
	ln -s $(dotfolder)/nvim/coc-settings.json $(configfolder)/nvim/coc-settings.json
	ln -s $(dotfolder)/nvim/spell ~/.config/nvim/spell 
	ln -s $(dotfolder)/Rprofile ~/.Rprofile
	ln -s $(dotfolder)/gitconfig ~/.gitconfig
	ln -s $(dotfolder)/zathura/zathurarc $(configfolder)/zathura/zathurarc
	ln -s $(dotfolder)/mimeapps.list $(configfolder)/mimeapps.list
	ln -s $(dotfolder)/pydoro.ini ~/.pydoro.ini
	ln -s $(dotfolder)/lintr ~/.lintr
	ln -s $(dotfolder)/styler ~/.styler.R
	ln -s $(dotfolder)/vifm/colors $(configfolder)/vifm/
	ln -s $(dotfolder)/vifm/favicons.vifm $(configfolder)/vifm/favicons.vifm
	ln -s $(dotfolder)/vifm/vifmrc $(configfolder)/vifm/vifmrc
	ln -s $(dotfolder)/fzf-open/lopen.sh $(configfolder)/fzf-open/lopen.sh
	ln -s $(dotfolder)/terminator/config $(configfolder)/terminator/config
	# ln -s $(dotfolder)/newsbolt/config ~/.newsboat/config
	# ln -s $(dotfolder)/newsbolt/urls ~/.newsboat/urls

ln_lisa:
	ln -s $(dotfolder)/i3/config_lisa $(configfolder)/i3/config
	ln -s $(dotfolder)/i3status/config_lisa $(configfolder)/i3status/config
	ln -s $(dotfolder)/qutebrowser/config_lisa.py $(configfolder)/qutebrowser/config.py
	ln -s $(dotfolder)/xresources/Xresources $(configfolder)/.Xresources

ln_rambo:
	ln -s $(dotfolder)/i3/config_rambo $(configfolder)/i3/config
	ln -s $(dotfolder)/i3status/config_rambo $(configfolder)/i3status/config
	ln -s $(dotfolder)/qutebrowser/config_rambo.py $(configfolder)/qutebrowser/config.py
	ln -s $(dotfolder)/xresources/Xresources $(configfolder)/.Xresources

ln_fusca:
	ln -s $(dotfolder)/i3/config_fusca $(configfolder)/i3/config
	ln -s $(dotfolder)/i3status/config $(configfolder)/i3status/config
	ln -s $(dotfolder)/xresources/Xresources $(configfolder)/.Xresources

ln_x390:
	ln -s $(dotfolder)/i3/config_x390 $(configfolder)/i3/config
	ln -s $(dotfolder)/i3status/config_x390 $(configfolder)/i3status/config


ln_frank:
	ln -s $(dotfolder)/i3/config_frank $(configfolder)/i3/config
	ln -s $(dotfolder)/i3status/config $(configfolder)/i3status/config
	ln -s $(dotfolder)/xresources/Xresources $(configfolder)/.Xresources

ln_macos:
	ln -s $(dotfolder)/zshrc ~/.zshrc
	ln -s $(dotfolder)/tmux.conf ~/.tmux.conf
	ln -s $(dotfolder)/nvim/init.lua ~/.config/nvim/init.lua
	ln -s $(dotfolder)/nvim/coc-settings.json $(configfolder)/nvim/coc-settings.json
	ln -s $(dotfolder)/nvim/spell ~/.config/nvim/spell 
	ln -s $(dotfolder)/Rprofile ~/.Rprofile
	ln -s $(dotfolder)/gitconfig ~/.gitconfig
	ln -s $(dotfolder)/lintr ~/.lintr
	ln -s $(dotfolder)/vifm/colors $(configfolder)/vifm/
	ln -s $(dotfolder)/vifm/favicons.vifm $(configfolder)/vifm/favicons.vifm
	ln -s $(dotfolder)/vifm/vifmrc_mac $(configfolder)/vifm/vifmrc

rm:
	rm -f ~/.zshrc
	rm -f ~/.tmux.conf
	rm -f ~/.tmux/config.yaml
	rm -f ~/.config/nvim/init.vim
	rm -f ~/.config/nvim/init.lua
	rm -rf ~/.config/nvim/spell
	rm -f ~/.vim/spell
	rm -f ~/.Rprofile
	rm -f ~/.gitconfig
	rm -f $(configfolder)/zathura/zathurarc
	rm -f $(configfolder)/qutebrowser/config.py
	rm -f $(configfolder)/mimeapps.list
	rm -f $(configfolder)/nvim/coc-settins.json
	rm -rf $(configfolder)/vifm/colors
	rm -f $(configfolder)/vifm/favicons.vifm
	rm -f ~/.lintr
	rm -f ~/.pydoro.ini
	rm -f $(configfolder)/nvim/coc-settings.json
	rm -f $(configfolder)/vifm/favicons.vifm
	rm -f $(configfolder)/vifm/vifmrc
	rm -f $(configfolder)/.Xresources
	rm -f $(configfolder)/terminator/config
	rm -f $(configfolder)/fzf-open/lopen.sh
	# rm -f ~/.newsboat/config
	# rm -f ~/.newsboat/urls

rm_lisa:
	rm -f $(configfolder)/i3/config
	rm -f $(configfolder)/i3status/config
	rm -f $(configfolder)/qutebrowser/config.py

rm_rambo:
	rm -f $(configfolder)/i3/config
	rm -f $(configfolder)/i3status/config
	rm -f $(configfolder)/qutebrowser/config.py

rm_fusca:
	rm -f $(configfolder)/i3/config
	rm -f $(configfolder)/i3status/config
	rm -f $(configfolder)/qutebrowser/config.py

rm_x390:
	rm -f $(configfolder)/i3/config
	rm -f $(configfolder)/i3status/config

rm_frank:
	rm -f $(configfolder)/i3/config
	rm -f $(configfolder)/i3status/config
	rm -f $(configfolder)/qutebrowser/config.py

rm_macos:
	rm -r ~/.zshrc
	rm -r ~/.tmux.conf
	rm -r ~/.config/nvim/init.vim
	rm -r $(configfolder)/nvim/coc-settings.json
	rm -r ~/.config/nvim/spell 
	rm -r ~/.Rprofile
	rm -r ~/.gitconfig
	rm -r ~/.lintr
	rm -r $(configfolder)/vifm/favicons.vifm
	rm -r $(configfolder)/vifm/vifmrc

