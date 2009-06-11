#
# Aliases
#
alias mv='nocorrect mv -v'
alias cp='nocorrect cp -v'
alias rm='nocorrect rm -v'
alias mkdir='nocorrect mkdir'
alias man='nocorrect man'
alias find='noglob find'
alias ls='ls -FG --color'
alias ll='ls -l'
alias la='ls -a'
alias li='ls -ial'
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'
alias du='du -h'
alias df='df -h'
alias x='startx'
alias ps='ps'
alias cal='cal'
alias clr='find . -regex .*~ | xargs rm -f'
alias mkinst='sudo make install'
alias sc='less /usr/X11R6/lib/X11/rgb.txt'
alias mnt='sudo mount'
alias mntl='sudo mount -o loop'
alias umnt='sudo umount'
alias cfg='./configure --prefix=/usr --sysconfdir=/etc'
alias u2d='perl -pi -e "s/\\n/\\r\\n/;"'
alias d2u='perl -pi -e "s/\\r\\n/\\n/;"'
alias slog='sudo tail -f /var/log/messages | ccze -A -p syslog'
alias mlog='sudo tail -f /var/log/maillog | ccze -A -p syslog'
alias pst='pstree -G | less'
alias h=history
alias ispell='ispell -d russian'
alias -g M='|more'
alias -g L='|less'
alias -g H='|head'
alias -g T='|tail'
alias -g N='2>/dev/null'
alias v='vim'
alias gv='gvim'
alias d='dirs -v'
alias cvu="cvs update"
alias cvc="cvs commit"
alias svu="svn update"
alias svs="svn status"
alias svc="svn commit"
alias ssync="rsync --rsh=ssh"
alias ssyncr="rsync --rsh=ssh --recursive --verbose --progress"
alias grab="sudo chown ${USER} --recursive"
alias hmakej="hilite make -j"
alias clean="rm *~"
alias emacs="emacs -nw"
alias grep='grep --color=auto'


alias mysqlstart='sudo /opt/local/share/mysql5/mysql/mysql.server start'
alias mysqlstop='sudo /opt/local/share/mysql5/mysql/mysql.server stop'

alias pgsqlstart='sudo /opt/local/etc/LaunchDaemons/org.macports.postgresql83-server/postgresql83-server.wrapper start'
alias pgsqlstop='sudo /opt/local/etc/LaunchDaemons/org.macports.postgresql83-server/postgresql83-server.wrapper stop'
