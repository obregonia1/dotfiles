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
alias g="git"
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
alias gad="git add"
alias gdf="git diff"
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
alias vi="vim"
alias dirto="dirtouch"

# docker
alias drua="bin/docker exec admin bundle exec rubocop"
alias drus="bin/docker exec site bundle exec rubocop"
alias dp="docker ps"
alias bdu="bin/docker up"
alias drss="bin/docker exec site bundle exec rspec --exclude-pattern 'spec/ops/**/*_spec.rb'"
alias drsa="bin/docker exec admin bundle exec rspec"
alias ds="bin/docker exec site"
alias da="bin/docker exec admin"
alias de="bin/docker exec"
alias drca="bin/docker exec admin rails c"
alias drcs="bin/docker exec site rails c"
alias dsbe="bin/docker exec site bundle exec"
alias dabe="bin/docker exec admin bundle exec"

alias la="ls -aG"
alias ls="ls -G"
alias ll="ls -lG"
alias lla="ls -laG"

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

## コマンド履歴からディレクトリ検索・移動
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':completion:*' recent-dirs-insert both
  zstyle ':chpwd:*' recent-dirs-default true
  zstyle ':chpwd:*' recent-dirs-max 1000
  zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi
function peco-cdr () {
  local selected_dir="$(cdr -l | sed 's/^[0-9]* *//' | peco)"
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N peco-cdr
bindkey '^q' peco-cdr

## カレントディレクトリ以下のディレクトリ検索・移動
function find_cd() {
  local selected_dir=$(find . -type d | peco)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N find_cd
bindkey '^X' find_cd

# search directory and cd
function find_cd() {
    cd "$(fd  --type directory . | peco)"
}

# mkdir & cd made directory
function mkdir_cd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

# run ls after cd
function chpwd() { ls -G }

# run touch after mkdir -p
function dirtouch() {
  for i in "$@"
  do
    mkdir -p $(dirname "$i")
    touch "$i"
  done
}

export PATH=$PATH:~/bin
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export LESS="-NiRMXS"
export HISTSIZE=1000
export SAVEHIST=100000
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
setopt hist_ignore_dups
setopt AUTO_CD
setopt AUTO_PARAM_KEYS
setopt inc_append_history
setopt share_history

. /opt/homebrew/opt/asdf/asdf.sh

# Load a few important annexes, without Turbo
# (this is currently required for annexes)

### End of Zinit's installer chunk

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

zinit snippet PZT::modules/helper/init.zsh
zinit snippet PZTM::environment
zinit snippet PZTM::terminal
zinit snippet https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zprofile

zinit ice wait'0'; zinit light zsh-users/zsh-completions
autoload -Uz compinit && compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*:default' menu select=1 

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

export PS1="%~ $ "

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

