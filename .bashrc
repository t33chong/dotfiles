export PS1="\[\e[32;1m\]\u@\h:\[\e[36;1m\]\w\$ \[\e[0m\]"
export PROMPT_COMMAND='echo -ne "\033]0;${_}\007"'
export EDITOR=vim

alias ls="ls --color"
alias v="vim"
alias vi="vim"
alias p="python"
alias py="python"
alias spy="sudo python"
alias g="git"
alias gi="git"
alias gad="git add"
alias grm="git rm"
alias gco="git checkout"
alias gci="git commit -m"
alias gst="git status"
alias gbr="git branch"
alias glg="git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
alias gpl="git pull origin master"
alias gps="git push origin master"
alias gdf="git diff --staged"
alias scr="screen"

#case "$TERM" in
#screen-256color)
#    PS1="\[\e[31;1m\]\u@\h:\[\e[36;1m\]\w\$ \[\e[0m\]"
#    ;;
#esac

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
