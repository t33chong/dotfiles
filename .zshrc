export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

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
DISABLE_AUTO_UPDATE="true"

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
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
eval "$(hub alias -s)"
# eval "$(thefuck --alias fak)"
# plugins=(docker fasd git knife vi-mode zsh-autosuggestions zsh-syntax-highlighting)
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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

KEYTIMEOUT=15 # Raised from 1 because `bindkey '\e.'` wasn't working

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'
bindkey '^[[16~' forward-word  # S-TAB
bindkey '^[[25~' autosuggest-execute  # S-CR

setopt ignoreeof
unsetopt share_history

export GOPATH=$HOME/Code/golang
export PATH=/usr/local/bin:/usr/local/sbin:$PATH:$HOME/.bin:$GOPATH/bin:$HOME/.rvm/bin
export SBT_CREDENTIALS=$HOME/.sbt/credentials

alias sz="source $HOME/.zshrc"
alias vi="vim"
alias vbi="vim -c 'BundleClean' -c 'BundleInstall'"
alias py="python"
alias py3="python3"
alias venv=". .env/bin/activate"
alias ir="irb --simple-prompt"
# alias bi="bundle install --path .bundle"
alias be="bundle exec"
alias bu="bundle update"
alias brake="bundle exec rake"
alias brk="bundle exec rake"
alias brl="bundle exec rails"
alias wbe="bundle _1.10.6_ exec"
alias wbu="bundle _1.10.6_ update"
alias wbrake="bundle _1.10.6_ exec rake"
alias wbrk="bundle _1.10.6_ exec rake"
alias wbrl="bundle _1.10.6_ exec rails"
alias dc="docker-compose"
alias gad="git add"
alias gaa="git add -A; git status -sb"
alias gau="git add -u; git status -sb"
grm() {
  git rm $@
  git status -sb
}
gmv() {
  git mv $@
  git status -sb
}
alias gcl="git clone"
alias gck="git checkout --; git status -sb"
alias gco="git checkout"
alias gc="git commit -v; git status -sb"
alias gca="git commit --amend --no-edit; git status -sb"
alias gct="git commit"
# alias gci="git commit -m"
alias gs="git status -sb"
alias gst="git status"
alias gbr="git branch"
alias ggr="git grep -n"
alias gin="git init"
alias gl="git log --pretty=format:'%C(yellow)%h%Creset %C(cyan)%ad%Creset %s%C(green)%d%Creset %C(bold black)--%an%Creset' --graph --date=short"
alias glg="git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
alias gpl="git pull"
alias gps="git push"
alias gpf="git push --force-with-lease"
alias gft="git fetch"
alias gfr="git fetch origin master && git rebase origin/master"
alias gmg="git merge"
# alias gdf="git diff; git status -sb"
gdf() {
  git diff $@
  git status -sb
}
alias gdfs="git diff --staged; git status -sb"
alias gds="git diff --staged; git status -sb"
alias gra="git remote add origin"
alias grb="git rebase"
alias gri="git rebase -i"
alias gro="git remote"
alias groso="git remote show origin"
alias grh="git reset HEAD"
alias gsh="git stash"
alias gsha="gsa"
alias gshl="git stash list --format='%gd [%cr] %gs'"
alias gsl="git stash list --format='%gd [%cr] %gs'"
# alias gsp="git stash save --patch; git status -sb"
gsp() {
  git stash save --patch $@
  git status -sb
}
alias gss="git stash save; git status -sb"
alias gwho="git shortlog -sn"
alias lt="ls -lt"
alias caf="caffeinate -is"
# alias tm="TERM=xterm-256color tmux attach"
alias tm="tmux -2 attach"
alias pls='sudo zsh -c "$(fc -nl -1)"'
alias k='zsh -c "$(fc -nl -1)"'
alias dfi="docker run -v /var/run/docker.sock:/var/run/docker.sock dduvnjak/dockerfile-from-image"

alias nom='rm -rf node_modules bower_components tmp && npm cache clean && bower cache clean && bower install && npm install'
alias pgstart="pg_ctl -D /usr/local/var/postgres -l logfile start"
# alias wtest="docker-compose run -e PARALLEL_TEST_PROCESSORS=4 --rm web bundle exec testrbl -I test"
# alias wtest="bundle exec testrbl -I test"
alias wtest="bundle _1.10.6_ exec testrbl -I test"
alias etest="npm test -- --filter"
alias zk="sudo /opt/zookeeper/bin/zkServer.sh"

bi() {
  if [ -f .path ] ; then
    source .path
  fi
  bundle install --path .bundle
}

wbi() {
  if [ -f .path ] ; then
    source .path
  fi
  bundle _1.10.6_ install --path .bundle
}

# TODO: git add last argument of previous command

fa() {
  find ${2:-.} -name "*$1*" | grep -v '^\./\..*' | grep -v '^\./tmp'
}

fd() {
  find ${2:-.} -type d -name "*$1*" | grep -v '^\./\..*' | grep -v '^\./tmp'
}

ff() {
  find ${2:-.} -type f -name "*$1*" | grep -v '^\./\..*' | grep -v '^\./tmp'
}

unalias ga
ga() {
  git add $@
  git status -sb
}

gci() {
  git commit -m $@
  git status -sb
}

gsa() {
  git stash apply stash@{${1:-0}}
}

# git diff between current and n versions ago
gsw() {
  local offset=${2:-0}
  local commit=$(git log -n 1 --skip=$offset --pretty=format:%h -- $1)
  vim -c "Gvdiff $commit" $1
}

up() {
  cd $(repeat ${1:-1} printf '../')
}

vail() {
  vim -c "Tail $1" -c "only" -c "setlocal wrap" -c "AnsiEsc" -c "nnoremap <leader>r :call tail#Refresh()<CR>:AnsiEsc<CR>"
}

vcr() {
  vim -c "CodeReview $1"
}

vfi() {
  # vim -p $(find . -type f -name $1 | tr "\n" " ")
  vim -p $(find ${2:-.} -type f -name $1 | tr "\n" " ")
}

ks() {
  bundle exec knife $@ -c ~/.chef/stg/knife.rb
}

kp() {
  bundle exec knife $@ -c ~/.chef/prod/knife.rb
}

export MARKPATH=$HOME/.marks
to() {
  cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark: $1"
}
mark() {
  mkdir -p $MARKPATH; ln -s $(pwd) $MARKPATH/$1
}
unmark() {
  rm -i $MARKPATH/$1
}
marks() {
  ls -l $MARKPATH | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

extract()      # Handy Extract Program
{
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
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

rm_recursive() {
  find . -type f -name "$1" -delete
}

dockerpls() {
  eval $(docker-machine env default)
}

dr() {
  docker run -it $1 /bin/bash
}

dx() {
  docker exec -it $1 /bin/bash
}

docker-ip() {
  docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$@"
}

# y2j() {
#   python -c 'import sys, yaml, json; json.dump(yaml.load(sys.stdin), sys.stdout, indent=4)' $1 > $2
# }

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

bindkey '\e.' insert-last-word

fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey -r '\ec' # Unbind fzf-cd-widget

eval "$(fasd --init auto)"

alias b="bundle"
alias d="docker"
alias e="ember"
alias r="rails"
alias sshh="ssh"
alias ss="sshrc"
alias v="vim"
alias vv="f -e vim"

compdef sshrc=ssh

# added by travis gem
[ -f /Users/tristan/.travis/travis.sh ] && source /Users/tristan/.travis/travis.sh
