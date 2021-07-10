#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
oldPS1='[\u@\h \W]\$ '
PS1='\[\e[0;1;91m\][\[\e[0;1;94m\]\u\[\e[0m\]@\[\e[0;1;94m\]\H\[\e[m\] \[\e[0;3m\]\W\[\e[0;1;91m\]]\[\e[0m\]\$\[\e[m\] \[\e0'

# custom aliases
alias l='ls -ahl --color=auto'
alias ll='ls -hl --color=auto'
alias rm='echo "are you sure about that?"'

# editing configs
alias cfb="vim ~/.bashrc && source ~/.bashrc"
alias cfi="vim ~/.config/i3/config"
alias cfii="vim ~/.config/i3blocks/config"
alias cff="vim ~/.config/fontconfig/fonts.conf"
alias cfv="vim ~/.vimrc"
alias cfvv="vim ~/.config/nvim/init.vim"
alias cfp="vim ~/.config/picom.conf"

alias clc="calcurse"
alias tdwn="transmission-daemon"
alias tdir="cd ~/myfiles/junk/testspace"
alias jupy="coa pyimg;jupyter notebook"
alias npc="ncmpcpp"
alias playalert="mpv --really-quiet ~/.local/share/sounds/complete.ogg"
alias ytdl="youtube-dl -f 'bestvideo[height<=720]+bestaudio' -o '%(title)s.%(ext)s'"
alias ytdlp="youtube-dl -f 'bestvideo[height<=720]+bestaudio' -o '%(playlist_index)s-%(title)s.%(ext)s'"
alias ctodo="vim ~/myfiles/todo.md"
alias vki="vim -c ':VimwikiIndex'"
alias vimwiki="vim -c ':VimwikiIndex'"

# for setting default scale as 4 in bc
#alias bc="BC_ENV_ARGS=<(echo "scale=4") \bc"

# code editor aliases
alias v="vim"
alias vv="nvim"
alias nv="nvim"
alias nf="neofetch"

# alias qn="export QNDATE=$(date +%d-%m-%4Y); vim ~/myfiles/junk/qnotes/$QNDATE"
alias qnl="vim ~/myfiles/junk/qnotes"

# life improvements
alias cwall="feh --bg-fill --randomize ~/myfiles/wallpapers/*"
alias nlock="betterlockscreen -u ~/myfiles/wallpapers/2021-summer/ -r 1920x1080"
alias update="sudo pacman -Syyu"
alias myip="curl ipinfo.io/ip"
alias lm="ls -tlh"
alias passgh="pass github-pat | xclip -i -r -sel clipboard"
alias coa="conda activate"
alias mpvq="mpv --no-video"

# quiet and interacture youtube audio player
alias ytp="youtube-viewer -n --no-video-info --player=mpvt"

# devour aliases
alias fehd="devour feh --scale-down"
alias mpvd="devour mpv"
alias zathurd="devour zathura"

export EDITOR=vim
export BROWSER=brave
export browser=brave
export PATH="$HOME/.local/bin:$HOME/myfiles/scripts:$PATH"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"

# nnn envars
[ -n "$NNNLVL" ] && PS1="N$NNNLVL $PS1"

export NNN_PLUG='d:dragdrop;p:preview-tabbed;f:fzopen;r:_devour okular $nnn*;n:_nvim $nnn*'
alias nnn="nnn -rcC"
alias n="nnn -rcC"
alias nn="nnn -r"
alias nnp="nnn -r -P p"
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_BMS='b:~/myfiles/blog;y:~/myfiles/projects/pyimg/pyimgbook;g:~/myfiles/projects/github;w:~/myfiles/wallpapers;j:~/myfiles/junk;p:~/myfiles/projects;u:/run/media/pritom;d:~/Downloads/;b:~/myfiles/bluetooth;P:~/myfiles/pdfs;s:~/myfiles/scripts;'
export NNN_OPENER=$HOME/.config/nnn/plugins/nuke

# aliases for blog sync [DEPRECATED]
# alias downblog="rsync -e 'ssh -i ~/Downloads/pc-arch-sync/aws_educate.pem' -avz ubuntu@54.160.105.137:/var/www/html/rustyelectron.live/public_html/ ~/myfiles/blog/"
# alias upblog="rsync -e 'ssh -i ~/Downloads/pc-arch-sync/aws_educate.pem' -avz ~/myfiles/blog/ ubuntu@54.160.105.137:/var/www/html/rustyelectron.live/public_html/"

# aliases for fzf
export FZF_DEFAULT_COMMAND="rg --files --hidden"
alias cpcmd="history | cut -c 8- | fzf | xclip -i -r -sel clipboard"
alias c='file=$(rg --files --hidden | fzf | sed "s~/[^/]*$~/~");[[ "$file" == "" ]]|| cd "$file"'
alias f='vfz'
alias fzfo='devour xdg-open "$(rg --files | fzf)" &> /dev/null'
alias op='devour zathura "$(rg --files -t pdf | fzf)"'
alias rgf='$(rg --files | fzf)'
# spring cleaning
# ---------------
# XDG
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"

# jupyter
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter

# npm
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

# adb
export ANDROID_HOME="$HOME/drive/android/"
export ANDROID_SDK_ROOT="$HOME/drive/android/"
export ANDROID_SDK_HOME="$ANDROID_HOME/.android"
export ANDROID_AVD_HOME="$ANDROID_HOME"
export ANDROID_EMULATOR_HOME="$ANDROID_HOME"
# export ADB_VENDOR_KEY="$XDG_CONFIG_HOME"/android

# less
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history

# gtk 2.0
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

# wget
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'

# notmuch
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME"/notmuch/notmuchrc
export NMBGIT="$XDG_DATA_HOME"/notmuch/nmbug

# pass
#export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export PASSWORD_STORE_X_SELECTION=primary

# ------------------

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/pritom/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/pritom/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/pritom/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/pritom/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# ruby gems
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"

# flutter
export PATH="$PATH:$HOME/drive/flutter/bin"
# android sdk
export PATH="$PATH:$ANDROID_HOME/tools/bin/"
export PATH="$PATH:$ANDROID_HOME/platform-tools/"
export PATH="$PATH:$ANDROID_HOME/emulator/"
