#!/bin/bash
#
# Filename     : install.sh
# Author       : Yongwen Zhuang
# Last Modified: 2018-07-26 22:27 +0800
# Copyright (C) 2018 Yongwen Zhuang <zeoman@163.com>

# Check software exist
_check_exist(){
    softwares=("$@")
    for sw in "${softwares[@]}"
    do
        # Notice the semicolon
        type "${sw}" > /dev/null 2>&1 ||
            { echo >&2 "ERROR: **${sw}** is not installed!"; exit 1; }
    done
}

# git config
install_git(){
    _check_exist git
    mkdir ~/.gittemplate
    mkdir ~/.gittemplate/hooks
    ln -s "$PWD"/../dual/prepare-commit-msg ~/.gittemplate/hooks/prepare-commit-msg
    ln -s "$PWD"/../dual/gitconfig ~/.gitconfig
    ln -s "$PWD"/../dual/gitmessage ~/.gitmessage
    ln -s "$PWD"/../dual/gitignore ~/.gitignore
}

# zsh config
install_zsh(){
    _check_exist zsh
    # Install oh-my-zsh
    git clone https://github.com/robbyrussell/oh-my-zsh.git "${HOME}/.oh-my-zsh"
    # Install fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
    # Install zplugin
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
    # Link zshrc
    ln -s "$PWD/zshrc" ~/.zshrc
}

# vim config
install_vim(){
    _check_exist zsh curl
    echo "Install libclang And Use --system-libclang to use YCM"
    ln -s "$PWD"/../dual/vimrc ~/.vimrc
}

# i3 config
install_i3(){
    _check_exist i3 i3bar i3lock feh compton compton fcitx amixer xterm transset-df dmenu convert
    echo "Please Install Noto-Fonts Noto-Fonts-CJK Noto-Fonts-Emoji First"
    mkdir -p ~/.config/i3
    ln -s "$PWD"/i3status.conf ~/.i3status.conf
    ln -s "$PWD"/i3config ~/.config/i3/config
    cp lock.jpg ~/.lock.jpg
    convert lock.jpg -resize 1920 ~/.lock.png
}

# X config
install_X(){
    _check_exist xorg-server xorg-xinit xterm
    ln -s "$PWD"/xinitrc ~/.xinitrc
    ln -s "$PWD"/Xresources ~/.Xresources
}

# ssh key
install_ssh(){
    _check_exist ssh
    mkdir ~/.ssh
    cp "$PWD"/authorized_keys ~/.ssh/authorized_keys
}

# tmux config
install_tmux(){
    _check_exist tmux git cmake make
    ln -s "$PWD"/tmux.conf ~/.tmux.conf
    git clone https://github.com/thewtex/tmux-mem-cpu-load tmux_vendor
    cd tmux_vendor/tmux-mem-cpu-load && cmake . && make && sudo make install
    rm -r tmux_vendor
}

# pip config
install_python(){
    _check_exist python pip
    mkdir ~/.pip
    ln -sf "$PWD"/../dual/pip.conf ~/.pip/pip.conf
    ln -sf "$PWD"/pythonrc ~/.pythonrc
}

install_ss(){
    _check_exist ssserver proxychains
    echo "Edit /etc/proxychains.conf"
    echo "Add Lines"
    echo
    echo "[ProxyList]"
    echo "socks5 127.0.0.1 1080"
    echo
    echo "Edit /etc/shadowsocks/example.json"
    echo "Autostart"
    echo "systemctl enable shadowsocks@example.service"
}
get_functions() {
    # Usage: get_functions
    IFS=$'\n' read -d "" -ra functions < <(declare -F)
    printf '    %s\n' "${functions[@]//declare -f }"
}
