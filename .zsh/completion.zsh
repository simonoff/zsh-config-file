#Hosts completion from .ssh/known_hosts
local _myhosts
_myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )


# Setup new style completion system. To see examples of the old style (compctl
# based) programmable completion, check Misc/compctl-examples in the zsh
# distribution.
autoload -U compinit promptinit
compinit
autoload -U incremental-complete-word
zle -N incremental-complete-word

autoload -U insert-files
zle -N insert-files

autoload -U predict-on
zle -N predict-on
promptinit
zstyle ':completion::complete:*' use-cache 1
# Completion Styles

# list of completers to use
#zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' add-space true
zstyle ':completion:*' completer _complete _list _oldlist _expand _ignored _match _correct _approximate _prefix
# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions
zstyle ':completion:*' completions 1
# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle ':completion:*' hosts $_myhosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)
# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion:*:descriptions' format $'%{\e[0;31m%}%d%{\e[0m%}'
zstyle ':completion:*:messages' format $'%{\e[0;31m%}%d%{\e[0m%}'
zstyle ':completion:*:warnings' format $'%{\e[0;31m%}No matches for: %d%{\e[0m%}'
zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' file-sort name
zstyle ':completion:*' menu select=long
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zsh/.zcompcache
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns \
'*?.(o|c~|old|pro|zwc)' '*~'
zstyle ':completion:*:*:mpg321:*' file-patterns \
'*.(mp3|MP3):mp3\ files *(-/):directories'
zstyle ':completion:*:*:ogg123:*' file-patterns \
'*.(ogg|OGG):ogg\ files *(-/):directories'
compdef _gnu_generic slrnpull make df du
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' old-menu false
zstyle ':completion:*' original true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle ':completion:*' word true
#
# Some compl
#
#------------------------------------------------------------------------------
# Generic completion for C compiler.
compctl -/g "*.[cCoa]" -x 's[-I]' -/ - \
	's[-l]' -s '${(s.:.)^LD_LIBRARY_PATH}/lib*.a(:t:r:s/lib//)' -- cc
#------------------------------------------------------------------------------
# GCC completion, by Andrew Main
# completes to filenames (*.c, *.C, *.o, etc.); to miscellaneous options after
# a -; to various -f options after -f (and similarly -W, -g and -m); and to a
# couple of other things at different points.
# The -l completion is nicked from the cc compctl above.
# The -m completion should be tailored to each system; the one below is i386.
compctl -/g '*.([cCmisSoak]|cc|cxx|ii|k[ih])' -x \
	's[-l]' -s '${(s.:.)^LD_LIBRARY_PATH}/lib*.a(:t:r:s/lib//)' - \
	'c[-1,-x]' -k '(none c objective-c c-header c++ cpp-output
	assembler assembler-with-cpp)' - \
	'c[-1,-o]' -f - \
	'C[-1,-i(nclude|macros)]' -/g '*.h' - \
	'C[-1,-i(dirafter|prefix)]' -/ - \
	's[-B][-I][-L]' -/ - \
	's[-fno-],s[-f]' -k '(all-virtual cond-mismatch dollars-in-identifiers
	enum-int-equiv external-templates asm builtin strict-prototype
	signed-bitfields signd-char this-is-variable unsigned-bitfields
	unsigned-char writable-strings syntax-only pretend-float caller-saves
	cse-follow-jumps cse-skip-blocks delayed-branch elide-constructors
	expensive-optimizations fast-math float-store force-addr force-mem
	inline-functions keep-inline-functions memoize-lookups default-inline
	defer-pop function-cse inline peephole omit-frame-pointer
	rerun-cse-after-loop schedule-insns schedule-insns2 strength-reduce
	thread-jumps unroll-all-loops unroll-loops)' - \
	's[-g]' -k '(coff xcoff xcoff+ dwarf dwarf+ stabs stabs+ gdb)' - \
	's[-mno-][-mno][-m]' -k '(486 soft-float fp-ret-in-387)' - \
	's[-Wno-][-W]' -k '(all aggregate-return cast-align cast-qual
	char-subscript comment conversion enum-clash error format id-clash-6
	implicit inline missing-prototypes missing-declarations nested-externs
	import parentheses pointer-arith redundant-decls return-type shadow
	strict-prototypes switch template-debugging traditional trigraphs
	uninitialized unused write-strings)' - \
	's[-]' -k '(pipe ansi traditional traditional-cpp trigraphs pedantic
	pedantic-errors nostartfiles nostdlib static shared symbolic include
	imacros idirafter iprefix iwithprefix nostdinc nostdinc++ undef)' \
	-X 'Use "-f", "-g", "-m" or "-W" for more options' -- gcc g++
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
# CVS
#
cvscmds=(add admin rcs checkout commit diff rdiff export history import log rlog
         release remove status tag rtag update annotate)
