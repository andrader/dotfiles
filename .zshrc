# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"
eval "$(starship init zsh)"

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
plugins=(git python zsh-interactive-cd)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"



# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(starship init zsh)"

# AUTOCOMPLETION

# initialize autocompletion (mac?)
# autoload -U compinit
# compinit


# history setup
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=9999
setopt EXTENDED_HISTORY        # Save timestamp with history entries
setopt HIST_IGNORE_DUPS        # Ignore duplicate commands in history
setopt HIST_IGNORE_SPACE       # Ignore commands starting with space
setopt HIST_SAVE_NO_DUPS       # Do not save duplicate commands in history file
setopt HIST_EXPIRE_DUPS_FIRST  # Expire duplicates first when trimming history
setopt HIST_FIND_NO_DUPS     # Do not show duplicates when searching history
setopt HIST_IGNORE_ALL_DUPS # Ignore all duplicates in history
setopt HIST_VERIFY         # Verify history expansion before executing
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks from history entries
setopt SHARE_HISTORY       # Share history across all sessions
setopt COMPLETE_IN_WORD    # Allow completion to be triggered in the middle of a word

# autocompletion using arrow keys (based on history)
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# source aliases
SCRIPT_DIR=$(dirname "$(realpath "$0")") # symlink to /Users/rubens/projects/dotfiles/.zshrc
ALIASES_FILE="$SCRIPT_DIR/aliases.sh"
if [ -f "$ALIASES_FILE" ]; then
  source "$ALIASES_FILE"
else
  echo "Warning: Aliases file not found at $ALIASES_FILE"
fi

# try to load brew zsh autosuggestions
if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# try to load brew zsh syntax highlighting
if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# try use ls replacement
if command -v eza > /dev/null 2>&1; then
  alias ls="eza --icons=always"
fi


# try to load zoxide for enhanced cd functionality
if command -v zoxide > /dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  alias cd="z"
fi


# ------


# bun completions
[ -s "/home/rubens/.bun/_bun" ] && source "/home/rubens/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# R library path
if command -v R > /dev/null 2>&1; then
  export LD_LIBRARY_PATH="$(R RHOME)/lib:${LD_LIBRARY_PATH}"
fi


# function to install all extra tools
function install_extras() {
  # install bun
  curl -fsSL https://bun.sh/install | bash

  # install nvm
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

  # install zoxide
  curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

  # install starship
  curl -sS https://starship.rs/install.sh | sh

  # install zsh-autosuggestions
  brew install zsh-autosuggestions

  brew install zsh-syntax-highlighting

  
}


# Adjust how often this is run with `$HOMEBREW_AUTO_UPDATE_SECS` or disable with
# `$HOMEBREW_NO_AUTO_UPDATE=1`. Hide these hints with `$HOMEBREW_NO_ENV_HINTS=1` (see `man brew`).

# set 6 months, #$((6 * 30 * 24 * 60 * 60))
export HOMEBREW_AUTO_UPDATE_SECS=15552000
export HOMEBREW_NO_ENV_HINTS=1

fpath+=~/.zfunc; autoload -Uz compinit; compinit

export PATH="$HOME/bin:$PATH"


# Added by Antigravity CLI installer
export PATH="/Users/rubens/.local/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/rubens/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
# >>> deepseek-harness dsh >>>
export PATH="$HOME/.local/bin:$PATH"
# <<< deepseek-harness dsh <<<



if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi
