#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
# git
alias gr="git restore"
alias gb="git branch"
alias gs="git switch"
alias gsc="git switch -c"
alias gsd="git switch develop"
alias gpd="git pull origin develop"
alias gh="git history"
alias delete-branches="git branch --merged|egrep -v '\*|develop|main|master'|xargs git branch -d"

alias video="open -a /Applications/5KPlayer.app/ "
alias be="bundle exec"
alias bi="bundle install"
alias rs="rails s"
alias r="rails"
alias rc="rails c"
alias rdm="rails db:migrate"
alias sz="source ~/src/github.com/obregonia1/dotfiles/.zshrc"
alias vz="vim ~/src/github.com/obregonia1/dotfiles/.zshrc"
alias lz="less ~/src/github.com/obregonia1/dotfiles/.zshrc"
alias fc="find_cd"
alias yare="rm -rf node_modules/.cache/ && yarn dev"
alias drca="bin/docker exec admin rails c"
alias drcs="bin/docker exec site rails c"

# docker
alias drua="bin/docker exec admin bundle exec rubocop"
alias drus="bin/docker exec site bundle exec rubocop"
alias dp="docker ps"
alias bdu="bin/docker up"
alias drss="bin/docker exec site bundle exec rspec"
alias drsa="bin/docker exec admin bundle exec rspec"
alias ds="bin/docker exec site"
alias da="bin/docker exec admin"

alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"

bindkey \^U backward-kill-line

function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function chpwd() { ls }

function find_cd() {
    cd "$(fd  --type directory . | peco)"
}

export PATH="$PATH:/Users/kentaro/development/flutter/bin"
# export PATH="$HOME/.nodenv/bin:$PATH"
# eval "$(nodenv init -)"
export LESS="-NiRMXS"
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_dups
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

. /opt/homebrew/opt/asdf/asdf.sh
