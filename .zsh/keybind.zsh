# set using vi key bindings
if [[ -o interactive ]]; then
    bindkey -v
fi

#
# Key bindings
#
bindkey "^R" history-incremental-search-backward
case $TERM in 
    linux)
    bindkey "^[[2~" yank
    bindkey "^[[3~" delete-char
    bindkey "^[[5~" up-line-or-history
    bindkey "^[[6~" down-line-or-history
    bindkey "^[[1~" beginning-of-line
    bindkey "^[[4~" end-of-line
    bindkey "^[e"   expand-cmd-path
    bindkey "^[[A"  up-line-or-search 
    bindkey "^[[B"  down-line-or-search
    bindkey " "     magic-space
    ;;
    xterm*|*rxvt*)
    bindkey "^[[2~" yank
    bindkey "^[[3~" delete-char
    bindkey "^[[5~" up-line-or-history
    bindkey "^[[6~" down-line-or-history 
    bindkey "^[[7~" beginning-of-line
    bindkey "^[[8~" end-of-line
    bindkey "^[e"   expand-cmd-path 
    bindkey "^[[A"  up-line-or-search
    bindkey "^[[B"  down-line-or-search 
    bindkey " "     magic-space

    if [[ $UNAME_S == "Darwin" ]] then
        case $TERM_PROGRAM in
            iTerm.app)
            
            bindkey '\e[A'  history-search-backward  # Up
            bindkey '\e[B'  history-search-forward   # Down
            # Key Right(arrow) and Key Left(arrow)
            bindkey '\e\e[C' forward-word            # Right
            bindkey '\e\e[D' backward-word           # Left
            bindkey '^[b'   emacs-backward-word
            bindkey '^[f'   emacs-forward-word
            bindkey '^[v'   expand-or-complete-prefix
            bindkey '^[[H'  beginning-of-line       # Home
            bindkey '^[[F'  end-of-line             # End
            ;;
            
            Apple_Terminal)
            bindkey "^[[4~" end-of-line
            bindkey "^[[1~" beginning-of-line
            ;;
        esac
    fi
    ;;
esac

# Bash-like shortcuts
bindkey "^E"    end-of-line
bindkey "^A"    beginning-of-line
bindkey "^K"    kill-line
