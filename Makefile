# como utilizar
# make ln 					## para links gerais, e depois
# make ln _[máquina] 		## para máquina de desejo

dotfolder=~/OneDrive/CLI/dotfiles
configfolder=~/.config

ln:
	ln -s $(dotfolder)/zshrc ~/.zshrc
	ln -s $(dotfolder)/tmux.conf ~/.tmux.conf
	ln -s $(dotfolder)/vimrc ~/.vimrc
	ln -s $(dotfolder)/vim/spell ~/.vim/spell 
	ln -s $(dotfolder)/vim/snippets/markdown.snippets ~/.vim/plugged/snipmate.vim/snippets/markdown.snippets
	ln -s $(dotfolder)/vim/snippets/md.snippets ~/.vim/plugged/snipmate.vim/snippets/md.snippets
	ln -s $(dotfolder)/vim/snippets/rmd.snippets ~/.vim/plugged/snipmate.vim/snippets/rmd.snippets
	ln -s $(dotfolder)/vim/snippets/r.snippets ~/.vim/plugged/snipmate.vim/snippets/r.snippets
	ln -s $(dotfolder)/Rprofile ~/.Rprofile
	ln -s $(dotfolder)/gitconfig ~/.gitconfig
	ln -s $(dotfolder)/joplin/keymap.json $(configfolder)/joplin/keymap.json 
	ln -s $(dotfolder)/ranger/rc.conf $(configfolder)/ranger/rc.conf
	ln -s $(dotfolder)/ranger/rifle.conf $(configfolder)/ranger/rifle.conf
	ln -s $(dotfolder)/zathura/zathurarc $(configfolder)/zathura/zathurarc
	ln -s $(dotfolder)/terminator/config $(configfolder)/terminator/config

ln_x270:
	ln -s $(dotfolder)/i3/config_x270 $(configfolder)/i3/config
	ln -s $(dotfolder)/i3status/config_x270 $(configfolder)/i3status/config
	ln -s $(dotfolder)/qutebrowser/config_x270.py $(configfolder)/qutebrowser/config.py
	ln -s $(dotfolder)/Xresources ~/.Xresources

ln_frank:
	ln -s $(dotfolder)/i3/config_frank $(configfolder)/i3/config
	ln -s $(dotfolder)/i3status/config $(configfolder)/i3status/config
	ln -s $(dotfolder)/qutebrowser/config.py $(configfolder)/qutebrowser/config.py

ln_guarani:
	ln -s $(dotfolder)/i3/config_guarani $(configfolder)/i3/config
	ln -s $(dotfolder)/i3status/config $(configfolder)/i3status/config
	ln -s $(dotfolder)/qutebrowser/config.py $(configfolder)/qutebrowser/config.py

rm:
	rm -f ~/.zshrc
	rm -f ~/.tmux.conf
	rm -f ~/.vimrc
	rm -f ~/.vim/spell
	rm -f ~/.vim/plugged/snipmate.vim/snippets/markdown.snippets
	rm -f ~/.vim/plugged/snipmate.vim/snippets/md.snippets
	rm -f ~/.vim/plugged/snipmate.vim/snippets/rmd.snippets
	rm -f ~/.vim/plugged/snipmate.vim/snippets/r.snippets
	rm -f ~/.Rprofile
	rm -f $(configfolder)/joplin/keymap.json 
	rm -f $(configfolder)/ranger/rc.conf
	rm -f $(configfolder)/ranger/rifle.conf
	rm -f $(configfolder)/zathura/zathurarc
	rm -f $(configfolder)/terminator/config
	rm -f $(configfolder)/qutebrowser/config.py

rm_x270:
	rm -f $(configfolder)/i3/config
	rm -f $(configfolder)/i3status/config
	rm -f $(configfolder)/qutebrowser/config.py
	rm -f ~/.Xresources

rm_frank:
	rm -f $(configfolder)/i3/config
	rm -f $(configfolder)/i3status/config
	rm -f $(configfolder)/qutebrowser/config.py

rm_guarani:
	rm -f $(configfolder)/i3/config
	rm -f $(configfolder)/i3status/config
	rm -f $(configfolder)/qutebrowser/config.py
