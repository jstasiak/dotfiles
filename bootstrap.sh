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

    # opening and closing windows and popovers
    defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

    # smooth scrolling
    defaults write -g NSScrollAnimationEnabled -bool false

    # showing and hiding sheets, resizing preference windows, zooming windows
    # float 0 doesn't work
    defaults write -g NSWindowResizeTime -float 0.001

    # opening and closing Quick Look windows
    defaults write -g QLPanelAnimationDuration -float 0

    # rubberband scrolling (doesn't affect web views)
    defaults write -g NSScrollViewRubberbanding -bool false

    # resizing windows before and after showing the version browser
    # also disabled by NSWindowResizeTime -float 0.001
    defaults write -g NSDocumentRevisionsWindowTransformAnimation -bool false

    # showing a toolbar or menu bar in full screen
    defaults write -g NSToolbarFullScreenAnimationDuration -float 0

    # scrolling column views
    defaults write -g NSBrowserColumnAnimationSpeedMultiplier -float 0

    # showing the Dock
    defaults write com.apple.dock autohide-time-modifier -float 0
    defaults write com.apple.dock autohide-delay -float 0

    # showing and hiding Mission Control, command+numbers
    defaults write com.apple.dock expose-animation-duration -float 0

    # showing and hiding Launchpad
    defaults write com.apple.dock springboard-show-duration -float 0
    defaults write com.apple.dock springboard-hide-duration -float 0

    # changing pages in Launchpad
    defaults write com.apple.dock springboard-page-duration -float 0

    # at least AnimateInfoPanes
    defaults write com.apple.finder DisableAllAnimations -bool true

    # sending messages and opening windows for replies
    defaults write com.apple.Mail DisableSendAnimations -bool true
    defaults write com.apple.Mail DisableReplyAnimations -bool true
}

ensure_homebrew() {
    which brew > /dev/null || ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
}

ensure_pip() {
    wchich pip > /dev/null || curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py | sudo python
}

(
    (is_redhat && install_redhat_prerequisites) || \
    (is_osx && install_osx_prerequisites) || \
    (echo "Only OS X and Redhat/CentOS/Fedora supported at the moment" && exit 1)
) && \
git submodule update --init && \
./activate.py
