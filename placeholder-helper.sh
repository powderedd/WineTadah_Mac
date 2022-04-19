#!/bin/bash
#Made by DarDarDar, 2022

if [ "$1" == "uninstall" ] || [ "$1" == "uninstaller" ]
then
echo "Uninstalling Placeholder in 3 seconds.. "
sleep 3
wget -nc https://placeholder16.tk/setup/PlaceholderInstaller.exe
read -p "If you'd like to use a custom wineprefix, please enter y. Otherwise, enter n. " THING
if [ $THING == "y" ]
then
read -p "Please enter the custom wineprefix. " PREFIX
echo "When the installer is run, please select the Uninstall option and follow the prompts, otherwise this won't work. "
sleep 3
WINEPREFIX=$PREFIX wine PlaceholderInstaller.exe
rm $HOME/.wine/drive_c/users/$USER/AppData/Roaming/Placeholder -rf
sudo rm /usr/share/applications/placeholder.desktop
sudo update-desktop-database
rm PlaceholderInstaller.exe
echo "Uninstallation done. Run the script like normal if you'd like to reinstall. "
exit
fi
if [ $THING == "n" ]
then
echo "When the installer is run, please select the Uninstall option and follow the prompts, otherwise this won't work. "
sleep 3
wine PlaceholderInstaller.exe
rm $HOME/.wine/drive_c/users/$USER/AppData/Roaming/Placeholder -rf
sudo rm /usr/share/applications/placeholder.desktop
sudo update-desktop-database
rm PlaceholderInstaller.exe
echo "Uninstallation done. Run the script like normal if you'd like to reinstall. "
exit
fi
fi

echo "This is the Placeholder Installer helper, v1.6. "
echo "Before installation begins, some dependencies may need to be installed. If anything prompts for a password, enter it, and if there's a yes/no answer, enter yes. "
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

echo "The URI for Placeholder will now be made. "
sleep 1
touch placeholder.desktop
echo "[Desktop Entry]" >> placeholder.desktop
echo "Name=Placeholder Player" >> placeholder.desktop
echo "Comment=https://placeholder16.tk/" >> placeholder.desktop
echo "Type=Application" >> placeholder.desktop
echo "Exec=wine $PREFIX/drive_c/users/$USER/AppData/Roaming/Placeholder/PlaceholderLauncher.exe %u" >> placeholder.desktop
echo "MimeType=x-scheme-handler/placeholder2016" >> placeholder.desktop
sudo mv placeholder.desktop /usr/share/applications
sudo update-desktop-database
cat /usr/share/applications/placeholder.desktop

echo "winecfg will now open. Set the OS to be Windows 10. "
sleep 3
WINEPREFIX=$PREFIX winecfg

echo "The script will now install Placeholder. Don't change the install location, otherwise URI won't work. " 
sleep 3
wget -nc https://placeholder16.tk/setup/PlaceholderInstaller.exe
WINEPREFIX=$PREFIX wine PlaceholderInstaller.exe

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

echo "The script has installed Placeholder. Play a game and it should work! "
echo "If there are any problems, DM me on Discord. DarDarDar#3429. "
rm PlaceholderInstaller.exe
exit

