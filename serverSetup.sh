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
    # wget https://raw.githubusercontent.com/FONDESO/Soporte/main/banner.txt
    apt update
    apt install -y aptitude
    aptitude safe-upgrade -y
    apt install -y neofetch figlet nmon htop glances mc openssh-server ubuntu-restricted-addons
    apt install -y gparted gnome-tweak-tool chrome-gnome-shell
    echo 'Descargando papel tapiz...'
    wget https://github.com/FONDESO/Soporte/raw/main/cdmx-01.jpg
    mv cdmx-01.jpg /usr/share/backgrounds/
    echo 'Reconfigurando GDM...'
    sleep 2
    update-alternatives --set gdm3-theme.gresource /usr/share/gnome-shell/gnome-shell-theme.gresource
    echo 'Deshabilitando inicio automático del ambiente gráfico...'
    systemctl set-default multi-user.target
    echo 'Para arrancar nuevamente el ambiente gráfico use:'
    echo 'sudo service gdm3 start'
    sleep 2
    reset
    # cat banner.txt
    figlet -t "Host :    $(hostname)"
    figlet -t "IP :    $(ip -4 addr show enp0s25 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')"
    echo '¡Instalación finalizada!'
    # rm banner.txt
    exit 0
else
    echo ' _____ ___  _   _ ____  _____ ____   ___  '
    echo '|  ___/ _ \| \ | |  _ \| ____/ ___| / _ \ '
    echo '| |_ | | | |  \| | | | |  _| \___ \| | | |'
    echo '|  _|| |_| | |\  | |_| | |___ ___) | |_| |'
    echo '|_|   \___/|_| \_|____/|_____|____/ \___/ '
    echo
    echo 'Usuario normal detectado, inicia instalación...'
    sleep 2
    # wget https://raw.githubusercontent.com/FONDESO/Soporte/main/banner.txt
    echo 'Descargando extensiones...'
    wget https://github.com/FONDESO/Soporte/raw/main/extensions.zip
    unzip extensions.zip -d ~/.local/share/gnome-shell/extensions
    echo 'Habilitando extensiones...'
    slep 2
    gnome-shell-extension-tool enable dash-to-dock@micxgx.gmail.com
    gnome-shell-extension-tool enable transparentosd@ipaq3870
    gnome-shell-extension-tool enable TransparentTopbar@enrico.sorio.net
    gnome-shell-extension-tool enable user-theme@gnome-shell-extensions.gcampax.github.com
    rm extensions.zip
    wget https://github.com/FONDESO/Soporte/raw/main/CDMX-avatar.png
    mv CDMX-avatar.png ~/Imágenes/
    reset
    # cat banner.txt
    figlet -t "Host :    $(hostname)"
    figlet -t "IP :    $(ip -4 addr show enp0s25 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')"
    echo '¡Instalación finalizada!'
    # rm banner.txt
    exit 1
fi
