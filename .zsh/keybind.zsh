#
# Key bindings
#
case $TERM in 
    linux)
	bindkey "^[[2~" yank
	bindkey "^[[3~" delete-char
	bindkey "^[[5~" up-line-or-history
	bindkey "^[[6~" down-line-or-history
	bindkey "^[[1~" beginning-of-line
	bindkey "^[[4~" end-of-line
	bindkey "^[e" expand-cmd-path
	bindkey "^[[A" up-line-or-search 
	bindkey "^[[B" down-line-or-search
	bindkey " " magic-space
	;;
    xterm*|*rxvt*)
	bindkey "^[[1~" beginning-of-line
	bindkey "^[[4~" end-of-line
	bindkey "^[[2~" yank
	bindkey "^[[3~" delete-char
	bindkey "^[[5~" up-line-or-history
	bindkey "^[[6~" down-line-or-history 
	bindkey "^[[7~" beginning-of-line
	bindkey "^[[8~" end-of-line
	bindkey "^[e" expand-cmd-path 
	bindkey "^[[A" up-line-or-search
	bindkey "^[[B" down-line-or-search 
	bindkey " " magic-space
	;;
esac

bindkey "^R" history-incremental-search-backward
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
	