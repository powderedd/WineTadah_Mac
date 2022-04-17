#!/bin/bash
#Made by DarDarDar, 2022

if [ "$EUID" -ne 0 ]
  then echo "Script must be ran as root. "
  exit
fi

echo "This is the Tadah Installer helper, v1.0. "
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
apt install --install-recommends winehq-staging wget
fi
if [ $DISTRO == "ManjaroLinux" ]
then
echo "If this fails, then the multilib repo is disabled in /etc/pacman.conf. The dependencies cannot be installed if this is disabled, so please enable it. "
sleep 3
pacman -S wine-staging wine-mono wget
fi
if [ $DISTRO == "Fedora" ]
then
dnf install wine wget
fi
if [ $DISTRO == "Gentoo" ]
then
emerge --ask virtual/wine-staging net-misc/wget
fi

read -p "Please enter your system username exactly, otherwise this won't work. " ANSWER

echo "The URI for Tadah will now be made. "
touch /usr/share/applications/tadah.desktop
echo "[Desktop Entry]" >> /usr/share/applications/tadah.desktop
echo "Name=Tadah Player" >> /usr/share/applications/tadah.desktop
echo "Comment=https://tadah.rocks/" >> /usr/share/applications/tadah.desktop
echo "Type=Application" >> /usr/share/applications/tadah.desktop
echo "Exec=wine "/home/$ANSWER/.wine/drive_c/users/$ANSWER/AppData/Local/Tadah/2014/TadahLauncher.exe" "-token" %u" >> /usr/share/applications/tadah.desktop
echo "MimeType=x-scheme-handler/tadahfourteen" >> /usr/share/applications/tadah.desktop
update-desktop-database
cat /usr/share/applications/tadah.desktop

echo "The script will now download Tadah."
sleep 3
wget https://cdn.discordapp.com/attachments/896484783180382222/962901711763144714/TadahFourteen.exe

echo "What do to next: "
echo "The script has finished installing URI and has downloaded Tadah setup, but has not executed it. "
echo "To execute it, run wine TadahFourteen.exe as a non-root user. If it says that URI is not installed, ignore it because the script installed it for you. "
echo "For best compatibility, run winecfg and change the OS to be Windows 10. "
echo "If you need support with anything, contact me on Discord. DarDarDar#3429. "
exit

