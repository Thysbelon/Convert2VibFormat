#!/usr/bin/bash
echo "This shell script was made for Ubuntu. it may or may not run on other operating systems."
echo "Compress large wav output with chdman? y/n"
read chdpref
shopt -s nullglob
for i in *.{wav,mp3,m4a,ogg,flac,aif,aiff,aac,dts,wma,wma1,wma2,alac}; do 
	echo "$i"
	/Applications/VLC.app/Contents/MacOS/VLC -I dummy "$i" --sout='#transcode{vcodec=none,acodec=s16l,ab=128,channels=2,samplerate=44100,scodec=none}:std{access=file{no-overwrite},mux=wav,dst=temp.bin}' vlc://quit
	if [ $? -gt 0 ]; then read -p "VLC had an error." && shopt -u nullglob && exit 1; fi
	[[ "$chdpref" = "y" ]] && binname="temp.bin"
	[[ "$chdpref" != "y" ]] && binname="${i%.*}.bin"
	echo "FILE \"${binname}\" BINARY" > temp.cue
	echo "  TRACK 01 AUDIO" >> temp.cue
	echo "    INDEX 01 00:00:00" >> temp.cue
	[[ "$chdpref" = "y" ]] && chdman createcd -i temp.cue -o "${i%.*}.chd" && if [ $? -gt 0 ]; then read -p "chdman had an error. if chdman is not installed, please install rom-tools via the Homebrew package manager for macOS." && shopt -u nullglob && exit 1; fi
	[[ "$chdpref" != "y" ]] && mv temp.bin "${i%.*}.bin" && mv temp.cue "${i%.*}.cue"
	[[ "$chdpref" = "y" ]] && rm "temp.cue" "temp.bin"
	#rm "$i"
done
shopt -u nullglob
echo ""
echo ""
base64 -d <<<"H4sICEltTGMCAHZpYjIudHh0AKVSwW7CMAy9T9o/WOHAhpTmAwr7he3EKZojTb1NQwKOFt++2CaYVEAb8VSlfrGf7SSGJ/D9+lJvrGZLO0hARidS5DoNCKm7mLxQg1wlqTM10AzRqq3DKGlLhS6xulFPLOZrHHWwashCnKKteKDo3Rk+E/M8d0fjvunjc00ViQ19BogUjAqpWv3aD4cDDH/HYQ/HHfz87g5DN10AEdWQ42dUNcfzahK1WFJY5B7BQCjIKZM9iISxAtGxy6PmAIUTLBTpvB1TuD7HNvrg0NmGSjzSwsD7PPGSI048zTVObnkaXdvWSzEE30ExuGhcbDbO2RjpPyU/f4RYI4fTtD4vgl6cZigsLJQ9U82gVIr16kQxlJAZBRZGNe0vNPBRjSJeKJDWelMnf+93a9Vht6nOu9LiU4pI18fiJ6EHd2hh/W0aZOgKVd/alYbOr+XA+7xEKmxpRoGF3aUZtVf75/UffXGaF8cGAAA=" | gunzip
#from chaos at https://askubuntu.com/questions/690926/how-can-i-print-existing-ascii-art-from-a-bash-script
read -p ""
exit
