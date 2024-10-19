# Convert2VibFormat
A collection of command-line scripts that take all the audio files in the current folder and converts them to a format compatible with PlayStation emulators, so one can easily play custom songs in Vib-Ribbon.

*These scripts require [VLC](https://www.videolan.org/vlc/) to work.* The scripts for DuckStation also require chdman (if you choose to compress the output, which is recommended), which comes with mame (but does not require mame to function). [Windows MAME download](https://www.mamedev.org/release.html), [Other platforms MAME download](https://wiki.mamedev.org/index.php/SDL_Supported_Platforms).

The `.bat` files are for Windows, most of the `.bash` files are for Linux (currently only tested to work on Ubuntu and Termux), and the `.bash` file labelled `Mac` is for macOS.

The scripts are designed to work with a specific emulator, either [DuckStation](https://github.com/stenzek/duckstation) or [Mednafen](https://emulation.gametechwiki.com/index.php/Mednafen).

To download: first click on the script that suits your operating system and choice of emulator, then click "raw", then press ctrl+s or right click "Save Page As..." to download.

## macOS

### Installing chdman
chdman might be difficult to install, but keep in mind that you can always run my script *without* chdman by typing "n" when the script asks.

All methods of running chdman require entering a password (and I assume administrator access as well).

A [portable download of chdman is available here](https://sdlmame.lngn.net/), however, it failed to run on my 2013 macbook air. If you want to try using this portable download with my script, keep in mind you must edit the paths to chdman in my script.

I found installing chdman via the Homebrew package manager to work best, and this is what my script is designed around. The main downside to this method is that it took about 3 hours to install chdman on my 2013 macbook air, but it will likely be much faster on new macbooks.   
- go to [brew.sh](https://brew.sh/)
- Copy the terminal command
- Open the Terminal app
- Paste the command you copied into the terminal and press enter to start the process of installing Homebrew
- After Homebrew has finished installing, type `brew install rom-tools` into the terminal and press enter to install chdman

### Running the Script
- [Install VLC from their website](https://www.videolan.org/vlc/). The script is designed to run VLC from the Applications folder, which is how VLC is installed by default.
- [Download the macOS script](https://github.com/Thysbelon/Convert2VibFormat/blob/main/Convert2VibFormatDuckstation-Mac.bash)
- Place the script and the music files you wish to convert in the same folder.
- open the Terminal app. Type `cd ` with a space, then in Finder, drag and drop the folder that your music files are in to the Terminal window. The Terminal window should now display something like `cd path/to/your/files`, press enter to navigate the Terminal to that folder
- In the Terminal, type `bash Convert2VibFormatDuckstation-Mac.bash` and press enter to run the script.

## Android
Users can run bash scripts on an Android phone using [Termux](https://termux.dev/en/); do not install the Play store version, it is deprecated and no longer works.
- [Follow this guide to allow Termux to access your phone's storage](https://wiki.termux.com/wiki/Termux-setup-storage)
- Run `apt update`. This updates the internal list of installable apps, ensuring you do not run into errors while attempting to install apps.
- Run `apt install vlc`
- ~~[Follow this guide to install chdman](https://www.reddit.com/r/EmulationOnAndroid/comments/riqu81/guidedefinitiveconvert_your_games_with_chdman_on/). This guide comes with a script of its own which can be used to convert `.iso` files to chd, but we will not be using it for our music files; leave the prompt "Where are your games located" blank and press enter to continue.~~
**Note**: due to changes in Termux over the years, this chdman installation script no longer functions. You can still use the batch script to convert music files to the Audio CD bin & cue format; when the script asks if you want to use chdman, type "n".
- Download the DuckStation bash script, if you have not done so already.
  - [Navigate to Convert2VibFormatDuckstation.bash](https://github.com/Thysbelon/Convert2VibFormat/blob/main/Convert2VibFormatDuckstation.bash).
  - Tap the three dots menu above the code.
  - Tap and hold "View raw", then click "Download link"
- Download the audio files you wish to use, if you have not done so already.
- Make sure the script and audio files are in the same folder.
- Use the `cd` command to navigate to the folder your script and audio files are in; this will most likely be the Downloads folder, which can be navigated to with `cd storage/shared/Download`. You can always type just `cd` to navigate back to the home directory; you can type `ls` to list the contents of the current directory, with sub-directories in color; you can use tab ↹ to autocomplete the names of folders and files.
- Run the script with `bash Convert2VibFormatDuckstation.bash`, or if that doesn't work: `bash Convert2VibFormatDuckstation.bash.txt`

## Other links
- [Blog post "How to Play Custom Songs in Vib-Ribbon on an Emulator"](https://thysbelon.github.io/Blog/2022-2-19/How-to-Play-Custom-Songs-in-Vib-Ribbon-on-an-Emulator.html). goes over the steps to manually convert audio files into chd. Will hopefully be useful if you can't run the command-line scripts.
- [YouTube video "Vib-Ribbon: Easy Way to Play Custom Music on an Emulator (2024)"](https://www.youtube.com/watch?v=9hd1VYWoG9w). shows how to run the command-line script step-by-step. The video focuses on Windows, but the steps for Linux and Mac should be similar.
