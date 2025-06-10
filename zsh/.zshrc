# echo && fortune && echo
# toilet -f term -F border " It only takes two weeks. " && echo
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="random"


# LS_COLORS='rs=0:di=01;38;5;12:ln=01;38;5;14:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=38;5;12;42:st=37;44:ex=01;38;5;10:'
# export LS_COLORS

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	kubectl
	gitfast
	history-substring-search
	zsh-completions
	zsh-autosuggestions
)

autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
#
# 
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/geo/.zshrc'

# End of lines added by compinstall
#
#

source <(fzf --zsh)
# alias vf='fzf -m --bind "enter:become(nvim {})"'
# alias vf='find -P . -type f | fzf -m --preview="bat --color=always {}" --bind "enter:become(cd $(dirname {}) && nvim $(basename {}))"'
# alias vf='cd $(find . -type d | fzf) && fzf -m --bind "enter:become(nvim {})"'
# alias ff='cd $(find -P ~/Documents/Projects/ -type d -print0 | fzf --read0) && tmux'

ff() {
    HISTORY_FILE="$HOME/.fzf_project_history"

    dir=$( (
      cat "$HISTORY_FILE"
      find -P ~/Documents/Projects/ -type d
    ) | fzf --preview="tree -C -C {}")

    name=$(basename "$dir")

    if [[ -n "$dir" ]]; then

      tmp_history=$(mktemp) # Create a temporary file
      {
        echo "$dir"
        grep -Fxv "$dir" "$HISTORY_FILE"
      } | sed '/^$/d' | head -n 5 >"$tmp_history"
      mv "$tmp_history" "$HISTORY_FILE" # Replace history file safely

      if [[ -d "$dir" ]]; then
        if [ -n "$TMUX" ]; then
          if tmux has-session -t $name 2>/dev/null; then
            tmux switch-client -t $name
          else
            tmux new-session -d -s "$name" -c "$dir" "nvim -S Session.vim"
            tmux switch-client -t "$name"
          fi
        else
          if tmux has-session -t $name 2>/dev/null; then
            tmux attach-session -t $name
          else
            tmux new-session -d -s "$name" -c "$dir" "nvim -S Session.vim"
            tmux attach-session -t "$name"
          fi
        fi
      else
        echo "Selected directory does not exist: $dir"
      fi
    else
      echo "No directory selected."
    fi
}

vf() {
  local file
  file=$(find -P . -type f | fzf -m --preview="bat --color=always {}")
  if [[ -n "$file" ]]; then
    cd "$(dirname "$file")"
    nvim "$(basename "$file")"
  fi
}

#Start X
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	#exec startx &>/dev/null
	exec Hyprland &>/dev/null
fi



# export PATH="$PATH:/home/geo/.config/emacs/bin"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# eval "$(starship init zsh)"
export PATH=$PATH:/home/geo/.cargo/bin
export JAVA_HOME=/usr/lib/jvm/java-23-openjdk
export QT_QPA_PLATFORM='wayland;xcb'
# export QT_STYLE_OVERRIDE='gtk2'
# export QT_QPA_PLATFORM=wayland-xcomposite-glx
# export QT_QPA_PLATFORM=wayland-xcomposite-egl
# export QT_QPA_PLATFORM=xcb
# export QT_QPA_PLATFORMTHEME=qt5ct
export QT_QPA_PLATFORMTHEME=qt5ct
# export QT_QPA_PLATFORMTHEME="xcb"
export PATH="$HOME/.emacs.d/bin:$PATH"
export BAT_THEME="base16"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
export EDITOR="nvim"
export VISUAL="nvim"
bg=$(head -n 1 ~/.cache/wal/colors)
alias feh="feh -B '$bg'"

export FZF_DEFAULT_OPTS='
  --height 40%
  --layout=reverse
  --border=sharp
  --preview-border=sharp
  --color=16
  --color=border:cyan
  --color=current-bg:bright-black
  --pointer=󰄾 
  --preview "bat --style=numbers --color=always --line-range :500 {}"
  --prompt=" │"
'



