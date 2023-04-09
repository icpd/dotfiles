#!/bin/bash

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Zsh autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install Zsh syntax highlighting plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install custom Robby Russell theme
wget -O ~/.oh-my-zsh/themes/robbyrussell.zsh-theme https://raw.githubusercontent.com/icpd/robbyrussell.zsh-theme/master/robbyrussell.zsh-theme

# Download custom .zshrc config file
wget https://raw.githubusercontent.com/icpd/dotfiles/master/zsh/.zshrc

# Source the new .zshrc file
source ~/.zshrc

echo "Oh My Zsh and plugins installed successfully!"
