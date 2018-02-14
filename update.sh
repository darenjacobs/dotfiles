#!/bin/bash

git subtree pull --prefix .vim/bundle/salt-vim --squash https://github.com/saltstack/salt-vim.git master
git subtree pull --prefix .vim/bundle/ctrlp.vim --squash https://github.com/ctrlpvim/ctrlp.vim.git master
git subtree pull --prefix .vim/bundle/gruvbox --squash https://github.com/morhetz/gruvbox.git master
git subtree pull --prefix .vim/bundle/nerdtree  --squash https://github.com/scrooloose/nerdtree master
git subtree pull --prefix .vim/bundle/salt-vim --squash https://github.com/saltstack/salt-vim.git master
git subtree pull --prefix .vim/bundle/vim-airline --squash https://github.com/bling/vim-airline master
git subtree pull --prefix .vim/bundle/vim-pathogen --squash https://github.com/tpope/vim-pathogen master
git subtree pull --prefix .vim/bundle/vim-startify --squash https://github.com/mhinz/vim-startify master
git subtree pull --prefix .vim/bundle/ale --squash https://github.com/w0rp/ale master
git subtree pull --prefix .vim/bundle/vim-flake8 --squash https://github.com/nvie/vim-flake8.git master
git subtree pull --prefix .vim/bundle/delimitmate --squash https://github.com/raimondi/delimitmate master





# https://developer.atlassian.com/blog/2015/05/the-power-of-git-subtree/
# https://stackoverflow.com/questions/19697968/how-to-make-an-existing-subdir-as-subtree-for-another-git-repo-with-squashed-co
