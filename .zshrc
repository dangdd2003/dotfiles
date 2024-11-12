# Environment settings
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
# export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --info=inline --border \
--color=bg+:#363a4f,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
--color=selected-bg:#494d64 \
--multi"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS="--preview '(bat -n --color=always --style=numbers {}) 2> /dev/null | head -200' --bind 'ctrl-/:'toggle-preview',ctrl-e:preview-down,ctrl-y:preview-up'"
export FZF_ALT_C_OPTS="--select-1 --exit-0 --walker-skip .git,node_modules,target --preview '(eza -T --color=always --icons --sort=name {}) 2> /dev/null | head -50' --bind 'ctrl-/:toggle-preview,ctrl-e:preview-down,ctrl-y:preview-up'"

# Zinit & Plugins Directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Auto download Zinit
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# Theme Oh-My-Posh
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/d-dev.toml)"

# Plugins with turbo load
zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      Aloxaf/fzf-tab \
      zsh-users/zsh-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions

# Oh My Zsh settings
zinit snippet OMZP::git
zinit snippet OMZP::sudo

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
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-min-height 15
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1a --color=always --icons=auto $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1a --color=always --icons=auto $realpath ctrl-/:toggle-preview,ctrl-e:preview-down,ctrl-y:preview-up'
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:*' fzf-bindings 'ctrl-/:toggle-preview,ctrl-e:preview-down,ctrl-y:preview-up'

# Alias
alias l='eza -lh --icons=auto --sort=name --group-directories-first' # long list
alias ls='eza --icons=auto --sort=name --group-directories-first' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias la='eza -a --icons=auto --sort=name --group-directories-first' # short list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza -a --icons=auto --tree' # list folder as tree

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
