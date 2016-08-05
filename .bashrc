export PS1="\[\e[32;1m\]\u@\h:\[\e[36;1m\]\w\$ \[\e[0m\]"
export EDITOR=vim
export GOPATH=$HOME/Code/golang
export PATH=/usr/local/bin:/usr/local/sbin:$PATH:$HOME/.bin:$GOPATH/bin
export LESS="-R"

alias ls="ls -G"
alias vi="vim"
alias py="python"
alias spy="sudo python"
alias venv=". .env/bin/activate"
alias py3="python3"
alias spy3="sudo python3"
alias ir="irb --simple-prompt"
alias bi="bundle install"
alias be="bundle exec"
alias bu="bundle update"
alias gad="git add"
alias grm="git rm"
alias gmv="git mv"
alias gcl="git clone"
alias gco="git checkout"
alias gct="git commit"
alias gci="git commit -m"
alias gst="git status"
alias gbr="git branch"
alias ggr="git grep -n"
alias glg="git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
alias gpl="git pull"
alias gps="git push"
alias gft="git fetch"
alias gmg="git merge"
alias gdf="git diff"
alias gdfs="git diff --staged"
alias grb="git rebase -i"
alias gro="git remote"
alias grh="git reset HEAD"
alias gsh="git stash"
alias gshl="git stash list"
alias scr="screen"
alias tm="TERM=xterm-256color tmux attach"
alias grep="grep -n --color=always"
alias pls='sudo bash -c "$(fc -nl -1)"'
alias nom='rm -rf node_modules bower_components tmp && npm cache clean && bower cache clean && bower install && npm install'
alias dockerpls="eval $(docker-machine env default)"
alias wtest="docker-compose run -e PARALLEL_TEST_PROCESSORS=4 --rm web bundle exec testrbl -I test"

# This + iTerm2 config means alt+backspace deletes until previous /
stty werase undef
bind '"\C-w": unix-filename-rubout'

function gsw {
  local offset=${2-0}
  local commit=$(git log -n 1 --skip=$offset --pretty=format:%h -- $1)
  git show $commit:./$1 | vim - "+set filetype=${1##*.}";
}

function gshs {
  git stash save "[$(date)] $1"
}

function gsha {
  git stash apply stash@{${1-0}}
}

function up {
  cd $(eval printf '../%.s' {1..${1-1}})
}

function kstg {
  bundle exec knife $@ -c ~/.chef/stg/knife.rb
}

function kprod {
  bundle exec knife $@ -c ~/.chef/prod/knife.rb
}

export MARKPATH=$HOME/.marks
function to {
  cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark: $1"
}
function mark { 
  mkdir -p $MARKPATH; ln -s $(pwd) $MARKPATH/$1
}
function unmark { 
  rm -i $MARKPATH/$1
}
function marks {
  ls -l $MARKPATH | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

function extract()      # Handy Extract Program
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

function lookfor { 
  find ${3-.} -name "$2" | xargs grep --color=always -in "$1" | sort | less -R
}

function vag {
  vim -c "setlocal shellpipe=>" -c "Ack '$1' ${2-.}"
}

function rm_recursive {
  find . -type f -name "$1" -delete
}

# bash completions
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
  complete -C aws_completer aws
fi

eval "$(rbenv init -)"
