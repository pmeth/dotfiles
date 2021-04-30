export CLICOLOR=1
# rvm
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# show git information in the prompt
source "$(brew --prefix)/etc/bash_completion"
# PS1 (prompt) settings
#export PS1='\w$(__git_ps1 " [\[\e[34;1m\]%s\[\e[0m\]]"): '
source ~/.bash_ps1

# use this for presentations
#export PS1='~~:'
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=

source ~/.bash_aliases

# git shortcuts
[ -s "/Users/pmeth/.scm_breeze/scm_breeze.sh" ] && source "/Users/pmeth/.scm_breeze/scm_breeze.sh"
alias gpo="git push origin HEAD"
alias gpof="git push -f origin HEAD"
alias gru="git remote update --prune"
alias ll='ls -al'
alias gteam="gl master --author='Peter Meth' --author='Bogdan' --author='Andrew Woods' --author='maxyengine' --author='Olivier'"
export PATH=/usr/local/opt/python/libexec/bin:$HOME/bin:/usr/local/sbin:$PATH

## START: SOME THINGS TO MAKE THE BASH HISTORY BETTER .. refer to http://blog.sanctum.geek.nz/better-bash-history/ ##
# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILESIZE=1000000
HISTSIZE=1000000

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
HISTIGNORE='ls:ll:pwd:exit:bg:fg:history'

HISTTIMEFORMAT='%F %T '

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar
complete -C aws_completer aws

_complete_ssh_hosts ()
{
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
                        cut -f 1 -d ' ' | \
                        sed -e s/,.*//g | \
                        grep -v ^# | \
                        uniq | \
                        grep -v "\[" ;
                cat ~/.ssh/config | \
                        grep "^Host " | \
                        awk '{print $2}'
                `
        COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
        return 0
}
complete -F _complete_ssh_hosts ssh

# Homestead function
function homestead() {
    ( cd ~/Homestead && vagrant $* )
}

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/pmeth/.config/yarn/global/node_modules/tabtab/.completions/serverless.bash ] && . /Users/pmeth/.config/yarn/global/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/pmeth/.config/yarn/global/node_modules/tabtab/.completions/sls.bash ] && . /Users/pmeth/.config/yarn/global/node_modules/tabtab/.completions/sls.bash

# add virtualenv to path
export PATH=$PATH:$HOME/Library/Python/3.7/bin

# add composer bin to path
export PATH=$PATH:$HOME/.composer/vendor/bin

source <(kubectl completion bash)
