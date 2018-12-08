export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color
export CLICOLOR_FORCE=1

# If you come from bash you might have to change your $PATH.
export PATH=/usr/local/bin:/usr/local/sbin:$PATH:$HOME/.bin

# Path to your oh-my-zsh installation.
export ZSH=/Users/tristan/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="tristan"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
eval "$(hub alias -s)"
plugins=(docker fasd git vi-mode zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR=vim

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

setopt ignoreeof
unsetopt share_history

KEYTIMEOUT=15 # Raised from 1 because `bindkey '\e.'` wasn't working
bindkey '\e.' insert-last-word

# Place cursor at beginning of line in vicmd mode
up-and-beginning() {
  zle up-history
  zle beginning-of-line
}
down-and-beginning() {
  zle down-history
  zle beginning-of-line
}
bindkey -M vicmd k up-and-beginning
bindkey -M vicmd j down-and-beginning
zle -N up-and-beginning
zle -N down-and-beginning

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'
bindkey '^[[16~' forward-word  # S-TAB
bindkey '^[[25~' autosuggest-execute  # S-CR

fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

ua() {
  local cmd=$1
  [ "$(whence -w $cmd | awk '{print $2}')" = "alias" ] && unalias $cmd
}

# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
# Install: $ git clone --bare git@github.com:tristaneuan/dotfiles.git $HOME/.dotfiles
alias dot="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias sz="source $HOME/.zshrc"

alias d="docker"
alias dc="docker-compose"
ua dip
dip() { docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$@" }
ua dr
dr() { docker run -it $1 /bin/bash }
ua dx
dx() { docker exec -it $1 /bin/bash }

ua fa
fa() { find ${2:-.} -name "*$1*" | grep -v '^\./\..*' | grep -v '^\./tmp' } 
ua fd
fd() { find ${2:-.} -type d -name "*$1*" | grep -v '^\./\..*' | grep -v '^\./tmp' }
ua ff
ff() { find ${2:-.} -type f -name "*$1*" | grep -v '^\./\..*' | grep -v '^\./tmp' }

alias g="git"
ua ga
ga() { git add $@; git status -sb }
ua gap
gap() { git add -p $@; git status -sb }
alias gaa="git add -A git status -sb"
alias gau="git add -u; git status -sb"
ua grm
grm() { git rm $@; git status -sb }
ua gmv
gmv() { git mv $@; git status -sb }
ua gcl
gcl() { local repo="$@"; git clone $repo && cd $(echo -n "$repo" | cut -d'/' -f2) }
ua gcb
gcb() { git checkout -b $@; git status -sb }
ua gck
gck() { git checkout -- $@; git status -sb }
ua gco
gco() { git checkout $@; git status -sb }
alias gcp="git cherry-pick"
alias gc="git commit -v; git status -sb"
alias gca="git commit --amend --no-edit; git status -sb"
ua gci
gci() { git commit -m $@; git status -sb }
alias gb="git branch"
alias gbd="git branch -D"
alias ggr="git grep -n"
alias gin="git init; git status -sb"
alias gl="git log --pretty=format:'%C(yellow)%h%Creset %C(cyan)%ad%Creset %s%C(green)%d%Creset %C(bold black)--%an%Creset' --graph --date=short"
alias gpl="git pull"
ua gps
gps() { # set upstream if not configured & no arguments passed
  local branch=$(git branch | grep \* | cut -d' ' -f2)
  if [[ $# -gt 0 || $(git rev-parse --abbrev-ref $branch@{u} 2>/dev/null) ]]; then
    git push $@
  else
    git push -u origin $branch
  fi
}
alias gpf="git push --force-with-lease"
alias gft="git fetch"
alias gfr="git fetch origin master && git rebase origin/master"
alias gmg="git merge"
ua gd
gd() { git diff $@; git status -sb }
alias gds="git diff --staged; git status -sb"
alias grb="git rebase"
alias gri="git rebase -i"
alias gr="git remote"
alias gra="git remote add"
alias grao="git remote add origin"
alias grs="git remote show"
alias grso="git remote show origin"
alias grh="git reset HEAD"
alias gsh="git stash"
alias gsl="git stash list --format='%gd [%cr] %gs'"
ua gsa
gsa() { git stash apply stash@{${1:-0}}; git status -sb }
ua gsp
gsp() { git stash save --patch $@; git status -sb }
ua gss
gss() { git stash save $@; git status -sb }
alias gs="git status -sb"
alias gst="git status"
alias gwho="git shortlog -sn"
ua gsw
gsw() { # git diff between current and n versions ago
  local offset=${2:-0}
  local commit=$(git log -n 1 --skip=$offset --pretty=format:%h -- $1)
  vim -c "Gvdiff $commit" $1
}

alias l="ls -lh"
alias la="ls -lAh"
alias lt="ls -lht"
alias lat="ls -lAht"

alias py="python3"
alias py2="python2"
alias py3="python3"
alias pir="pip3 install -r requirements.txt"
alias mkvenv="python3 -m venv env"
alias venv=". env/bin/activate"

alias ir="irb --simple-prompt"
alias bi="bundle install --path vendor/bundle"
alias bx="bundle exec"
alias bu="bundle update"
alias brk="bundle exec rake"
alias brl="bundle exec rails"

alias v="vim"
alias vi="vim"
alias vv="f -e vim"
alias vbi="vim -c 'BundleClean' -c 'BundleInstall'"
ua vff
vff() { vim -p $(find ${2:-.} -type f -name $1 | tr "\n" " ") }

alias caf="caffeinate -is"
alias tm="tmux -2 attach"
alias k='zsh -c "$(fc -nl -1)"'
ua psg
psg() { ps aux | grep -v grep | grep $@ }
ua kps
kps() { ps aux | grep -v grep | grep $@ | awk '{print $2}' | xargs kill -9 }
ua nh
nh() { unset HISTFILE; export _FASD_RO=true }
ua x
x() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf "$1"    ;;
      *.tar.gz)    tar xvzf "$1"    ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar x "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xvf "$1"     ;;
      *.tbz2)      tar xvjf "$1"    ;;
      *.tgz)       tar xvzf "$1"    ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "'$1' cannot be extracted via >x<" ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}

# Requires `brew install fasd`
which fasd >/dev/null && eval "$(fasd --init auto)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey -r '\ec' # Unbind fzf-cd-widget

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

eval `ssh-agent` > /dev/null && ssh-add -A 2> /dev/null
