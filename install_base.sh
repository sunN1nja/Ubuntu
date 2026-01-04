#!/bin/bash

# Перед его запуском, лучше всего узнать текущую версию [Visual Studio Code](https://code.visualstudio.com/download#)

# KeepPassXC rep
sudo add-apt-repository ppa:phoerious/keepassxc

# Обновление системы
sudo apt update -y && sudo apt upgrade -y

# Системные утилиты
sudo apt install gcc -y
sudo apt install make -y
sudo apt install perl -y
sudo apt install htop -y
sudo apt install tmux -y
sudo apt install iotop -y
sudo apt install tree -y
sudo apt install lsof -y
sudo apt install bleachbit -y

# KeepPassXC
sudo apt install keepassxc -y

# draw.io
sudo snap install drawio

# Obsidian
sudo snap install obsidian --classic

# VLC
sudo apt install vlc -y

# Gnome
sudo apt install gnome-tweaks -y
sudo apt install gnome-shell-extension-manager -y

# Сетевый утилиты
sudo apt install net-tools -y
sudo apt install curl -y
sudo apt install wget -y
sudo apt install git -y
sudo apt install iproute2 -y
sudo apt install nethogs -y
sudo apt install iftop -y
sudo apt install ufw -y && sudo ufw enable
sudo apt install tcpdump -y
sudo apt install nmap -y
sudo apt install openssh-client -y
sudo apt install filezilla -y
sudo apt install traceroute mtr -y
sudo apt install whois -y
sudo apt install dnsutils -y
sudo apt install openvpn -y
sudo apt install wireshark -y && sudo dpkg-reconfigure wireshark-common
sudo apt install remmina -y

# Программы для работы с файлами
sudo apt install mc -y
sudo apt install doublecmd-gtk -y
sudo apt install micro -y
sudo apt install visidata -y
sudo apt install bzip2 -y
sudo apt install p7zip-full p7zip-rar unzip -y

# Python
sudo apt install python3-pip -y
sudo apt install python3-venv -y

# Для виртуальной машины
sudo apt install xorg xserver-xorg-core xserver-xorg-video-all -y
sudo apt install openssh-server -y

# Office
sudo apt install libreoffice -y

# Email
sudo apt install thunderbird -y

# Messangers
sudo apt install pidgin pidgin-otr -y
sudo apt install telegram-desktop -y

# Установка Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# Установка Visual Studio Code
wget https://vscode.download.prss.microsoft.com/dbazure/download/stable/f220831ea2d946c0dcb0f3eaa480eb435a2c1260/code_1.104.0-1757488003_amd64.deb
sudo apt install ./code_1.104.0-1757488003_amd64.deb
rm code_1.104.0-1757488003_amd64.deb

# Переустановка системы
sudo reboot
