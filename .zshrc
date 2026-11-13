# ===================== 0. Env Setup =====================
export WEBKIT_DISABLE_COMPOSITING_MODE=1
export ZSH="$HOME/.zsh"
export ZSH_CUSTOM="$ZSH/custom"
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/snapd/desktop
export PATH="$HOME/.flutter/bin:$PATH"
export CHROME_EXECUTABLE=/usr/bin/chromium-browser
export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/var/lib/snapd/desktop
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools


# ===================== 1. Fastfetch =====================
if command -v fastfetch >/dev/null; then
  fastfetch -c ~/.config/fastfetch/config.jsonc
fi

# ===================== Zsh Completion (CORE) =====================
autoload -Uz compinit
compinit
# ===================== zsh-autocomplete =====================
# [ -f ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh ] \
  # && source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# ===================== 2. Powerlevel10k =====================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# ===================== 3. History Settings =====================
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE APPEND_HISTORY INC_APPEND_HISTORY

# ===================== 4. Aliases =====================
alias ls="eza --icons=always --color=always"
alias aemu='QT_QPA_PLATFORM=xcb GDK_BACKEND=x11 SDL_VIDEODRIVER=x11 command emulator'
alias la="eza -a --icons=always --color=always"
alias pic="kitty +kitten icat"
alias ll="eza -lah --total-size --icons=always --color=always"
alias tree="eza --tree --icons=always --color=always"
alias climate="curl wttr.in/Bargur"
alias shut="shutdown -h now"
alias apt="sudo nala"
alias cp="sudo cp -rv"
alias mv="mv -v"
alias rm="rm -rv"
alias li="fzf --preview 'kitty +kitten icat --clear --stdin no --transfer-mode memory --place 60x100@100x0 {}'"
alias vi="nvim"
# alias cat="batcat"
alias lgr="ls | grep"

# ===================== Plugins =====================

# zsh-autocomplete (must be first)
# [ -f ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh ] \
#   && source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# autosuggestions
[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] \
  && source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax highlighting (MUST be last)
[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] \
  && source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ===================== 6. FZF Configuration =====================
export FZF_CTRL_R_OPTS="--style full --height -10 --preview '' --layout reverse --border none"
export FZF_ALT_C_OPTS="--preview 'eza --tree --icons=always --color=always  {} | head -200'"
export FZF_DEFAULT_OPTS="--style full --preview 'batcat -n --color=always {}' --height -4 --layout reverse --border --padding 1,2"
export FZF_COMPLETION_TRIGGER='**'


# Custom ripgrep + fzf launcher
rzf() {
  RG_PREFIX="rg --column --line-number --no-heading --color=always"
  fzf --ansi \
    --prompt="  " \
    --delimiter : \
    --bind "change:reload:$RG_PREFIX {q} || true" \
    --preview 'batcat --style=numbers --color=always --highlight-line {2} {1}' \
    --height -2 \
    --phony \
    --query "$1" \
}

# ===================== 7. Tmux Binding =====================
start_tmux() {
  if tmux has-session -t main 2>/dev/null; then
    tmux attach -t main
  else
    tmux new-session -s main
  fi
}
bindkey -s '^F' 'start_tmux\n'

# ===================== 8. Java, Maven, Android =====================
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk"
export MAVEN_HOME="/opt/apache-maven"
export PATH="$JAVA_HOME/bin:$MAVEN_HOME/bin:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$PATH"

# Java compile shortcut
j() {
  if [ -z "$1" ]; then
    echo "Usage: j <filename.java>"
    return 1
  fi
  local fname=$(basename "$1" .java)
  javac "$fname.java" && java "$fname"
}

# ===================== 9. Wayland =====================
export XDG_DATA_DIRS="$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share:$XDG_DATA_DIRS"
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland
export SDL_VIDEODRIVER=wayland
export CLUTTER_BACKEND=wayland
export XDG_SESSION_TYPE=wayland
export GDK_BACKEND=wayland
export OZONE_PLATFORM=wayland

# ===================== 10. Node Version Manager =====================
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# ===================== FZF (system) =====================
if [ -f /usr/share/fzf/shell/key-bindings.zsh ]; then
  source /usr/share/fzf/shell/key-bindings.zsh
fi

# ===================== Pyenv (safe load) =====================
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv virtualenv-init -)"
fi



# =====================  DART =====================
export PATH="$PATH:/opt/dart/dart-sdk/bin"


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
