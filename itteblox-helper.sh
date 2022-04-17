#!/bin/bash
#Made by DarDarDar, 2022

if [ "$EUID" -ne 0 ]
  then echo "Script must be ran as root. "
  exit
fi

echo "This is the Itteblox Installer helper, v1.0. "
echo "Before installation begins, some dependencies need to be installed. If anything prompts for a yes/no answer, enter yes. "
sleep 3

DISTRO=`cat /etc/*release | grep DISTRIB_ID | cut -d '=' -f 2` # gets distro name

if [ $DISTRO == "Ubuntu" ] || [ $DISTRO == "LinuxMint" ] || [ $DISTRO == "Pop" ]
then 
dpkg --add-architecture i386 # wine installation prep
wget -nc https://dl.winehq.org/wine-builds/winehq.key
mv winehq.key /usr/share/keyrings/winehq-archive.key
VERSION=`lsb_release --release | cut -f2`
if [ $VERSION == "22.04" ]
			then 
				wget -nc https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources
				mv winehq-jammy.sources /etc/apt/sources.list.d/
fi
if [ $VERSION == "21.10" ]
			then 
 				wget -nc https://dl.winehq.org/wine-builds/ubuntu/dists/impish/winehq-impish.sources
				mv winehq-impish.sources /etc/apt/sources.list.d/
fi
if [ $VERSION == "20.04" ] || [ $VERSION == "20.3" ]
			then 
				wget -nc https://dl.winehq.org/wine-builds/ubuntu/dists/focal/winehq-focal.sources
				mv winehq-focal.sources /etc/apt/sources.list.d/
fi			
if [ $VERSION == "18.04" ] || [ $VERSION == "19.3" ] 
			then 
				wget -nc https://dl.winehq.org/wine-builds/ubuntu/dists/bionic/winehq-bionic.sources
				mv winehq-bionic.sources /etc/apt/sources.list.d/
fi
apt update
apt install --install-recommends winehq-staging wget unzip
fi
if [ $DISTRO == "ManjaroLinux" ] 
then
echo "If this fails, then the multilib repo is disabled in /etc/pacman.conf. The dependencies cannot be installed if this is disabled, so please enable it. "
sleep 3
pacman -S wine-staging wine-mono wget unzip
fi
if [ $DISTRO == "Fedora" ]
then
dnf install wine wget unzip
fi
if [ $DISTRO == "Gentoo" ]
then
emerge --ask virtual/wine-staging net-misc/wget unzip
fi

read -p "Please enter your system username exactly, otherwise this won't work. " ANSWER

echo "The URI for Itteblox will now be made. "
touch /usr/share/applications/itteblox.desktop
echo "[Desktop Entry]" >> /usr/share/applications/itteblox.desktop
echo "Name=Itteblox Player" >> /usr/share/applications/itteblox.desktop
echo "Comment=https://ittblox.ml/" >> /usr/share/applications/itteblox.desktop
echo "Type=Application" >> /usr/share/applications/itteblox.desktop
echo "Exec=wine "/home/$ANSWER/itteblox/ItteBloxLauncher.exe" %u" >> /usr/share/applications/itteblox.desktop
echo "MimeType=x-scheme-handler/itblox" >> /usr/share/applications/itteblox.desktop
update-desktop-database
cat /usr/share/applications/itteblox.desktop

echo "The script will now download Itteblox. "
sleep 3
wget https://cdn.discordapp.com/attachments/876914292488826880/921519263108456448/itteblox.zip

echo "What do to next: "
echo "The script has finished installing URI and has downloaded Itteblox but has not installed it. "
echo "To install it fully, mkdir itteblox (to store the files), unzip itteblox.zip into it, then wine ItteBloxURI.exe to finish the install. Then launch a game from the website and it should work! "
echo "For best compatibility, run winecfg and change the OS to be Windows 10. "
echo "If you need support with anything, contact me on Discord. DarDarDar#3429. "
exit

