#!/usr/bin/env bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Don't put duplicate lines in the history.
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000

# Append to the history file, don't overwrite it
shopt -s histappend

# Check the window size after each command and, if necessary,
#  update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in xterm-color) color_prompt=yes;; esac

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48 (ISO/IEC-6429).
    # (Lack of such support is extremely rare, and such a case would tend to
    #   support setf rather than setaf.)
	color_prompt=yes
else
	color_prompt=
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt

#
# Aliases
#
alias rd="rmdir"
alias cls="clear"

alias whoami="whoami && curl 4.ident.me"
alias please="sudo !!"

alias ls="eza"
alias ll="eza -la"
alias df="duf"
alias cat="bat"
alias find="fd"
alias md="glow"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
