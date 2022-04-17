# Wineorc
Some simple Shell scripts to setup ORC revivals semi-automatically on Linux.

These scripts are not supported in any way, shape or form by the official devs of these revivals.

# What this does and doesn't do
This script will download dependencies, register URI and download the chosen revival, but won't install it for you.

# Dependencies
The needed packages are:
- The latest wine (obv, preferably wine-staging)
- wget
- unzip (for Itteblox only)

If you are running any form of Ubuntu (that includes Linux Mint and PopOS), Manjaro (but not arch/artix, that is an issue), Fedora or Gentoo the script will automatically install the dependencies for you.
If you aren't, install them manually via your package manager.

# How to use it

0. If your distro is not listed above then install the dependencies.
1. Download the latest release from the Releases page (or just clone this repo via git)
2. Open a terminal and cd into where the script is downloaded.
3. Run `chmod +x *.sh` (which will make all shell files in that directory executable)
4. Depending on which revival you want to install, run the following commands:
- `sudo ./tadah-helper.sh` for Tadah
- `sudo ./itteblox-helper.sh` for Itteblox

The scripts must be ran as root for the time being, but that's something I'll work on.

5. Once the installer is done, either
- `unzip itteblox.zip && wine ItteBloxURI.exe` to install Itteblox
- `wine TadahFourteen.exe` to install Tadah

These should all be ran as a non-root user.

6. Once installed, play a game and it should work!

# Troubleshooting
If the game crashes/doesn't launch, try to
1. Run the installer again (make sure you're running it as non-root)
2. Make sure the OS is set to `Windows 10` in `winecfg`
3. Make sure all necessary optional wine dependencies are installed https://wiki.winehq.org/Building_Wine#Satisfying_Build_Dependencies

If those don't work, DM me on Discord: DarDarDar#3429.

# Known issues
Itteblox 2013 studio doesn't work
Itteblox 2016 locks the mouse after either the right mouse button or shift lock is activated
Script doesn't automatically install dependencies on Arch/Artix (even though it really should)
Script has to be ran as root (once again, am working on it)

# Credits
calones for helping me, and putting up with me being dumb
itteh and kinery for making great revivals
