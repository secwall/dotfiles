# fisher install rkbk60/onedark-fish
# fisher install patrickf1/fzf.fish
printf '\33c\e[3J'
ulimit -n 16384 >/dev/null 2>&1
set -gx LC_CTYPE en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx TERM xterm-256color
set -gx EDITOR /opt/homebrew/bin/nvim
set -gx GOPATH $HOME/.go
set -gx CPM_SOURCE_CACHE /Users/secwall/.cache/CPM

set_onedark

fish_add_path $HOME/Documents/dev/utils
fish_add_path /opt/homebrew/bin
fish_add_path /usr/local/bin
fish_add_path $GOPATH/.go/bin
fish_add_path $HOME/.rustup/toolchains/nightly-aarch64-apple-darwin/bin
fish_add_path $HOME/.rustup/toolchains/stable-aarch64-apple-darwin/bin

pyenv init - --no-rehash | source

alias vim nvim

function fish_greeting
end

function ssht
    if test (count $argv -lt 2)
        /usr/bin/ssh -o "ControlMaster=auto" -o "ControlPath=~/.ssh/ms/%r@%h:%p" -o "ControlPersist=15m" -o "ServerAliveInterval=5" -o "ServerAliveCountMax=3" "$argv[1]" -t 'tmux attach -t secwall || tmux new -s secwall || /bin/bash'
    else
        /usr/bin/ssh $argv
    end
end

alias ssh ssht

function dotf-install
    for host in $argv
        echo "Installing to $host"
        rsync -rzvp --chmod=og-rwx --copy-links --copy-dirlinks ~/.dotf-dist/ $H:
    end
end

function brew-up
    brew update && brew upgrade && brew upgrade --cask --greedy && brew cleanup -s
end

starship init fish | source
