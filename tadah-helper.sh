#!/bin/bash
#Made by DarDarDar, 2022

if [ "$1" == "uninstall" ] || [ "$1" == "uninstaller" ]
then
echo "Uninstalling Tadah in 3 seconds.. "
sleep 3
rm $HOME/.wine/drive_c/users/$USER/AppData/Local/Tadah -rf
rm $HOME/.wine/drive_c/users/$USER/AppData/Local/Ta2014 -rf
sudo rm /usr/share/applications/tadah.desktop
sudo update-desktop-database
echo "Uninstallation done. Run the script like normal if you'd like to reinstall. "
exit
fi

echo "This is the Tadah Installer helper, v1.5. "
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

PREFIX=$HOME/.wine # defining prefix, if wineprefix is ran as parameter it will be overwritten

if [ "$1" == "prefix" ] || [ "$1" == "wineprefix" ] || [ "$2" == "prefix" ] || [ "$2" == "wineprefix" ]
then
read -p "Please enter the name of the wineprefix you'd like to use/make. " PREFIX
if [ ! -d $PREFIX ]
then
echo "Directory doesn't exist, creating.. "
mkdir $PREFIX
WINEPREFIX=$PREFIX
fi
fi

echo "The URI for Tadah will now be made. "
sleep 1
touch tadah.desktop
echo "[Desktop Entry]" >> tadah.desktop
echo "Name=Tadah Player" >> tadah.desktop
echo "Comment=https://tadah.rocks/" >> tadah.desktop
echo "Type=Application" >> tadah.desktop
echo "Exec=wine $PREFIX/drive_c/users/$USER/AppData/Local/Tadah/2014/TadahLauncher.exe -token %u" >> tadah.desktop
echo "MimeType=x-scheme-handler/tadahfourteen" >> tadah.desktop
sudo mv tadah.desktop /usr/share/applications
sudo update-desktop-database
cat /usr/share/applications/tadah.desktop

echo "winecfg will now open. Set the OS to be Windows 10. "
sleep 3
winecfg $PREFIX

echo "The script will now install Tadah."
sleep 3
wget -nc https://cdn.discordapp.com/attachments/896484783180382222/962901711763144714/TadahFourteen.exe
wine TadahFourteen.exe

if [ "$1" == "dxvk" ] || [ "$2" == "dxvk" ]
then
echo "The script will now install DXVK. "
wget -nc https://github.com/doitsujin/dxvk/releases/download/v1.10.1/dxvk-1.10.1.tar.gz
tar -xf dxvk-1.10.1.tar.gz
cd dxvk-1.10.1
export WINEPREFIX=$PREFIX
./setup_dxvk.sh install
cd ..
rm dxvk-1.10.1.tar.gz
rm dxvk-1.10.1 -rf
fi

echo "The script has installed Tadah. Play a game and it should work! "
echo "If there are any problems, DM me on Discord. DarDarDar#3429. "
rm TadahFourteen.exe
exit

