
alias ls="eza --icons=always --color=never"
alias la="eza -a --icons=always --color=never"
alias ll="eza -lah --total-size --icons=always--color=never"
alias tree="eza --tree --icons=always--color=never"

# weather
alias climate="curl wttr.in/Bargur"

# alias for my preference
alias vi="nvim"
alias shut="shutdown -h now"
alias pacs="sudo pacman"
alias find='fzf -m --preview="cat {}"'

#IDK 
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

#Auto-sugesstion 
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Added by Shell-Color-Prompt-Tool
export PROMPT=$'\n%{[38;5;15m%}%{%}╭%{[0m%}%{[38;5;15m%}%{%}─%{[0m%}%{%}%{%} %{[0m%}%{[38;2;105;105;105m%}%{%}%~%{[0m%}%{%}%{%}\n%{[0m%}%{[38;5;15m%}%{%}╰%{[0m%}%{[38;5;15m%}%{%}->%{[0m%}%{%}%{%} %{[0m%} '
