export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export TERMINAL=kitty

#ZSH_THEME="jovial"
ZSH_THEME="robbyrussell"
plugins=(
  zsh-history-enquirer

  git
  autojump
  urltools
  bgnotify
  zsh-autosuggestions
  zsh-syntax-highlighting
  jovial
)

source $ZSH/oh-my-zsh.sh

eval "$(ssh-agent -s)" > /dev/null
ssh-add ~/keys/github &> /dev/null

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias dotfiles='/usr/bin/git --git-dir="$HOME/dotfiles/.git" --work-tree="$HOME"'



export PATH=$PATH:/home/himonshuuu/.spicetify

if [ -e /home/himonshuuu/.nix-profile/etc/profile.d/nix.sh ]; then . /home/himonshuuu/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
