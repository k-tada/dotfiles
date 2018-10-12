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
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
  source $ZDOTDIR/functions/zsh-kubectl-prompt/kubectl.zsh
fi

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
  eval "$(anyenv init - --no-rehash)"
fi

# goenv
export PATH="$HOME/.goenv/bin:$PATH"
eval "$(goenv init - --no-rehash)"

# fzf
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

# profiling
if (which zprof > /dev/null 2>&1); then
  zprof
fi
