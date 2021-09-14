#!/bin/sh
# [Source] https://stackoverflow.com/questions/18215973/how-to-check-if-running-as-root-in-a-bash-script

is_user_root () { [ "$(id -u)" -eq 0 ]; }

if is_user_root; then
    echo ' _____ ___  _   _ ____  _____ ____   ___  '
    echo '|  ___/ _ \| \ | |  _ \| ____/ ___| / _ \ '
    echo '| |_ | | | |  \| | | | |  _| \___ \| | | |'
    echo '|  _|| |_| | |\  | |_| | |___ ___) | |_| |'
    echo '|_|   \___/|_| \_|____/|_____|____/ \___/ '
    echo
    echo 'Usuario root detectado, inicia instalación...'
    sleep 2
    apt update
    apt install -y aptitude
    aptitude safe-upgrade -y
    apt install -y neofetch figlet nmon htop glances gnome-tweak-tool
    echo 'Reconfigurando GDM'
    sleep 2
    update-alternatives --set gdm3-theme.gresource /usr/share/gnome-shell/gnome-shell-theme.gresource
    echo 'Deshabilitando inicio automático del ambiente gráfico...'
    systemctl set-default multi-user.target
    echo 'Para arrancarente el ambiente gráfico use:'
    echo 'sudo service gdm3 start'
    sleep 2
    echo 'Instalación finalizada
    exit 0
else
    echo 'Este script debe ejecutarse como root.' >&2
    exit 1
fi
