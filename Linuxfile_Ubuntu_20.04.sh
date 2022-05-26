#!/usr/bin/env bash

################################################################################
# Linuxfile_Ubuntu_20.04.sh
# Updated 2022-05-26
#
# Juan Irming
#
# Run on fresh Ubuntu instance to install and configure the necessities.

script_name='Linuxfile_Ubuntu_20.04'
begin_tag="##### BEGIN $script_name #####"
end_tag="##### END $script_name #####"

cd ~

################################################################################
# Upgrade installed packages

sudo apt update
sudo apt upgrade -y

################################################################################
# Install packages

sudo apt install -y screen
sudo apt install -y vim
sudo apt install -y htop
sudo apt install -y tree
sudo apt install -y whois
sudo apt install -y traceroute
sudo apt install -y mc
sudo apt install -y ranger
sudo apt install -y hexedit
sudo apt install -y docker.io
sudo apt install -y elinks
sudo apt install -y git
sudo apt install -y python3
sudo apt install -y python3-pip
sudo apt install -y golang
sudo apt install -y nodejs
#sudo apt install -y php
sudo apt install -y perl
#sudo apt install -y ruby

# .NET
# Add Microsoft
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
# Install
sudo apt update
sudo apt install -y apt-transport-https && sudo apt update && sudo apt install -y dotnet-sdk-6.0

sudo apt install -y nuget

################################################################################
# Create symlinks

# Make "python" execute "python3"
sudo ln -s /usr/bin/python3 /usr/bin/python

################################################################################
# Install Python packages

pip install requests
pip install boto3

################################################################################
# Append .profile

cat <<EOT >> ~/.profile

$begin_tag
# Show git branch in bash prompt
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

# Enable command line Google search
function se() {
    IFS='+'
    elinks "https://www.startpage.com/do/search?query=\$*"
}
export -f se

# Enable command line Wikipedia search
function wi() {
    IFS='_'
    elinks "https://en.wikipedia.org/wiki/\$*"
}
export -f wi

# WSL
#cd \$HOME

# Automatically create/re-attach screen session (useful for remote hosts)
screen -DRAS main
$end_tag
EOT

################################################################################
# Append .bash_aliases

cat <<EOT >> ~/.bash_aliases

$begin_tag
alias os='lsb_release -a'

alias s='screen -DRAS main'
alias r='ranger'
alias he='hexedit'

alias nvok='~/nvok/nvok'

alias gb='git branch'
alias gl='git log'
alias gp='git pull'
alias gs='git status'

alias dnb='dotnet build'
alias dnr='dotnet run'

alias dps='docker ps'
alias dtop='watch -n 1 docker ps'

# Get sh on running Docker container
function dsh {
        docker exec -it "\$1" /bin/sh
}
export -f dsh

# Get bash on running Docker container
function dbash {
        docker exec -it "\$1" /bin/bash
}
export -f dbash
$end_tag
EOT

################################################################################
# OVERWRITE .screenrc

cat <<EOT > ~/.screenrc
$begin_tag
msgwait 0

term xterm-256color

autodetach on
startup_message off
hardstatus alwayslastline
shelltitle 'bash'

hardstatus string '%{gk}[%{wk}%?%-Lw%?%{=b kR}(%{W}%n*%f %t%?(%u)%?%{=b kR})%{= w}%?%+Lw%?%? %{g}][%{d}%l%{g}][ %{= w}%Y/%m/%d %0C:%s%a%{g} ]%{W}'
$end_tag
EOT

################################################################################
# OVERWRITE .vimrc

cat <<EOT > ~/.vimrc
" $begin_tag
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
colorscheme elflord
let g:airline_theme='solarized'

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
let NERDTreeShowHidden=1
" $end_tag
EOT

################################################################################
# OVERWRITE .config/mc/ini

mkdir -p ~/.config/mc

