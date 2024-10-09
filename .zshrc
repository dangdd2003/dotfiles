# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Environment settings
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
# export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --info=inline --border"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || bat -n --color=always --style=numbers {} || tree -C {}) 2> /dev/null | head -200' --bind 'ctrl-/:change-preview-window(hidden|right)'"
export FZF_ALT_C_OPTS="--select-1 --exit-0 --walker-skip .git,node_modules,target --preview 'tree -C {}'"


# Zinit & Plugins Directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Auto download Zinit
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# Theme Powerlevel10k
# zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Theme Oh-My-Posh
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/d-dev.toml)"

# plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Oh My Zsh settings
zinit snippet OMZP::git
zinit snippet OMZP::sudo

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q


# Keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=1000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Alias
# alias ls='ls --color=auto'
# alias l='ls -lAh'
# alias ll='ls -lah'
# alias la='ls -a'
alias l='eza -lh --icons=auto --sort=name --group-directories-first' # long list
alias ls='eza --icons=auto --sort=name --group-directories-first' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias la='eza -a --icons=auto --sort=name --group-directories-first' # short list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza --icons=auto --tree' # list folder as tree


alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

alias n='nvim'
alias t='tmux'
alias refreshenv='source ~/.zshrc'
alias resetnvim="rm -rf ~/.local/state/nvim ~/.cache/nvim"
alias mkdir='mkdir -p'
prv() {
  unset HISTFILE
  echo "\n\tRunning in private environment, no commands are saved!"
}

# Shell integration
eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"
# eval "$(gh copilot alias -- zsh)"
