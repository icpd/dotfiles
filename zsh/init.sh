#!/bin/bash

if [ ! -d ~/.oh-my-zsh ]; then
  echo "Installing Oh My Zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
  echo "Installing Zsh autosuggestions plugin"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
  echo "Installing Zsh syntax highlighting plugin"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

if [ ! -f ~/.oh-my-zsh/themes/robbyrussell.zsh-theme ]; then
  echo "Installing custom Robby Russell theme"
  wget -O ~/.oh-my-zsh/themes/robbyrussell.zsh-theme https://raw.githubusercontent.com/icpd/robbyrussell.zsh-theme/master/robbyrussell.zsh-theme
fi

if [ ! -f ~/.zshrc ]; then
  echo "Downloading custom .zshrc config file"
  wget https://raw.githubusercontent.com/icpd/dotfiles/master/zsh/.zshrc
fi

echo "Sourcing the new .zshrc file"
# Source the new .zshrc file
source ~/.zshrc

echo "Oh My Zsh and plugins installed successfully!"
