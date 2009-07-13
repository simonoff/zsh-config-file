# Confg file for ZedShell
# Wrote by some dotfiles others peoples
# Author Alexander Simonov <alex@simonov.in.ua>, Dmitry Shaposhnik <dmitry@shaposhnik.name>

#
# Read environment
#
#[[ -e "/etc/profile.env" ]] && source /etc/profile.env

#077 would be more secure, but 022 is generally quite realistic
umask 022

export PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"

#
# Scan path dir for new path
#
PATH_SCAN_DIR=~/.zsh/path.d
if [[ -d $PATH_SCAN_DIR ]] then
	#First load simple completions - plain files, each path at new line
	for file in $PATH_SCAN_DIR/*.path; do
	    [[ -e $file && -s $file ]] || continue
	    for i in `cat $file`; do
		[[ -d $i ]] && PATH="$i:$PATH"
	    done
	done
	#Now load complex path specifications. F.e. with UID checking
	for file in $PATH_SCAN_DIR/*.zsh; do
	    [[ -e $file && -s $file ]] && . $file
	done
fi

export PATH
export MANPATH=/opt/local/share/man:$MANPATH
export DISPLAY=:0.0
export EDITOR=vi
export PAGER=less


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
source ~/.zsh/aliases.zsh

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
export LANG="en_US.UTF-8"
export COLORFGBG="default;default"
export CFLAGS="-I/opt/local/include ${CFLAGS}"
export CPPFLAGS="-I/opt/local/include ${CPPFLAGS}"

source ~/.zsh/functions.zsh

#
# Load prompt
#
if [[ -f ~/.zsh/prompt.zsh ]]; then
    source ~/.zsh/prompt.zsh
else
    prompts=(~/.zsh/prompt.d/*)
    source $prompts[1]
fi
# vim: set noet ts=4 tw=80 :
