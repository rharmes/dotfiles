################################################################################
# History
################################################################################

export HISTCONTROL=erasedups
export HISTSIZE=10000
export HISTIGNORE="ls:ls *:ll:cd:cd -:pwd;exit:date:* --help"
shopt -s histappend

################################################################################
# Tab completion for SSH hostnames
################################################################################

[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

################################################################################
# Exports
################################################################################

export PATH=$PATH:/usr/local/bin:/Users/harmes/bin:/Users/harmes/Dropbox/bin
export EDITOR="/usr/bin/mate -w"

################################################################################
# Aliases
################################################################################

# General

alias ls='ls -G'
alias ll='ls -lAG'
alias c='clear'
alias sudo='sudo '

# Mac

alias finder='open -a Finder .'
alias update='sudo softwareupdate -i -a; brew update; brew upgrade'
alias copy="tr -d '\n' | pbcopy"
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

alias spotoff="sudo mdutil -a -i off"
alias spoton="sudo mdutil -a -i on"

alias plistbuddy="/usr/libexec/PlistBuddy"

alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume 7'"

# Shell

alias reload='source ~/.bash_profile'
alias edit="$EDITOR"

# Network

alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias whois="whois -h whois-servers.net"
alias flush="dscacheutil -flushcache"

# Tools

alias svn=/Users/harmes/Dropbox/bin/svn-color.py
alias mdiff='/usr/bin/svn diff | mate'
alias fdiff='/usr/bin/svn diff --diff-cmd=fmdiff'

alias psql=/usr/local/pgsql-9.1/bin/psql

alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
alias fs="stat -f \"%z bytes\""

################################################################################
# Colors (for reference)
################################################################################
# 
# black =  "\[\e[0;30m\]"
# red =    "\[\e[0;31m\]"
# green =  "\[\e[0;32m\]"
# yellow = "\[\e[0;33m\]"
# blue =   "\[\e[0;34m\]"
# purple = "\[\e[0;35m\]"
# cyan =   "\[\e[0;36m\]"
# grey =   "\[\e[1;37m\]"
# 
# normal = "\[\e[00m\]"
# reset =  "\[\e[39m\]"

#################################################################################
# Prompt
################################################################################
# Thu Oct 06 12:40:06 harmes in ~/Sites/flickr.com:
# ○-→

PS1="\[\e[0;33m\]\d \t \[\e[0;35m\]\u \[\e[0;37m\]in \[\e[0;36m\]\w\[\e[0;37m\]:\n\[\e[0;32m\]○-→\[\e[39m\] "

#################################################################################
# Functions
################################################################################

# Create a data URL from an image (works for other file types too, if you tweak the Content-Type afterwards)
dataurl() {
	echo "data:image/${1##*.};base64,$(openssl base64 -in "$1")" | tr -d '\n'
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
	local port="${1:-8000}"
	open "http://localhost:${port}/"
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}