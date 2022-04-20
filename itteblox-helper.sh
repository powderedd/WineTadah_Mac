#!/bin/bash
#Made by DarDarDar, 2022

if [ "$1" == "uninstall" ] || [ "$1" == "uninstaller" ]
then
echo "Uninstalling ItteBlox in 3 seconds... "
sleep 3
rm $HOME/itteblox -rf
sudo rm /usr/share/applications/itteblox.desktop
sudo update-desktop-database
echo "Uninstallation done. Run the script like normal if you'd like to reinstall. "
exit
fi

echo "This is the ItteBlox Installer helper, v1.6. "
echo "Before installation begins, some dependencies need to be installed. If anything prompts for a password, enter it, and if there's a yes/no answer, enter yes. "
sleep 3

DISTRO=`cat /etc/*release | grep DISTRIB_ID | cut -d '=' -f 2` # gets distro name

if [ $DISTRO == "Ubuntu" ] || [ $DISTRO == "LinuxMint" ] || [ $DISTRO == "Pop" ]
then 
sudo dpkg --add-architecture i386 # wine installation prep
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo mv winehq.key /usr/share/keyrings/winehq-archive.key
VERSION=`lsb_release --release | cut -f2`
if [ $VERSION == "22.04" ]
			then 
				wget -nc https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources
				sudo mv winehq-jammy.sources /etc/apt/sources.list.d/
fi
if [ $VERSION == "21.10" ]
			then 
 				wget -nc https://dl.winehq.org/wine-builds/ubuntu/dists/impish/winehq-impish.sources
				sudo mv winehq-impish.sources /etc/apt/sources.list.d/
fi
if [ $VERSION == "20.04" ] || [ $VERSION == "20.3" ]
			then 
				wget -nc https://dl.winehq.org/wine-builds/ubuntu/dists/focal/winehq-focal.sources
				sudo mv winehq-focal.sources /etc/apt/sources.list.d/
fi			
if [ $VERSION == "18.04" ] || [ $VERSION == "19.3" ] 
			then 
				wget -nc https://dl.winehq.org/wine-builds/ubuntu/dists/bionic/winehq-bionic.sources
				sudo mv winehq-bionic.sources /etc/apt/sources.list.d/
fi
sudo apt update
sudo apt install --install-recommends winehq-staging wget
fi
if [ $DISTRO == "ManjaroLinux" ]
then
echo "If this fails, then the multilib repo is disabled in /etc/pacman.conf. The dependencies cannot be installed if this is disabled, so please enable it. "
sleep 3
sudo pacman -S wine-staging wine-mono wget
fi
if [ $DISTRO == "Fedora" ]
then
sudo dnf install wine wget
fi
if [ $DISTRO == "Gentoo" ]
then
sudo emerge --ask virtual/wine-staging net-misc/wget
fi

echo "The URI for ItteBlox will now be made. "
sleep 1
touch itteblox.desktop
echo "[Desktop Entry]" >> itteblox.desktop
echo "Name=Itteblox Player" >> itteblox.desktop
echo "Comment=https://ittblox.gay/" >> itteblox.desktop
echo "Type=Application" >> itteblox.desktop
echo "Exec=wine $HOME/itteblox/ItteBloxLauncher.exe %u" >> itteblox.desktop
echo "MimeType=x-scheme-handler/itblox" >> itteblox.desktop
sudo mv itteblox.desktop /usr/share/applications
sudo update-desktop-database
cat /usr/share/applications/itteblox.desktop

if [ "$1" == "dxvk" ] || [ "$2" == "dxvk" ]
then
echo "The script will now install DXVK. "
wget -nc https://github.com/doitsujin/dxvk/releases/download/v1.10.1/dxvk-1.10.1.tar.gz
tar -xf dxvk-1.10.1.tar.gz
cd dxvk-1.10.1
export WINEPREFIX=$HOME/.wine
./setup_dxvk.sh install
cd ..
rm dxvk-1.10.1.tar.gz
rm dxvk-1.10.1 -rf
fi

echo "winecfg will now open. Set the OS to be Windows 10. "
sleep 3
winecfg

echo "The script will now install ItteBlox. After you are done with ItteBloxURI.exe, press CTRL+C to close it. "
sleep 3
wget -nc https://cdn.discordapp.com/attachments/876914292488826880/966405305409884290/ItteBlox.zip
mkdir itteblox
mv itteblox.zip itteblox
cd itteblox
unzip itteblox.zip
rm itteblox.zip
wine ItteBloxURI.exe

echo "The script has installed ItteBlox. Play a game and it should work! "
echo "If there are any problems, DM me on Discord. DarDarDar#3429. "
exit
