
# Confg file for ZedShell
# Wrote by some dotfiles others peoples
# Date : 09.05.2005
# Author Alexander Simonov <alex@simonov.in.ua>

#
# Read environment
#
#[[ -e "/etc/profile.env" ]] && source /etc/profile.env

#077 would be more secure, but 022 is generally quite realistic
umask 022

#
# Add PATH variable
#
PATH="/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:/opt/local/lib/postgresql82/bin"
export PATH="${PATH}:/bin:/sbin:/usr/bin:/usr/sbin"

export UNAME_S=$(uname -s 2>&1 || echo "Linux" )
# Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit core 0
limit -s

###
# Options.  See zshoptions(1)
SAVEHIST=5000
HISTSIZE=5000
DIRSTACKSIZE=20
HISTFILE=~/.bash_history 
#
# Load options
#
source ~/.zsh/options.zsh

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

#
# Load aliaces
#
source ~/.zsh/aliaces.zsh

#
# Load completion
#
source ~/.zsh/completion.zsh

#
# Load binds
#
source ~/.zsh/keybind.zsh

#
# Others
#
export LANG="ru_RU.UTF-8"
export COLORFGBG="default;default"
export CFLAGS="-I/opt/local/include ${CFLAGS}"
export CPPFLAGS="-I/opt/local/include ${CPPFLAGS}"

#
# Functions
#
#
src () {
    autoload -U zrecompile
	[ -f ~/.zshrc ] && zrecompile -p ~/.zshrc ~/.zsh/*.zsh
	[ -f ~/.zcompdump ] && zrecompile -p ~/.zcompdump
	[ -f ~/.zshrc.zwc.old ] && rm -f ~/.zshrc.zwc.old
	[ -f ~/.zcompdump.zwc.old ] && rm -f ~/.zcompdump.zwc.old
	source ~/.zshrc
}

#
# Load prompt
#
source ~/.zsh/prompt.zsh
# vim: set noet ts=4 tw=80 :
