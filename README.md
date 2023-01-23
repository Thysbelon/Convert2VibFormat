# Convert2VibFormat
A collection of scripts that take all the audio files in the current folder and converts them to a format compatible with PlayStation emulators, so one can easily play custom songs in Vib-Ribbon.

*These scripts require [VLC](https://www.videolan.org/vlc/) to work.* The scripts for DuckStation also require chdman (if you choose to compress the output, which is recommended), which comes with mame (but does not require mame to function). [Windows MAME download](https://www.mamedev.org/release.html), [Other platforms MAME download](https://wiki.mamedev.org/index.php/SDL_Supported_Platforms).

The `.bat` files are for Windows and the `.bash` files are for Mac and Linux (currently only tested to work on Ubuntu and Termux).

The scripts are designed to work with a specific emulator, either [DuckStation](https://github.com/stenzek/duckstation) or [Mednafen](https://emulation.gametechwiki.com/index.php/Mednafen).

To download: first click on the script that suits your operating system and choice of emulator, then click "raw", then press ctrl+s or right click "Save Page As..." to download.

## Android
Users can run bash scripts on an Android phone using [Termux](https://termux.dev/en/); do not install the Play store version, it is deprecated and no longer works.
- [Follow this guide to allow Termux to access your phone's storage](https://wiki.termux.com/wiki/Termux-setup-storage)
- Run `apt update`. This updates the internal list of installable apps, ensuring you do not run into errors while attempting to install apps.
- Run `apt install vlc`
- [Follow this guide to install chdman](https://www.reddit.com/r/EmulationOnAndroid/comments/riqu81/guidedefinitiveconvert_your_games_with_chdman_on/). This guide comes with a script of its own which can be used to convert `.iso` files to chd, but we will not be using it for our music files; leave the prompt "Where are your games located" blank and press enter to continue.
- Download the DuckStation bash script, if you have not done so already.
  - [Navigate to Convert2VibFormatDuckstation.bash](https://github.com/Thysbelon/Convert2VibFormat/blob/main/Convert2VibFormatDuckstation.bash).
  - Tap the three dots menu above the code.
  - Tap and hold "View raw", then click "Download link"
- Download the audio files you wish to use, if you have not done so already.
- Make sure the script and audio files are in the same folder.
- Use the `cd` command to navigate to the folder your script and audio files are in; this will most likely be the Downloads folder, which can be navigated to with `cd storage/downloads` or `cd storage/shared/Download`. You can always type just `cd` to navigate back to the home directory; you can type `ls` to list the contents of the current directory, with sub-directories in color.
- Run the script with `bash Convert2VibFormatDuckstation.bash`, or if that doesn't work: `bash Convert2VibFormatDuckstation.bash.txt`
