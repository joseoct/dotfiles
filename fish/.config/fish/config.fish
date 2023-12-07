starship init fish | source
set fish_greeting

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

# WIFI
alias wifi="nmcli device wifi list"

# JAVA
set -x JAVA_HOME '/usr/lib/jvm/java-20-openjdk'
set -x PATH $JAVA_HOME/bin $PATH

# CHROME executable
set -x CHROME_EXECUTABLE '/usr/bin/google-chrome-stable'

# SDK
set -x ANDROID_SDK_ROOT '/opt/android-sdk'
set -x PATH $ANDROID_SDK_ROOT/platform-tools $PATH
set -x PATH $ANDROID_SDK_ROOT/tools/bin $PATH
set -x PATH $ANDROID_ROOT/emulator $PATH
set -x PATH $ANDROID_SDK_ROOT/tools $PATH
set -gx PATH $PATH $HOME/.pub-cache/bin



function sudo --description "Replacement for Bash 'sudo !!' command to run last command using sudo."
  if test "$argv" = !!
    echo sudo $history[1]
    eval command sudo $history[1]
  else
    command sudo $argv
  end
end

set -gx PATH /home/joseoctavio/.local/bin $PATH
