# [Convert2VibFormat](https://thysbelon.github.io/Convert2VibFormat/)
This is the work-in-progress webapp version of Convert2VibFormat.  
Currently, the webapp will convert any audio file into a wav cue pair compatible with DuckStation (it's probably compatible with Mednafen as well).  
I would like to add chd support, but I have been unable to do so due to the fact that chdman uses pthreads, and compiling any program that uses pthreads with Emscripten is very difficult.

## Build
compile [chdman](https://github.com/charlesthobe/chdman) with (after making a "build" folder in the chdman folder):
```
emcmake cmake .. -DCMAKE_BUILD_TYPE=Debug
emmake make -j$(nproc)
```
