
# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# append to the history file, don't overwrite it
shopt -s histappend

# don't put duplicate lines or lines starting with space in the history.
export HISTCONTROL=ignoreboth:erasedups:ignorespace
export HISTIGNORE="&:ls:bg:fg:cd"

export HISTSIZE=10000
export HISTFILESIZE=200000
export HISTTIMEFORMAT="%d-%m-%Y %H:%M:%S "

alias cd..='cd ..'
alias tailf='tail -F '
# \[\033]0;$TITLEPREFIX:$PWD\007\]\n\[\033[32m\]\u@\h \[\033[35m\]$MSYSTEM \[\033[33m\]\w\[\033[36m\]`__git_ps1`\[\033[0m\]\n$

PS1="\[\033]0;$TITLEPREFIX:$PWD\007\]\[\033[1;37m\]\u \[\033[35m\]\[\033[33m\]\w\[\033[36m\]`__git_ps1` \[\033[1;30m\]\]\]$\[\033[0m\] "

