#profile
# zmodload zsh/zprof && zprof

# if [ -z $TMUX ]; then
  # XDG
  if [[ -z "$XDG_CONFIG_HOME" ]]; then
    export XDG_CONFIG_HOME="$HOME/.config"
  fi
  if [[ -z "$XDG_CACHE_HOME" ]]; then
    export XDG_CACHE_HOME="$HOME/.cache"
  fi
  if [[ -z "$XDG_DATA_HOME" ]]; then
    export XDG_DATA_HOME="$HOME/.local/share"
  fi
  if [[ -z "$XDG_DATA_DIRS" ]]; then
    export XDG_DATA_DIRS="/usr/local/share:/usr/share"
  fi
  if [[ -z "$XDG_CONFIG_DIRS" ]]; then
    export XDG_CONFIG_DIRS="/etc/xdg"
  else
    export XDG_CONFIG_DIRS="/etc/xdg:$XDG_CONFIG_DIRS"
  fi

  # Zsh
  if [[ -d "$XDG_CONFIG_HOME/zsh" ]]; then
    export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
  fi

  export BASH_SILENCE_DEPRECATION_WARNING=1

  # load local .zshenv
  source $ZDOTDIR/.zenv
# fi