cvsignore="*~ *# .#* *.o *.a CVS . .."

compctl -k cvscmds \
    -x "c[-1,-D]" -k '(today yesterday 1\ week\ ago)' \
    - "c[-1,-m]" -k '(bugfix cosmetic\ fix ... added\ functionality foo)' \
    - "c[-1,-F]" -f \
    - "c[-1,-r]" -K cvsrevisions \
    - "c[-1,-I]" -f \
    - "R[add,;]" -K cvsaddp \
    - "R[(admin|rcs),;]" -/K cvstargets \
    - "R[(checkout|co),;]" -K cvsrepositories \
    - "R[(commit|ci),;]" -/K cvstargets \
    - "R[(r|)diff,;]" -/K cvstargets \
    - "R[export,;]" -f \
    - "R[history,;]" -/K cvstargets \
    - "R[history,;] c[-1,-u]" -u \
    - "R[import,;]" -K cvsrepositories \
    - "R[(r|)log,;]" -/K cvstargets \
    - 'R[(r|)log,;] s[-w] n[-1,,],s[-w]' -u -S , -q \
    - "R[rel(|ease),;]" -f \
    - "R[(remove|rm),;] R[-f,;]" -/K cvstargets \
    - "R[(remove|rm),;]" -K cvsremovep \
    - "R[status,;]" -/K cvstargets \
    - "R[(r|)tag,;]" -/K cvstargets \
    - "R[up(|date),;]" -/K cvstargets \
    - "R[annotate,;]" -/K cvstargets \
    -- cvs 

compctl -/K cvstargets cvstest 

cvsprefix() {
    local nword args f
    read -nc nword; read -Ac args
    pref=$args[$nword]
    if [[ -d $pref:h && ! -d $pref ]]; then
	pref=$pref:h
    elif [[ $pref != */* ]]; then
	pref=
    fi
    [[ -n "$pref" && "$pref" != */ ]] && pref=$pref/
}

cvsentries() {
    setopt localoptions nullglob unset
    if [[ -f ${pref}CVS/Entries ]]; then
	reply=( "${pref}${(@)^${(@)${(@)${(f@)$(<${pref}CVS/Entries)}:#D*}#/}%%/*}" )
    fi
}

cvstargets() {
    local pref
    cvsprefix
    cvsentries
}

cvsrevisions() {
    reply=( "${(@)${(@)${(@M)${(@f)$(cvs -q status -vl .)}:#	*}##[ 	]##}%%[ 	]*}" )
}

cvsrepositories() {
    local root=$CVSROOT
    [[ -f CVS/Root ]] && root=$(<CVS/Root)
    reply=(
	$root/^CVSROOT(:t)
	"${(@)${(@M)${(@f)$(<$root/CVSROOT/modules)}:#[^#]*}%%[ 	]*}"
    )
}

cvsremovep() {
    local pref
    cvsprefix
    cvsentries
    setopt localoptions unset
    local omit
    omit=( ${pref}*(D) )
    eval 'reply=( ${reply:#('${(j:|:)omit}')} )'
}

cvsaddp() {
    local pref
    cvsprefix
    cvsentries
    setopt localoptions unset
    local all omit
    all=( ${pref}*(D) )
    omit=( $reply ${pref}${^${=cvsignore}} )
    [[ -r ~/.cvsignore ]] && omit=( $omit ${pref}${^$(<~/.cvsignore)} )
    [[ -r ${pref}.cvsignore ]] && omit=( $omit ${pref}${^$(<${pref}.cvsignore)} )
    eval 'reply=( ${all:#('${(j:|:)omit}')} )' 
}

