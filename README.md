## Vim Dotfiles

![DotFiles!](http://i.imgur.com/PY06Yto.jpg)

Mah dotfiles for Vim. You can see the list of plugins I use at the top of vimrc. I don't recommend copying wholesale but there might be some nice things in here to steal.

These files use [VimPlug](https://github.com/junegunn/vim-plug) to manage plugins.

Some of the stuff in here needs additonal support:

* YouCompleteMe needs to be compiled after it has been installed with `./install.sh` in the YouCompleteMe folder.
* CtrlP-CMatcher also has a compile step. Same instructions as above.
* Tern needs `npm install` to be run inside its directory.

A lot of this also assumes you have [The Silver Searcher](https://github.com/ggreer/the_silver_searcher) installed (`brew install ag`). It's used for Ctrl-P and project-wide searching.