cat <<EOT > ~/.config/mc/ini
[Midnight-Commander]
verbose=true
shell_patterns=true
auto_save_setup=true
preallocate_space=false
auto_menu=false
use_internal_view=true
use_internal_edit=false
clear_before_exec=true
confirm_delete=true
confirm_overwrite=true
confirm_execute=false
confirm_history_cleanup=true
confirm_exit=false
confirm_directory_hotlist_delete=false
confirm_view_dir=false
safe_delete=false
safe_overwrite=false
use_8th_bit_as_meta=false
mouse_move_pages_viewer=true
mouse_close_dialog=false
fast_refresh=false
drop_menus=false
wrap_mode=true
old_esc_mode=true
cd_symlinks=true
show_all_if_ambiguous=false
use_file_to_guess_type=true
alternate_plus_minus=false
only_leading_plus_minus=true
show_output_starts_shell=false
xtree_mode=false
file_op_compute_totals=true
classic_progressbar=true
use_netrc=true
ftpfs_always_use_proxy=false
ftpfs_use_passive_connections=true
ftpfs_use_passive_connections_over_proxy=false
ftpfs_use_unix_list_options=true
ftpfs_first_cd_then_ls=true
ignore_ftp_chattr_errors=true
editor_fill_tabs_with_spaces=false
editor_return_does_auto_indent=false
editor_backspace_through_tabs=false
editor_fake_half_tabs=true
editor_option_save_position=true
editor_option_auto_para_formatting=false
editor_option_typewriter_wrap=false
editor_edit_confirm_save=true
editor_syntax_highlighting=true
editor_persistent_selections=true
editor_drop_selection_on_copy=true
editor_cursor_beyond_eol=false
editor_cursor_after_inserted_block=false
editor_visible_tabs=true
editor_visible_spaces=true
editor_line_state=false
editor_simple_statusbar=false
editor_check_new_line=false
editor_show_right_margin=false
editor_group_undo=true
editor_state_full_filename=true
editor_ask_filename_before_edit=false
nice_rotating_dash=true
mcview_remember_file_position=false
auto_fill_mkdir_name=true
copymove_persistent_attr=true
pause_after_run=1
mouse_repeat_rate=100
double_click_speed=250
old_esc_mode_timeout=1000000
max_dirt_limit=10
num_history_items_recorded=60
vfs_timeout=60
ftpfs_directory_timeout=900
ftpfs_retry_seconds=30
fish_directory_timeout=900
editor_tab_spacing=8
editor_word_wrap_line_length=72
editor_option_save_mode=0
editor_backup_extension=~
editor_filesize_threshold=64M
editor_stop_format_chars=-+*\\,.;:&>
mcview_eof=
skin=modarin256-defbg

[Layout]
output_lines=0
left_panel_size=104
top_panel_size=0
message_visible=false
keybar_visible=true
xterm_title=true
command_prompt=true
menubar_visible=true
free_space=true
horizontal_split=false
vertical_equal=true
horizontal_equal=true

[Misc]
timeformat_recent=%b %e %H:%M
timeformat_old=%b %e  %Y
ftp_proxy_host=gate
ftpfs_password=anonymous@
display_codepage=UTF-8
source_codepage=Other_8_bit
autodetect_codeset=
spell_language=en
clipboard_store=
clipboard_paste=

[Colors]
base_color=
xterm-256color=
color_terminals=

screen.xterm-256color=

[Panels]
show_mini_info=true
kilobyte_si=false
mix_all_files=false
show_backups=true
show_dot_files=true
fast_reload=false
fast_reload_msg_shown=false
mark_moves_down=true
reverse_files_only=true
auto_save_setup_panels=false
navigate_with_arrows=true
panel_scroll_pages=true
panel_scroll_center=false
mouse_move_pages=true
filetype_mode=true
permission_mode=false
torben_fj_mode=false
quick_search_mode=2
select_flags=6

simple_swap=false

[Panelize]
Find *.orig after patching=find . -name \\*.orig -print
Find SUID and SGID programs=find . \\( \\( -perm -04000 -a -perm /011 \\) -o \\( -perm -02000 -a -perm /01 \\) \\) -print
Find rejects after patching=find . -name \\*.rej -print
Modified git files=git ls-files --modified
EOT

################################################################################
# Install vim packages

cd ~

mkdir -p ~/.vim/pack

# Solarized theme
mkdir -p ~/.vim/pack/themes/opt/solarized8
git clone https://github.com/lifepillar/vim-solarized8.git ~/.vim/pack/themes/opt/solarized8

# Airline
mkdir -p ~/.vim/pack/dist/start/vim-airline
git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
vim -u NONE -c "helptags ~/.vim/pack/dist/start/vim-airline/doc" -c q

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

mkdir ~/nvok
git clone https://github.com/juanirming/nvok.git ~/nvok
chmod 700 ~/nvok/nvok

################################################################################
# Misc

# WSL
#sudo /etc/init.d/screen-cleanup start

