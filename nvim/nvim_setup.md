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

# eslint for javascript linting
npm install eslint --global

# Ripgrep
brew install ripgrep

# Install fonts for the Terminal
# (Hack Regular Nerd Font)
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font

# pynvim
pip install pynvim
pip3 install pynvim
```

Nvim:
```
brew install neovim
```

## Installing on Windows

This is only for the worst case scneraio when there is no unix based system around to work with...

Dependencies:
```
# Python
https://www.python.org/downloads/windows/

# Nodejs
https://nodejs.org/en/

# Ripgrep
https://github.com/BurntSushi/ripgrep/releases

# Install fonts for the Command Prompt
# (Hack Nerd Font)
https://www.nerdfonts.com/font-downloads
```

Note: these dependencies are specifically for Windows, the rest (from the OSX install section) should still be installed like above.

Nvim:
```
https://github.com/neovim/neovim/releases
```

# Post Install Configuration

## OSX specific configuration

Make sure your .vimrc is unix format:
```
dos2unix .vimrc
```

Copy your .vimrc to your home folder and issue the following command:
```
mkdir -p ~/.config/nvim
echo 'source ~/.vimrc' > ~/.config/nvim/init.vim
```

Install vim-plug:
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

After first running nvim for the first time, install plugins:
```
:PlugInstall
```

## Windows specific configuration

Add ripgrep to your PATH (system environmental varialbes)!

Copy your .vimrc to your user's profile folder (C:\Users\{username}).

Install vim-plug (Powershell):
```
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$env:LOCALAPPDATA/nvim-data/site/autoload/plug.vim" -Force
```

After first running nvim for the first time, install plugins:
```
:PlugInstall
```
