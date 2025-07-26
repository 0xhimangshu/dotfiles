source .env
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="himonshuuu"

plugins=(
    archlinux
    autojump
    git
    pip
    python
    npm
    pnpm
    node
    virtualenv
    git
    
    zsh-ai
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

alias clear="clear && printf '\033c'"
alias zshreload="source ~/.zshrc"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
 
# SSH Agent Configuration
if [ -z "$SSH_AUTH_SOCK" ]; then
    # Start ssh-agent
    eval "$(ssh-agent -s)" > /dev/null
fi

# Add SSH key if not already added
if ! ssh-add -l | grep -q "$HOME/ssh-keys/github" 2>/dev/null; then
    ssh-add -q "$HOME/ssh-keys/github" 2>/dev/null
fi

. "$HOME/.local/bin/env"

export PATH=$PATH:/home/human/.spicetify

# bun completions
[ -s "/home/human/.bun/_bun" ] && source "/home/human/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="/home/human/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
