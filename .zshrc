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
alias gcm="git commit -m"
alias gst="git stash"
alias gstc="git stash clear"
alias gstat="git status" 
alias gstu="git stash -u"
alias gstp="git stash pop stash@{0}"
alias gstl="git stash list"
alias delete-branches="git branch --merged|egrep -v '\*|develop|main|master'|xargs git branch -d"

alias be="bundle exec"
alias bi="bundle install"
alias rs="rails s"
alias r="rails"
alias rc="rails c"
alias rdm="rails db:migrate"
alias sz="source ~/dotfiles/.zshrc"
alias vz="vim ~/dotfiles/.zshrc"
alias lz="less ~/dotfiles/.zshrc"
alias fc="find_cd"
alias yare="rm -rf node_modules/.cache/ && yarn dev"
alias mdc="mkdir_cd"
alias so="source"
alias le="less"

# docker
alias drua="bin/docker exec admin bundle exec rubocop"
alias drus="bin/docker exec site bundle exec rubocop"
alias dp="docker ps"
alias bdu="bin/docker up"
alias drss="bin/docker exec site bundle exec rspec --exclude-pattern 'spec/ops/**/*_spec.rb'"
alias drsa="bin/docker exec admin bundle exec rspec"
alias ds="bin/docker exec site"
alias da="bin/docker exec admin"
alias drca="bin/docker exec admin rails c"
alias drcs="bin/docker exec site rails c"

alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"

# delete line head to cursol
bindkey \^U backward-kill-line

# display repositories managed by ghq and cd
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

# incremental history search with peco
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

# search directory and cd
function find_cd() {
    cd "$(fd  --type directory . | peco)"
}

# mkdir & cd made directory
function mkdir_cd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

# run ls after cd
function chpwd() { ls }

export PATH=$PATH:~/bin
export LESS="-NiRMXS"
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_dups
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

. /opt/homebrew/opt/asdf/asdf.sh

