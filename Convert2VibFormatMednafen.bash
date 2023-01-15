#!/usr/bin/bash
echo "This shell script was made for Ubuntu. it may or may not run on other operating systems."
shopt -s nullglob
if [[ ! -e "Vib-ribbon Song List.m3u" ]]; then echo "Name of Vib Ribbon file here" > "Vib-ribbon Song List.m3u" && echo "m3u file created. Put the file name of your Vib-Ribbon game in the m3u file. Launch the m3u file when you want to play."; fi
for i in *.{wav,mp3,m4a,ogg,flac,aif,aiff,aac,dts,wma,wma1,wma2,alac}; do 
	echo "$i"
	cvlc "$i" --sout='#transcode{vcodec=none,acodec=vorb,ab=128,channels=2,samplerate=44100,scodec=none}:std{access=file{no-overwrite},mux=ogg,dst=temp.ogg}' vlc://quit
	if [ $? -gt 0 ]; then read -p "VLC had an error." && shopt -u nullglob && exit 1; fi
	echo "FILE \"temp.bin\" BINARY" > temp.cue
	echo "  TRACK 01 AUDIO" >> temp.cue
	echo "    INDEX 01 00:00:00" >> temp.cue
	zip "${i%.*}.zip" temp.cue temp.ogg
	if [ $? -gt 0 ]; then read -p "zip had an error." && shopt -u nullglob && exit 1; fi
	rm "temp.cue" "temp.ogg"
	#rm "$i"
	echo "${i%.*}.zip">>"Vib-ribbon Song List.m3u"
done
shopt -u nullglob
echo ""
echo ""
base64 -d <<<"H4sICEltTGMCAHZpYjIudHh0AKVSwW7CMAy9T9o/WOHAhpTmAwr7he3EKZojTb1NQwKOFt++2CaYVEAb8VSlfrGf7SSGJ/D9+lJvrGZLO0hARidS5DoNCKm7mLxQg1wlqTM10AzRqq3DKGlLhS6xulFPLOZrHHWwashCnKKteKDo3Rk+E/M8d0fjvunjc00ViQ19BogUjAqpWv3aD4cDDH/HYQ/HHfz87g5DN10AEdWQ42dUNcfzahK1WFJY5B7BQCjIKZM9iISxAtGxy6PmAIUTLBTpvB1TuD7HNvrg0NmGSjzSwsD7PPGSI048zTVObnkaXdvWSzEE30ExuGhcbDbO2RjpPyU/f4RYI4fTtD4vgl6cZigsLJQ9U82gVIr16kQxlJAZBRZGNe0vNPBRjSJeKJDWelMnf+93a9Vht6nOu9LiU4pI18fiJ6EHd2hh/W0aZOgKVd/alYbOr+XA+7xEKmxpRoGF3aUZtVf75/UffXGaF8cGAAA=" | gunzip
#from chaos at https://askubuntu.com/questions/690926/how-can-i-print-existing-ascii-art-from-a-bash-script
read -p ""
exit
