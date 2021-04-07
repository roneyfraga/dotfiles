# como utilizar
# make ln 					## para links gerais, e depois
# make ln _[máquina] 		## para máquina de desejo

dotfolder=~/OneDrive/CLI/dotfiles
configfolder=~/.config

ln:
	ln -s $(dotfolder)/zshrc ~/.zshrc
	ln -s $(dotfolder)/tmux.conf ~/.tmux.conf
	ln -s $(dotfolder)/nvim/init.vim ~/.config/nvim/init.vim
	ln -s $(dotfolder)/nvim/coc-settins.json ~/.config/nvim/coc-settins.json
	ln -s $(dotfolder)/nvim/spell ~/.vim/spell 
	ln -s $(dotfolder)/Rprofile ~/.Rprofile
	ln -s $(dotfolder)/gitconfig ~/.gitconfig
	ln -s $(dotfolder)/joplin/keymap.json $(configfolder)/joplin/keymap.json 
	ln -s $(dotfolder)/ranger/rc.conf $(configfolder)/ranger/rc.conf
	ln -s $(dotfolder)/ranger/rifle.conf $(configfolder)/ranger/rifle.conf
	ln -s $(dotfolder)/zathura/zathurarc $(configfolder)/zathura/zathurarc
	ln -s $(dotfolder)/terminator/config $(configfolder)/terminator/config
	ln -s $(dotfolder)/mimeapps.list $(configfolder)/mimeapps.list

ln_x270:
	ln -s $(dotfolder)/i3/config_x270 $(configfolder)/i3/config
	ln -s $(dotfolder)/i3status/config_x270 $(configfolder)/i3status/config
	ln -s $(dotfolder)/qutebrowser/config_x270.py $(configfolder)/qutebrowser/config.py
	ln -s $(dotfolder)/xresources/Xresources_x270 ~/.Xresources

ln_frank:
	ln -s $(dotfolder)/i3/config_frank $(configfolder)/i3/config
	ln -s $(dotfolder)/i3status/config $(configfolder)/i3status/config
	ln -s $(dotfolder)/qutebrowser/config.py $(configfolder)/qutebrowser/config.py
	ln -s $(dotfolder)/xresources/Xresources ~/.Xresources

ln_guarani:
	ln -s $(dotfolder)/i3/config_guarani $(configfolder)/i3/config
	ln -s $(dotfolder)/i3status/config $(configfolder)/i3status/config
	ln -s $(dotfolder)/qutebrowser/config.py $(configfolder)/qutebrowser/config.py
	ln -s $(dotfolder)/xresources/Xresources ~/.Xresources

ln_fusca:
	ln -s $(dotfolder)/i3/config_fusca $(configfolder)/i3/config
	ln -s $(dotfolder)/i3status/config $(configfolder)/i3status/config
	ln -s $(dotfolder)/xresources/Xresources ~/.Xresources

rm:
	rm -f ~/.zshrc
	rm -f ~/.tmux.conf
	rm -f ~/.config/nvim/init.vim
	rm -f ~/.vim/spell
	rm -f ~/.Rprofile
	rm -f ~/.gitconfig
	rm -f $(configfolder)/joplin/keymap.json 
	rm -f $(configfolder)/ranger/rc.conf
	rm -f $(configfolder)/ranger/rifle.conf
	rm -f $(configfolder)/zathura/zathurarc
	rm -f $(configfolder)/terminator/config
	rm -f $(configfolder)/qutebrowser/config.py
	rm -f $(configfolder)/mimeapps.list

rm_x270:
	rm -f $(configfolder)/i3/config
	rm -f $(configfolder)/i3status/config
	rm -f $(configfolder)/qutebrowser/config.py
	rm -f ~/.Xresources

rm_frank:
	rm -f $(configfolder)/i3/config
	rm -f $(configfolder)/i3status/config
	rm -f $(configfolder)/qutebrowser/config.py
	rm -f ~/.Xresources

rm_guarani:
	rm -f $(configfolder)/i3/config
	rm -f $(configfolder)/i3status/config
	rm -f $(configfolder)/qutebrowser/config.py
	rm -f ~/.Xresources

