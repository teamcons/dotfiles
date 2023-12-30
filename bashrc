# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac



# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions




### COULEURS ###
STOP="$(tput sgr0)"
BOLD="$(tput bold)"
CLOSE="$(tput sgr0 ; tput bold)"

red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
pink="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

RED="$(tput bold ; tput setaf 1)"
GREEN="$(tput bold ; tput setaf 2)"
YELLOW="$(tput bold ; tput setaf 3)"
BLUE="$(tput bold ; tput setaf 4)"
PINK="$(tput bold ; tput setaf 5)"
CYAN="$(tput bold ; tput setaf 6)"
WHITE="$(tput bold ; tput setaf 7)"




### CONFORT ###
alias ls='ls --group-directories-first --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -vRi"
alias du='du -h'
alias rm='rm -vri'
alias mkdir='mkdir -v'
alias mv='mv -v'
alias chmod='chmod -v'
alias free="free -mh"
alias df='df -h'


### COMMANDES CUSTOM ###
alias rf='clear && source ~/.bashrc'
alias e='exit'
alias x="chmod +x"
alias sn='sudo nano'

alias e=exit
alias o=xdg-open
alias te="toolbox enter"


###################################################
### APPARENCE AU LOGIN ###
#PS="Die plüschFee!"
#PS1="\[\e[0;32m\]$PS\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]\[\033[0m\]"


# If inside toolbox do something
#if [[ "$(hostname)" != "toolbox" ]];
#	then
#	#Normal prompt
#	echo
#	else
	#Toolbox
#	echo	
#fi


# enclose nonprintable in \[ and \] to avoid display bug
PS1="\[\n\]\[$GREEN\] \[$HOSTNAME\]\[$BLUE\]\$PWD\n \[${YELLOW}\]-->\[$STOP\] "



###################################################
function ss_welcome()
{
echo "$GREEN Hallo ! =)$CLOSE"
echo
}

###################################################
function ss_local()
{
	printf '%*s\n' "${COLUMNS}" '' | tr ' ' -
	echo "$CYAN[LOCAL]$CLOSE"
	echo "$BLUE > OS: $CLOSE$(cat /etc/*-release | grep "PRETTY_NAME" | sed 's/PRETTY_NAME=//g' | sed 's/"//g')"
	echo "$BLUE > Rechner:$CLOSE $(hostname)" 
	echo "$BLUE > In betrieb:$CLOSE $(uptime -p)"
	echo "$BLUE > Freier speicherplatz:$CLOSE $(df -hT / | grep / | awk '{print $5}') frei ($(df -hT / | grep / | awk '{print $6}') benutzt)$CLOSE"
	printf '%*s\n' "${COLUMNS}" '' | tr ' ' -
	#echo
	#echo "$CYAN[DEVICES]$CLOSE"
	#echo "$BLUE > Über USB angeschlossen:$CLOSE $(ls /media/teamcons/)"
	#if [[$(lsusb | grep thethering)]]; then echo "$BLUE > Tethering:$CLOSE";fi
	
	
}

###################################################
function ss_remote()
{
	#REMOTE PANEL
	echo "$CYAN[REMOTE]$CLOSE"
	if ip r >> /dev/null
	then echo "$BLUE > Internet:$CLOSE Verbunden" 
	else echo "$BLUE > Internet:$RED GETRENNT$CLOSE" 
	fi

	#BACKUP DRIVE
	if [ -e /media/stella/STOREIT/ ]
	then echo "$BLUE > Backup drive:$CLOSE Verbunden"
	else echo "$BLUE > Backup drive:$RED GETRENNT$CLOSE"
	fi
	echo
}




###################################################

ss_welcome
ss_local

#ss_remote



#JUNK
#esptool.py --port /dev/ttyUSB0 write_flash -fm dio 0x00000 ./nodemcu-master-10-modules-2018-08-08-21-06-38-integer.bin 
#alias esp="picocom --baud 115200 /dev/ttyUSB0"
#export PATH="$PATH:/opt/The Whitecat Create Agent"


#Jupyter from the toolbox
#export PATH="$PATH:/var/home/teamcons/.local/bin"

#alias meta="ydotool key 125:1 125:0"




#do_the_conda > /dev/null 2> /dev/null

#alias jupyter-notebook="jupyter-notebook --NotebookApp.use_redirect_file=False"

#export PATH="/var/home/teamcons/.anaconda3/bin:$PATH"  # commented out by conda initialize

alias chirp='notify-send "Birb" "Chirp chirp chirp" -i /var/home/teamcons/chirp.png'



### GITHUB
function gu()
{
	git add -A *
	git commit -m "${*:-"Small changes here and there"}"
	git push -u origin main
}
