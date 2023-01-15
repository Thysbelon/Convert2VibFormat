@echo off
echo IMPORTANT, before running this batch file, 
echo PLEASE open it in a text editor and make sure that the file paths are correct.
echo Right-click the batch file, then click "edit", this will open it in notepad.
echo Look for the notes that say IMPORTANT, they will tell you which paths you need to edit.
echo If you have not yet edited these paths, please close this window and do so now.
echo.
:: If you want to learn more about batch files, this is a great resource: https://ss64.com/nt/
choice /m "Compress large wav output with chdman"
::IMPORTANT, if chdman is not in the same directory as the batch file, please change the path in quotes below.
if %errorlevel% EQU 1 set CHDMANARGS=createcd -i "temp.cue" -o "%%~ni.chd" & set CHDMANPATH="chdman.exe" & echo Again, please make sure the path to chdman is correct before continuing.
pause
echo on
SETLOCAL ENABLEDELAYEDEXPANSION
FOR %%i IN (*.wav *.mp3 *.m4a *.ogg *.flac *.aif *.aiff *.aac *.dts *.wma *.wma1 *.wma2 *.alac) DO (
	::IMPORTANT, If vlc has an error, try changing the path to vlc in quotes below.
	"C:\Program Files\VideoLAN\VLC\vlc.exe" -I dummy --dummy-quiet "%%~nxi" --sout=#transcode{vcodec=none,acodec=s16l,ab=128,channels=2,samplerate=44100,scodec=none}:std{access=file{no-overwrite},mux=wav,dst="temp.bin"} vlc://quit
	:: If you're curious how I got the command line options, I "sniffed" them out using the method detailed here: https://wiki.videolan.org/Documentation:Streaming_HowTo_New/#Streaming_using_the_command_line_interface
	if errorlevel 1 echo. & echo There was an error. Is the path to vlc correct? & pause>nul & exit
	if not exist "temp.bin" echo. & echo The bin file was not generated successfully, either because this batch file is running from Program Files or because vlc had an error. & pause>nul & exit
	set BINNAME="temp.bin"
	if not defined CHDMANARGS set BINNAME="%%~ni.bin"
	echo.FILE !BINNAME! BINARY> "temp.cue"
	echo.  TRACK 01 AUDIO>> "temp.cue"
	echo.    INDEX 01 00:00:00>> "temp.cue"
	%CHDMANPATH% %CHDMANARGS%
	if errorlevel 1 echo. & echo There was an error. Is the path to chdman correct? Is there anything wrong with the music files? & pause>nul & exit
	if not defined CHDMANARGS rename "temp.cue" "%%~ni.cue" & rename "temp.bin" "%%~ni.bin"
	del "temp.cue" "temp.bin"
	::del "%%~nxi"
	rem If you want this script to delete all audio files after processing them, uncomment the line above.
)
@echo off
echo.
echo.
:::                                                            ^
:::              *                                         . ` |                    *                    
:::                                            /`.        /    |
:::                                           /   `.     /     |                                   *
:::                                            \   |    /    .`
:::                                              \  |  /  . `       *
:::     *                                          \| /  `
:::                                           /|\-""""""""-/|\                                           *
:::                           *              |>O<|        |>O<|\
:::                                         / \|/          \|/  \            Press any key to close.
:::                                ___      """"----           /           
:::         ___       _""--__      \ / \           |______---``
:::         \ /__  __"_----__""--_       """"""#######`-_     \`/
:::          V\-/"_"          """"##-_|###########    .   `-_  \                 *                         ~"'~.
:::            V-"    _ -.     _ -. """\#==""        /|      ``-\                                         |   /
:::     _ -- _      ;    |   ;    |            _ -- / |       _ -- _         _ -- _         _ -- _        |  /
:::   ;     __ ;   ;     |  ;     |          ;     __ |     ;     __ ;     ;   /\   ;     ;   __   ;      | /
:::  (     ;  ; )  ;     |  ;     |         (     ;  ; )   (     ;  ; )   (   /  \   )   (   ;  ;   )   __|/
:::   ;     ""  |   ;    |   ;    |          ;     "" ;     ;     "" ;     ; /    \ ;     ;   "" <"    ;  ;
:::     " -- " \|     " -'     " -'            " -- "         " -- "         "    "         " --  ""    ""
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A
::from dbenham at https://stackoverflow.com/questions/19642622/how-do-i-echo-ascii-art-that-contains-special-characters-in-a-batch-file
pause>nul
