
#######
# git #
#######
alias g="git"
alias gr="git restore"
alias gb="git branch"
alias gs="git switch"
alias gsc="git switch -c"
alias gsd="git switch develop"
alias gpd="git pull origin develop"
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit --amend"
alias gst="git stash"
alias gstc="git stash clear"
alias gstat="git status"
alias gstu="git stash -u"
alias gstp="git stash pop stash@{0}"
alias gstl="git stash list"
alias gad="git add"
alias grb="git rebase"
alias gco="git checkout"
alias gcp="git log --oneline | peco | awk '{print \$1}' | pbcopy"
alias delete-branches="git branch --merged|egrep -v '\*|develop|main|master'|xargs git branch -d"

alias be="bundle exec"
alias bi="bundle install"
alias rs="rails s"
alias r="rails"
alias rc="rails c"
alias rdm="rails db:migrate"
alias sz="source ~/.zshrc"
alias vz="nvim ~/.zshrc"
# alias vz="nvim ~/src/github.com/obregonia1/dotfiles/.zshrc"
alias lz="bat ~/.zshrc"
alias vv="nvim ~/.config/nvim/init.vim"
alias vd="nvim ~/.config/nvim/dein.toml"
alias mdc="mkdir_cd"
alias so="source"
alias le="less"
alias vi="nvim"
alias pbc="pbcopy"
alias la="exa -a"
alias ls="exa"
alias ll="exa -l"
alias lla="exa -la"
alias ..="cd .."
alias ...="cd ../.."
alias g++="/opt/homebrew/bin/g++-12"
alias pcp="peco | pbcopy"

##########
# docker #
##########
alias dru="bin/docker exec site bundle exec rubocop"
alias dp="docker ps"
alias bdu="bin/docker up"
alias drs="bin/docker exec site bundle exec rspec"
alias ds="bin/docker exec site"
alias de="docker exec"
alias drc="bin/docker exec site rails c"
alias dbe="bin/docker exec site bundle exec"
alias da="docker attach"

# run ls after cd
function chpwd() { ls -G }

# git diff with bat
batdiff() {
  git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

acopen () { acc contest $1 | awk '{print $NF}' | xargs open }

# setting to ctrl + w delete to symbol
export WORDCHARS='*?_.[]~-=&;!#$%^(){}<>'

export LESS="-iRMXS"
export HISTSIZE=1000
export SAVEHIST=100000
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='bat'
setopt hist_ignore_dups
setopt AUTO_CD
setopt AUTO_PARAM_KEYS
setopt inc_append_history
setopt share_history
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
typeset -aU path cdpath fpath manpath
bindkey \^U backward-kill-line

# switch brew by architecture
if [ "$(uname -m)" = "arm64" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH="$PATH:/opt/homebrew/bin"
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
else
  eval "$(/usr/local/bin/brew shellenv)"
  export PATH=/usr/local/bin:$PATH
  # for m1
  #  . /usr/local/opt/asdf/libexec/asdf.sh

  # for intel
  . /usr/local/opt/asdf/asdf.sh
fi

export PATH=$PATH:`npm bin -g`

# switch openssl version by ruby version
#RUBY_V=$(ruby -v | awk '$0 = substr($2, 0, 3)')
#if [[ `echo "$RUBY_V >= 3.1" | bc` == 1 ]];then
#  export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
#  export LIBRARY_PATH=$LIBRARY_PATH:/opt/homebrew/Cellar/zstd/1.5.2/lib:/opt/homebrew/Cellar/openssl@3/3.0.5/lib/
#else
#  export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
#  export LIBRARY_PATH=$LIBRARY_PATH:/opt/homebrew/Cellar/zstd/1.5.2/lib:/opt/homebrew/Cellar/openssl@1.1/1.1.1o/lib/
#fi
# export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export PATH="/usr/local/Cellar/openssl@1.1/1.1.1m/bin:$PATH"
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/Cellar/zstd/1.5.2/lib:/usr/local/Cellar/openssl@1.1/1.1.1m/lib/
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
zinit light gimbo/iterm2-tabs.zsh
zinit light paulirish/git-open
zinit light supercrabtree/k

############
# anyframe #
############
zinit light mollifier/anyframe

# select recent directory & cd with peco
function anyframe-cdr () {
  anyframe-source-cdr  \
    | anyframe-selector-auto \
    | anyframe-action-put
}
zle -N anyframe-cdr
alias cdr="anyframe-cdr"
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# display repositories managed by ghq and cd
zle -N anyframe-widget-cd-ghq-repository
alias cdg="anyframe-widget-cd-ghq-repository"

# select & switch git branch
alias gsh="anyframe-widget-checkout-git-branch"

# export PS1="%~ $ "

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$HOME/.asdf/shims:$PATH"
export PATH="$PATH:$HOME/bin"
