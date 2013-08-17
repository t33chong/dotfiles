export PS1="\[\e[32;1m\]\u@\h:\[\e[36;1m\]\w\$ \[\e[0m\]"
export PROMPT_COMMAND='echo -ne "\033]0;${_}\007"'
export EDITOR=vim

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
