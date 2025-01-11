starship init fish | source
set fish_greeting

# Alias git
abbr gs "git status -sb"
abbr gl "git log --oneline --graph --all --decorate"
abbr gc "git commit -m"
abbr ga "git add"
abbr gsu "git stash --include-untracked"
abbr gsp "git stash pop"

alias pac="sudo pacman -S"
alias pacr="sudo pacman -R"
alias pacu="sudo pacman -Syu"
alias :q="exit"

# SELLENTT alias
alias pd="cd ~/sellentt/biaction-functions/functions/PedidosDigitais/ && lvim ."
alias b="cd ~/sellentt/biaction-functions/functions && lvim ."
alias f="cd ~/sellentt/biaction-web && lvim ."
alias wifidev="nmcli device wifi connect 04:20:84:33:BE:34 password sellentt0712"
alias wifisdr="nmcli device wifi connect 08:AA:89:60:CD:FD password apenassdr22"

alias monitor="xrandr --output HDMI-2 --rate 74.97 --primary --mode 1920x1080 --rotate normal --output DP-1 --off --output eDP-1 --rate 60.02 --mode 1920x1080 --rotate normal"
alias monitorcasa="xrandr --output HDMI-2 --rate 120.00 --primary --mode 1920x1080 --rotate normal --output DP-1 --off --output eDP-1 --off"

alias s="sensors"
alias desliga="sudo swapoff -a && sudo shutdown -P now"

# WIFI
alias wifi="nmcli device wifi list"

# JAVA
set -x JAVA_HOME '/usr/lib/jvm/java-20-openjdk'
set -x PATH $JAVA_HOME/bin $PATH

# CHROME executable
set -x CHROME_EXECUTABLE '/usr/bin/google-chrome-stable'

# SDK
set -x ANDROID_SDK_ROOT '/home/joseoctavio/Android/Sdk'
set -x PATH $ANDROID_SDK_ROOT/emulator $PATH
set -x PATH $ANDROID_SDK_ROOT/platform-tools $PATH
set -x PATH $ANDROID_SDK_ROOT/tools/bin $PATH
set -x PATH $ANDROID_SDK_ROOT/tools $PATH
set -gx PATH $PATH $HOME/.pub-cache/bin

# NEOVIM
set -x PATH $PATH /opt/nvim

# FLUTTER
set -x PATH $PATH /home/joseoctavio/development/flutter/bin

function sudo --description "Replacement for Bash 'sudo !!' command to run last command using sudo."
  if test "$argv" = !!
    echo sudo $history[1]
    eval command sudo $history[1]
  else
    command sudo $argv
  end
end

set -gx PATH /home/joseoctavio/.local/bin $PATH
