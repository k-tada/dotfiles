# auto compile
autoload -Uz compinit
_ZCOMPDUMP=$ZDOTDIR/$USER-zcompdump
for dump in $_ZCOMPDUMP(N.mh+24); do
    compinit -d $_ZCOMPDUMP
done
[[ -e "${_ZCOMPDUMP:r}.zwc" ]] && [[ "$_ZCOMPDUMP" -ot "${_ZCOMPDUMP:r}.zwc" ]] ||
    zcompile $_ZCOMPDUMP >/dev/null 2>&1
compinit -C -d $_ZCOMPDUMP

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# kubectl
# if [ $commands[kubectl] ]; then
#   source <(kubectl completion zsh)
#   source $ZDOTDIR/functions/zsh-kubectl-prompt/kubectl.zsh
# fi

source ~/.zshenv
source $ZDOTDIR/.zcomp
source $ZDOTDIR/.zoptions
source $ZDOTDIR/.zprompt
source $ZDOTDIR/.zaliases
source $ZDOTDIR/.zplug

if [ -e $ZDOTDIR/.zlocal ]; then
  source $ZDOTDIR/.zlocal
fi

function chpwd() { ls -sla }

# anyenv
if [ -d $HOME/.anyenv ] ; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
fi

# goenv
# export PATH="$HOME/.goenv/bin:$PATH"
# eval "$(goenv init - --no-rehash)"

# fzf
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

# [[ -z "$TMUX" && ! -z "$PS1" ]] && exec tmux

# profiling
if (which zprof > /dev/null 2>&1); then
  zprof
fi

# Override auto-title when static titles are desired ($ title My new title)
title() { export TITLE_OVERRIDDEN=1; echo -en "\e]0;$*\a"}
# Turn off static titles ($ autotitle)
autotitle() { export TITLE_OVERRIDDEN=0 }; autotitle
# Condition checking if title is overridden
overridden() { [[ $TITLE_OVERRIDDEN == 1 ]]; }
# Echo asterisk if git state is dirty
gitDirty() { [[ $(git status 2> /dev/null | grep -o '\w\+' | tail -n1) != ("clean"|"") ]] && echo "*" }

# Show cwd when shell prompts for input.
precmd() {
   if overridden; then return; fi
   cwd=${$(pwd)##*/} # Extract current working dir only
   print -Pn "\e]0;$cwd$(gitDirty)\a" # Replace with $pwd to show full path
}

# Prepend command (w/o arguments) to cwd while waiting for command to complete.
preexec() {
   if overridden; then return; fi
   printf "\033]0;%s\a" "${1%% *} | $cwd$(gitDirty)" # Omit construct from $1 to show args
}
