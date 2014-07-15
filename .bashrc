export PS1="\[\e[32;1m\]\u@\h:\[\e[36;1m\]\w\$ \[\e[0m\]"
export PROMPT_COMMAND='echo -ne "\033]0;${_}\007"'
export EDITOR=vim
export PATH=/usr/local/bin:/usr/local/sbin:$PATH:$HOME/.bin
export LESS="-R"

alias ls="ls -G"
alias vi="vim"
alias py="python"
alias spy="sudo python"
alias rb="ruby"
alias brb="bundle exec ruby"
alias gad="git add"
alias grm="git rm"
alias gmv="git mv"
alias gco="git checkout"
alias gci="git commit -m"
alias gst="git status"
alias gbr="git branch"
alias glg="git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
alias gpl="git pull"
alias gps="git push"
alias gmg="git merge"
alias gdf="git diff --staged"
alias gro="git remote"
alias scr="screen"
alias tm="tmux"
alias tma="tmux attach"
alias grep="grep -n --color=always"

export MARKPATH=$HOME/.marks
function jump { 
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
    find . -name "$2" | xargs grep --color=always -in "$1" | less -R
}

# bash completions
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
  complete -C aws_completer aws
fi

# BetterCompany dev shortcut
function develop() {
  $HOME/Code/bco/usul/edric/develop $@
}

eval "$(rbenv init -)"
