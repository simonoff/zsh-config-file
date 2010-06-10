# Confg file for ZedShell
# Wrote by some dotfiles others peoples
# Author Alexander Simonov <alex@simonov.in.ua>, Dmitry Shaposhnik <dmitry@shaposhnik.name>

umask 022
#
# Clean paths
#
export PATH=""
export MANPATH=""
ZSH_MYCONFDIR=~/.zsh

function load_files () {
    if [ -d $1 ]; then
        for f in $1/*; do
            [[ -e $f && -s $f ]] && . $f
        done
    fi
}


#
# Based on /usr/libexec/path_helper
#
function read_path_dir () {
	DIR="$1"
	NEWPATH="$2"
	EXT="$3"
	SEP=""
	IFS=$'\n'
	if [ -d "$DIR".d ]; then
		for f in "$DIR" "$DIR".d/*"$EXT" ; do
		  if [ -f "$f" ]; then
			for p in $(< "$f") ; do
				[[ "$NEWPATH" = *(*:)${p}*(:*) ]] && continue
				[ ! -z "$NEWPATH" ] && SEP=":"
				NEWPATH="${p}${SEP}${NEWPATH}"
			done
		  fi
		done
	fi
	echo $NEWPATH
}

#
# Mostly all Linux distributions used /etc/profile.d dir 
# for collecting path info
#
if [ -d /etc/profile.d ]; then
	for s in /etc/profile.d/*.sh ; do
		test -r $s -a ! -k $s && . $s
	done
fi


#
# Make PATH from /etc/path(.d)?
#
PATH=`read_path_dir /etc/paths "$PATH"`
MANPATH=`read_path_dir /etc/manpaths "$MANPATH"`

export MANPATH

#
# Scan path dir for new path
#
PATH_SCAN_DIR=$ZSH_MYCONFDIR/path
PATH=`read_path_dir $PATH_SCAN_DIR "$PATH" .path`
export PATH

for f in "$PATH_SCAN_DIR".d/*.zsh(.N); do
	[[ -e $f && -s $f ]] && . $f
done

export MANPATH=/opt/local/share/man:$MANPATH
export EDITOR=vim
export PAGER=less

export PKG_MANAGER=none
for i in {port,fink,brew};do
    `which $i > /dev/null` && export PKG_MANAGER=$i
done

export UNAME_S=$(uname -s 2>&1 || echo "Linux" )
# Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit core 0
limit -s

###
# Options.	See zshoptions(1)
SAVEHIST=5000
HISTSIZE=5000
DIRSTACKSIZE=20
HISTFILE=~/.bash_history 
#
# Load options
#
source $ZSH_MYCONFDIR/options.zsh

#
# Others
#
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export COLORFGBG="default;default"
export CFLAGS="-I/opt/local/include ${CFLAGS}"
export CPPFLAGS="-I/opt/local/include ${CPPFLAGS}"

#
# Functions
#
source $ZSH_MYCONFDIR/functions.zsh

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

#
# Load aliases
#
source $ZSH_MYCONFDIR/aliases.zsh

#
# Load completion
#
source $ZSH_MYCONFDIR/completion.zsh

#
# Load binds
#
source $ZSH_MYCONFDIR/keybind.zsh


#
# Load prompt
#
if [[ -f $ZSH_MYCONFDIR/prompt.zsh ]]; then
    source $ZSH_MYCONFDIR/prompt.zsh
else
    prompts=($ZSH_MYCONFDIR/prompt.d/*)
    source $prompts[1]
fi

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

# vim: set noet ts=4 tw=80 :
