[ -d "/opt/local/libexec/gnubin" ] && export PATH="/opt/local/libexec/gnubin:${PATH}"
if [[ $UID == "0" ]] 
then
    export PATH="/opt/local/sbin:$PATH"
fi
