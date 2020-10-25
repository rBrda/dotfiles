# Neovim and dependencies

This is a note only for me about installing Neovim

## Installing on OSX using brew

Dependencies:
```
# Python
brew install python
brew install python3

# Nodejs
brew install node

# Ripgrep
brew install ripgrep

# Bat for syntax highlighting in fzf
brew install bat

# Install fonts for the Terminal
# (Hack Regular Nerd Font)
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font

# pynvim
pip install pynvim
pip3 install pynvim

# yarn
npm install -g yarn

# eslint for javascript linting
npm install -g eslint

# neovim extension for nodejs
npm install -g neovim
```

Nvim:
```
brew install neovim
```

## Installing on Linux (Ubuntu/Debian)

TODO: write section

# Post Install Configuration

## OSX specific configuration

Make sure your .vimrc is unix format (optional):
```
dos2unix .vimrc
```

Create a symlink for your .vimrc (before this delete the .vimrc in your home dir if there is any):
```
ln -sf ~/dotfiles/nvim/.vimrc ~/.vimrc
```

We will configure Neovim to use the symlinked file instead of the versioned file:
```
mkdir -p ~/.config/nvim
echo 'source ~/.vimrc' > ~/.config/nvim/init.vim
```

Install vim-plug:
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Run Neovim to install all plugins (this is done automatically in the .vimrc file).

Then configure CoC to use Ale for diagnostics by issuing the `:CocConfig` command and paste the following:
```
{
    "coc.preferences.diagnostic.displayByAle": true
}
```

## Linux specific configuration (Ubuntu/Debian)

TODO: write section
