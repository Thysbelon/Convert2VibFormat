:: If you want to learn more about batch files, this is a great resource: https://ss64.com/nt/
echo on
if not exist "Vib-ribbon Song List.m3u" echo.Name of Vib Ribbon file here>"Vib-ribbon Song List.m3u" & echo.m3u file created. Put the file name of your Vib-Ribbon game in the m3u file. Launch the m3u file when you want to play.
FOR %%i IN (*.wav *.mp3 *.m4a *.ogg *.flac *.aif *.aiff *.aac *.dts *.wma *.wma1 *.wma2 *.alac) DO (
   ::IMPORTANT, If vlc has an error, try changing the path to vlc in quotes below.
   "C:\Program Files\VideoLAN\VLC\vlc.exe" -I dummy --dummy-quiet "%%~nxi" --sout=#transcode{vcodec=none,acodec=vorb,ab=128,channels=2,samplerate=44100,scodec=none}:std{access=file{no-overwrite},mux=ogg,dst='temp.ogg'} vlc://quit
   :: If you're curious how I got the command line options, I "sniffed" them out using the method detailed here: https://wiki.videolan.org/Documentation:Streaming_HowTo_New/#Streaming_using_the_command_line_interface
   if errorlevel 1 echo. & echo There was an error. Please open this bat file in a text editor and make sure the path to VLC is correct. & pause>nul & exit
   if not exist "temp.ogg" echo. & echo The ogg file was not generated successfully, either because this batch file is running from Program Files or because vlc had an error. & pause>nul & exit
   echo.FILE "temp.ogg" WAVE> "temp.cue"
   echo.  TRACK 01 AUDIO>> "temp.cue"
   echo.    INDEX 01 00:00:00>> "temp.cue"
   powershell Compress-Archive -Path temp.ogg, temp.cue -DestinationPath tempname.zip
   if errorlevel 1 echo. & echo There was an error. Is there anything wrong with the music files? & pause>nul & exit
   ren tempname.zip "%%~ni.zip"
   if errorlevel 1 echo. & echo There was an error with the file name. Please tell me what the error was. & pause>nul & exit
   del "temp.cue" "temp.ogg"
   echo.%%~ni.zip>>"Vib-ribbon Song List.m3u"
   if errorlevel 1 echo. & echo There was an error with writing to the Song List. Please tell me what the error was. & pause>nul & exit
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
