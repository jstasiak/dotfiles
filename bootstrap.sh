#!/usr/bin/env sh

is_redhat() {
    which yum > /dev/null
}

install_redhat_prerequisites() {
    sudo yum upgrade -y && \
    sudo yum install -y vim-enhanced git-core git-svn cmake make mc screen zsh htop \
        dstat python-distribute iptraf nmap nc ctagse python-devel wget curl
}

is_osx() {
    which otool > /dev/null
}

install_osx_prerequisites() {
    mkdir -p ~/Applications && \
    ensure_homebrew && \
    brew update && \
    brew upgrade && \
    brew install cmake git zsh mc netcat nmap htop && \
    brew install macvim --override-system-vim && \
    brew linkapps
}

ensure_homebrew() {
    which brew > /dev/null || ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
}

ensure_pip() {
    wchich pip > /dev/null || curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py | sudo python
}

(is_redhat && install_redhat_prerequisites) || \
(is_osx && install_osx_prerequisites) || \
(echo "Only OS X and Redhat/CentOS/Fedora supported at the moment" && exit 1)

./activate.py
