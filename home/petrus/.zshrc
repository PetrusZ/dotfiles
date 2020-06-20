# vim: foldmethod=marker
#  < antigen >{{{
# -----------------------------------------------------------------------------
if [[ ! -e ~/.antigen/antigen.zsh ]]; then
    if [[ ! -d ~/.antigen ]]; then
        mkdir -p ~/.antigen
    fi
    curl -L git.io/antigen > ~/.antigen/antigen.zsh
fi

source ~/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# oh-my-zsh plugins
# antigen bundle fd
antigen bundle fzf
antigen bundle git
antigen bundle docker
antigen bundle extract
antigen bundle encode64
antigen bundle common-aliases
# antigen bundle command-not-found
antigen bundle colored-man-pages
antigen bundle sudo
antigen bundle web-search
antigen bundle taskwarrior
antigen bundle z

# Other plugins
# antigen bundle b4b4r07/enhancd
antigen bundle Aloxaf/fzf-tab
antigen bundle djui/alias-tips
antigen bundle andrewferrier/fzf-z
antigen bundle paulirish/git-open
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search


# Load the theme.
antigen theme denysdovhan/spaceship-prompt

# Tell Antigen that you're done.
antigen apply
# -----------------------------------------------------------------------------"}}}

#  < user config >{{{
# -----------------------------------------------------------------------------
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# User configuration
if [[ $UID != 0 ]]; then
    PATH_LOCAL="/home/petrus/.local/bin"
    PATH_NODE_LOCAL="/home/petrus/.local/node_modules/.bin"
    PATH_GO_LOCAL="/home/petrus/.local/go/bin"
fi
PATH_DISTCC="/usr/lib/distcc/bin"
PATH_DOOM="/home/petrus/.emacs.d/bin"
export PATH="/usr/sbin:/usr/local/sbin:/sbin:${PATH_LOCAL}:${PATH_NODE_LOCAL}:${PATH_GO_LOCAL}:${PATH_DOOM}:${PATH}"
export FPATH="/usr/share/zsh/site-contrib:${FPATH}"
export GOPATH=$HOME/.local/go
export EDITOR="vim"
export BROWSER="chromium"

if [[ $UID != 0 ]]; then
    if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
        export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    fi
    # export GPG_TTY=$(tty)
    # unset SSH_AGENT_PID
    # gpg-connect-agent updatestartuptty /bye >/dev/null
fi

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# proxy
# export http_proxy=socks5://192.168.2.1:23456
# export https_proxy=socks5://192.168.2.1:23456

# NOTE:CONFLICT
# gentoo wiki recommended completion prompt
# autoload -U compinit promptinit
# compinit
# promptinit; prompt gentoo

# enable command auto-correction
# setopt correctall

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
# -----------------------------------------------------------------------------"}}}

#  < alias >{{{
# -----------------------------------------------------------------------------
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# more powerful ls
alias LS='find -mount -maxdepth 1 -printf "%.5m %10M %#9u:%-9g %#5U:%-5G %TF_%TR %CF_%CR %AF_%AR %#15s [%Y] %p\n" 2>/dev/null'

alias history_stamp='fc -il 1'

alias steam='LIBGL_DRI3_DISABLE=1 /usr/bin/steam'

alias vi='vim --clean'
alias vim-tiny='vim -u ~/.vim/vim-tiny.vim'

alias mail_read="mail -f $HOME/mbox"

alias man_zh='LANG=zh_CN.utf8 man'

alias preview="fzf --preview 'bat --color \"always\" {}'"

alias ccache='CCACHE_DIR=/var/cache/ccache ccache'

alias spacevim='vim -u ~/Project/SpaceVim/init.vim'

alias yarn='yarn --cwd ~/.local'

alias glances='glances --enable-plugin connections,diskio,docker,cloud,floders,fs,ip,sensors,smart,wifi,system,quicklook,alert'

alias proxychains='proxychains -q'

unalias fd
# -----------------------------------------------------------------------------"}}}

#  < spaceship >{{{
# -----------------------------------------------------------------------------
# spaceship theme setting
spaceship_rename_terminal_window() {
  # Reset tmux pane title
  printf '\033]2;%s\033\\' "${PWD/#$HOME/~}"
}

SPACESHIP_PROMPT_ORDER=(
  rename_terminal_window
  time
  user
  dir
  host
  git
  exec_time
  line_sep
  jobs
  exit_code
  char
)

# SPACESHIP_CHAR_SYMBOL="❯ "
# SPACESHIP_JOBS_SYMBOL="»"
SPACESHIP_TIME_SHOW=true
SPACESHIP_USER_PREFIX="as "
SPACESHIP_USER_SHOW="needed"
SPACESHIP_DIR_TRUNC=0
SPACESHIP_DIR_TRUNC_PREFIX=".../"
SPACESHIP_DIR_TRUNC_REPO=false
# -----------------------------------------------------------------------------"}}}
