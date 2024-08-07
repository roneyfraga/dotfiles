
How to use

`make ln` 

As __lisa__, __rambo__, __fusca__ and __frank__ are computers:

`make ln_fusca` 

`make ln_lisa` 

`make ln_frank` 

will link specifics files. 

Softwares
- [oh-my-zsh](https://ohmyz.sh/)
- [neovim](https://neovim.io/)
- [tmux](https://github.com/tmux/tmux/wiki)
- [zathura](https://pwmt.org/projects/zathura/)
- [ranger](https://github.com/ranger/ranger)
- [terminator](https://gnometerminator.blogspot.com/p/introduction.html)
- [r](https://cran.r-project.org/)
- [python](https://duckduckgo.com/?q=python+site:www.python.org)
- [julia](https://julialang.org/)
- [clang](https://clang.llvm.org/)
- [latex](https://wiki.archlinux.org/index.php/TeX_Live)
- [fzf](https://github.com/junegunn/fzf)
- [fzf-bibtex](https://github.com/msprev/fzf-bibtex)

Dependences 
-  `python3 -m pip install pynvim`
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
- [pip](https://pypi.org/project/pip/)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [bibtool](https://ctan.org/pkg/bibtool?lang=en)
- [papers](https://github.com/perrette/papers)
- [unoconv](https://github.com/unoconv/unoconv)
- [pandoc](https://pandoc.org/)
- [translate-shell](https://github.com/soimort/translate-shell)
- [youtube-dl](https://youtube-dl.org/)
- [goldendict](http://www.goldendict.org/)
- [asciiquarium](https://github.com/cmatsuoka/asciiquarium)
- [termdown](https://github.com/trehn/termdown)
- [quarto](https://quarto.org)

Plugin Managers
- [vimplug](https://github.com/junegunn/vim-plug) (nvim)
- [tpm](https://github.com/tmux-plugins/tpm) (tmux)

Install from packages `pacman_packages_list.txt` 

```
pacman -Q | awk '{print $1}' > pacman_packages_list.txt
pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort pacman_packages_list.txt))
```

