###
# Setup
if status --is-login
  # homebrew
  set PATH $PATH /usr/local/bin
  set PATH $PATH /usr/local/sbin
  set -x HOMEBREW_CASK_OPTS '--appdir=/Applications --caskroom=/opt/homebrew-cask/Caskroom'

  # go
  # set GOPATH $HOME/gocode
  # set PATH $PATH $HOME/gocode/bin

  # anyenv
  set -x PATH $HOME/.anyenv/bin $PATH
  # for dir in (ls $HOME/.anyenv/envs)
  #   set -x PATH $HOME/.anyenv/envs/$dir/bin $PATH
  #   set -x PATH $HOME/.anyenv/envs/$dir/shims $PATH
  # end
  # . $HOME/.anyenv/completions/anyenv.fish
  . (anyenv init - fish|source)

  # ndenv
  # set -x PATH $HOME/.ndenv/bin $PATH
  # eval (ndenv init -)

  # pyenv
  # set -x PATH $HOME/.pyenv/bin $PATH
  set -x PATH $HOME/.pyenv/shims $PATH
  . (pyenv init - | psub)
  set -x C_INCLUDE_PATH $HOME/.pyenv/versions/anaconda3-4.1.1/include/python3.5m
  set -x CPLUS_INCLUDE_PATH $HOME/.pyenv/versions/anaconda3-4.1.1/include/python3.5m

  # Android
  set PATH $PATH $HOME/Library/Android/sdk/platform-tools
  set PATH $PATH $HOME/Library/Android/sdk/tools
  set -x ANDROID_HOME $HOME/Library/Android/sdk

  set -x TMUX_TMPDIR $XDG_RUNTIME_DIR

  fish_vi_key_bindings
end

###
# Aliases
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias ll='ls -lsa'
alias llt='ls -lsat'
alias diff="colordiff -u"
alias v='vagrant'
# alias vim '/usr/local/bin/vim'
alias vim '/usr/local/bin/nvim'
alias git='/usr/local/bin/git'
alias ctags='`brew --prefix`/bin/ctags'

###
# git
set git_color red

function parse_git_branch
  set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
  set -l git_diff (git diff)

  echo (set_color $git_color)'['$branch']'(set_color normal)
end

###
# propmt
function fish_prompt
  if [ $status -eq 0 ]
    set status_face (set_color cyan)"(*･∀･) { "
  else
    set status_face (set_color brblue)"(#･Ａ･) { "
  end

  set -l git_dir (git rev-parse --git-dir 2> /dev/null)
  set propmt (set_color yellow)(pwd)

  if test -n "$git_dir"
    echo $propmt (parse_git_branch)
    echo $status_face
  else
    echo $propmt
    echo $status_face
  end
end

###
# cd→自動でfs
function cd
    if test (count $argv) -eq 0
        $argv = "$HOME"
    else if test (count $argv) -gt 1
        printf "%s\n" (_ "Too many args for cd command")
        return 1
    end
    # Avoid set completions.
    set -l previous $PWD

    if test "$argv" = "-"
        if test "$__fish_cd_direction" = "next"
            nextd
        else
            prevd
        end
        return $status
    end
    builtin cd $argv
    set -l cd_status $status
    # Log history
    if test $cd_status -eq 0 -a "$PWD" != "$previous"
        set -q dirprev[$MAX_DIR_HIST]
        and set -e dirprev[1]
        set -g dirprev $dirprev $previous
        set -e dirnext
        set -g __fish_cd_direction prev
    end

    if test $cd_status -ne 0
        return 1
    end
    ls -sla
    return $status
end

if test $TERM_PROGRAM = iTerm.app
    test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
end
