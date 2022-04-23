#!/bin/bash
#Made by DarDarDar, 2022
#Edited by powdered
#TODO list:
#Add a way to install WINE without brew, as i couldnt test it as my mac is from 2011 and cant update to the latest version of macOS
if [ "$1" == "uninstall" ] || [ "$1" == "uninstaller" ]
then
echo "Uninstalling Tadah in 3 seconds.. "
sleep 3
read -p "If you'd like to use a custom wineprefix, please enter y. Otherwise, enter n. " THING
if [ $THING == "y" ]
then
read -p "Please enter the custom wineprefix. " PREFIX
rm $PREFIX/drive_c/users/$USER/AppData/Local/Tadah -rf
rm $PREFIX/drive_c/users/$USER/AppData/Local/Ta2014 -rf
echo "Uninstallation done. Run the script like normal if you'd like to reinstall. "
exit
fi
if [ $THING == "n" ]
then
rm $HOME/.wine/drive_c/users/$USER/AppData/Local/Tadah -rf
rm $HOME/.wine/drive_c/users/$USER/AppData/Local/Tadah -rf
echo "Uninstallation done. Run the script like normal if you'd like to reinstall. "
exit
fi
fi

echo "This is the Tadah Installer helper, v1.6. "
echo "Before installation begins, some dependencies need to be installed. If anything prompts for a password, enter it, and if there's a yes/no answer, enter yes. "
sleep 3


echo "The URI for Tadah will now be made. "
sleep 1

echo "winecfg will now open. Set the OS to be Windows 10. "
sleep 3
WINEPREFIX=$PREFIX winecfg

echo "The script will now install Tadah."
sleep 3
wget -nc https://cdn.discordapp.com/attachments/896484783180382222/962901711763144714/TadahFourteen.exe
WINEPREFIX=$PREFIX wine TadahFourteen.exe

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
echo "If there are any problems, DM the original script owner on Discord: DarDarDar#3429, or add a issue "
rm TadahFourteen.exe
exit

