[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $ZDOTDIR/.zcomp
source $ZDOTDIR/.zoptions
source $ZDOTDIR/.zprompt
source $ZDOTDIR/.zaliases
source $ZDOTDIR/.zplug

function chpwd() { ls -sla }

# anyenv
if [ -d $HOME/.anyenv ] ; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
fi

# goenv
export PATH="$HOME/.goenv/bin:$PATH"
eval "$(goenv init -)"

# fzf
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

