# {{{ Prompt colors

#/usr/share/zsh/4.0.2/functions/Misc/colors

# Attribute codes:
#  00 none
#  01 bold
#  02 faint                  22 normal
#  03 standout               23 no-standout
#  04 underline              24 no-underline
#  05 blink                  25 no-blink
#  07 reverse                27 no-reverse
#  08 conceal

# Text color codes:
#  30 black                  40 bg-black
#  31 red                    41 bg-red
#  32 green                  42 bg-green
#  33 yellow                 43 bg-yellow
#  34 blue                   44 bg-blue
#  35 magenta                45 bg-magenta
#  36 cyan                   46 bg-cyan
#  37 white                  47 bg-white
#  39 default                49 bg-default

#PS1="%{"$'\e[01;31m'"%}$PS1%{"$'\e[00m'"%}"
#             ^^ ^^                 ^^
#             |  |                  |
#          bold  red                reset

#
##
####################################
#
# Colors
#
#\##################################

#WHITE="%{"$'\e[37m'"%}"
#BLUE="%{"$'\e[34m'"%}"
#MAGENTA="%{"$'\e[35m'"%}"
#CYAN="%{"$'\e[36m'"%}"
#BLACK="%{"$'\e[30m'"%}"
#RED="%{"$'\e[31m'"%}"
#GREEN="%{"$'\e[32m'"%}"
#YELLOW="%{"$'\e[33m'"%}"
#BOLD="%{"$'\e[01m'"%}"
#NONE="%{"$'\e[00m'"%}"

#export FOO="%{"$'\e[31m'"%}"
#PS1="${FOO}$PS1%{"$'\e[0m'"%}"

# DEFINE ALL COLORS IN THIS PLACE
# for example color for "%h" is in variable "COLOR_p_h"
# except
# color for "%#" is in variable "COLOR_p_hash"
# color for "%/" is in variable "COLOR_p_slash"
# color for "%*" is in variable "COLOR_p_star"
# color for "@" is in variable "COLOR_at"

COLOR="%{"$'\e[31m'"%}"

if (( EUID == 0 ))
then
    COLOR_ROOT_BOLD="%{"$'\e[01m'"%}"
    COLOR_RESET="%{"$'\e[39;49;01m'"%}"
else
    COLOR_ROOT_BOLD=""
    COLOR_RESET="%{"$'\e[39;49;00m'"%}"
fi

COLOR_REAL_RESET="%{"$'\e[39;49;00m'"%}"

colorize()
{
    COLOR_p_h="%{"$'\e[32;44m'"%}"
    COLOR_p_l="%{"$'\e[32;44m'"%}"
    COLOR_p_y="%{"$'\e[32;44m'"%}"

    COLOR_p_n="%{"$'\e[35;43m'"%}"
    COLOR_at="%{"$'\e[35;43m'"%}"
    COLOR_p_m="%{"$'\e[35;43m'"%}"

    COLOR_WHOLEHOST="%{"$'\e[35;43m'"%}"
    COLOR_SHORTHOST="%{"$'\e[35;43m'"%}"
    COLOR_DOMAINHOST="%{"$'\e[35;43m'"%}"

    COLOR_p_D="%{"$'\e[31;46m'"%}"
    COLOR_MY_DATE="%{"$'\e[31;46m'"%}"
    COLOR_p_star="%{"$'\e[31;46m'"%}"
    COLOR_MY_TIME="%{"$'\e[31;46m'"%}"

    COLOR_ROOT="%{"$'\e[01;31;43m'"%}"

    if (( EUID == 0 ))
    then
        COLOR_p_hash="${COLOR_ROOT}"
        COLOR_p_slash="${COLOR_ROOT}"
    else
        COLOR_p_hash="%{"$'\e[01;03;33;44m'"%}"
        COLOR_p_slash="%{"$'\e[31;43m'"%}"
    fi

    $LATEST_PROMPT
}

uncolorize()
{
    COLOR_p_h="${COLOR_RESET}"
    COLOR_p_l="${COLOR_RESET}"
    COLOR_p_y="${COLOR_RESET}"

    COLOR_p_n="${COLOR_RESET}"
    COLOR_at="${COLOR_RESET}"
    COLOR_p_m="${COLOR_RESET}"

    COLOR_WHOLEHOST="${COLOR_RESET}"
    COLOR_SHORTHOST="${COLOR_RESET}"
    COLOR_DOMAINHOST="${COLOR_RESET}"

    COLOR_p_D="${COLOR_RESET}"
    COLOR_MY_DATE="${COLOR_RESET}"
    COLOR_p_star="${COLOR_RESET}"
    COLOR_MY_TIME="${COLOR_RESET}"

    COLOR_ROOT="%{"$'\e[39;49;01m'"%}"

    if (( EUID == 0 ))
    then
        COLOR_p_hash="%s${COLOR_ROOT}"
        COLOR_p_slash="%s${COLOR_ROOT}"
    else
        COLOR_p_hash="${COLOR_RESET}"
        COLOR_p_slash="${COLOR_RESET}"
    fi

    $LATEST_PROMPT
}

src () {
    autoload -U zrecompile
    [ -f ~/.zshrc ] && zrecompile -p ~/.zshrc ~/.zsh/*.zsh
    [ -f ~/.zcompdump ] && zrecompile -p ~/.zcompdump
    [ -f ~/.zshrc.zwc.old ] && rm -f ~/.zshrc.zwc.old
    [ -f ~/.zcompdump.zwc.old ] && rm -f ~/.zcompdump.zwc.old
    source ~/.zshrc
}

parse_git_dirty() {
  git diff --quiet || echo "*"
}

parse_git_branch() {
  [ -d .git ] || return 1
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

#
# load files in the directory
# 
function load_files () {
	DIR="$1"
	EXT="$2"
    if [ -d "$DIR" ]; then
        for f in $DIR/*$EXT(.N); do
			[[ -r $f && -s $f ]] && . $f
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
	if [ -d "$DIR.d" ]; then
		for f in $DIR $DIR.d/*$EXT ; do
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

