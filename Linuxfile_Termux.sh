#!/data/data/com.termux/files/usr/bin/bash

################################################################################
# Linuxfile_Termux.sh
# Updated 2025-03-19
#
# Juan Irming
#
# Run on fresh Termux instance to install and configure the necessities.

cd ~

################################################################################
# Upgrade installed packages

pkg update -y

################################################################################
# Install packages (Termux-compatible)

pkg install -y vim htop tree mc ranger hexedit elinks git python nodejs perl golang

################################################################################
# Install Python packages

pip install --upgrade pip
pip install requests

################################################################################
# Append .bashrc

cat <<'EOT' >> ~/.bashrc

# Show git branch in bash prompt
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

# Enable command line Google search
function se() {
    IFS='+'; elinks "https://www.startpage.com/do/search?query=$*"
}
export -f se

# Enable command line Wikipedia search
function wi() {
    IFS='_'; elinks "https://en.wikipedia.org/wiki/$*"
}
export -f wi

PYTHONPATH="$HOME/nvok/scripts/lib"; export PYTHONPATH

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
EOT

################################################################################
# Append .bash_aliases

cat <<'EOT' >> ~/.bash_aliases

alias vi='vim'

alias ll='ls -al'

alias os='uname -a'
alias r='ranger'
alias he='hexedit'
alias nvok='~/nvok/nvok'

alias gb='git branch'
alias gl='git log'
alias gp='git pull'
alias gs='git status'

EOT

################################################################################
# Setup .vimrc

cat <<'EOT' > ~/.vimrc
set nowrap
set number
set ruler
set ic
set ai
set si
set tabstop=4
set showmatch
set noerrorbells
set novisualbell
set noeb vb t_vb=
syntax on
set background=dark
"colorscheme elflord
let g:airline_theme='solarized'
EOT

################################################################################
# Install Vim Plugins

mkdir -p ~/.vim/pack

# Solarized theme
mkdir -p ~/.vim/pack/themes/opt/solarized8
git clone https://github.com/lifepillar/vim-solarized8.git ~/.vim/pack/themes/opt/solarized8

# Airline
mkdir -p ~/.vim/pack/dist/start/vim-airline
git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
vim -u NONE -c "helptags ~/.vim/pack/dist/start/vim-airline/doc" -c q

mkdir -p ~/.vim/pack/dist/start/vim-airline-themes
git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/pack/dist/start/vim-airline-themes
vim -u NONE -c "helptags ~/.vim/pack/dist/start/vim-airline-themes/doc" -c q

# Fugitive
mkdir -p ~/.vim/pack/tpope/start
git clone https://tpope.io/vim/fugitive.git ~/.vim/pack/tpope/start
vim -u NONE -c "helptags ~/.vim/pack/tpope/start/fugitive/doc" -c q

# NERDTree
mkdir -p ~/.vim/pack/vendor/start/nerdtree
git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree
vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q

################################################################################
# Install nvok

mkdir -p ~/nvok
git clone https://github.com/juanirming/nvok.git ~/nvok
chmod 700 ~/nvok/nvok
