#export CHOKIDAR_USEPOLLING=yes
export VISUAL="vim"
export EDITOR="vim"
alias ag="ag --noaffinity"

if [ -f ~/.py3env/bin/activate ]; then
    source ~/.py3env/bin/activate
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
