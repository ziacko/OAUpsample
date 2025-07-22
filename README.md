# One Axis Upsample
an example project to showcase a Single Axis upsampling technique using SMA

requirements:
- Windows: clang compiler
- Linux: clang compiler, cmake, premake-cmake extension

How to build project files:
- call the premake script. e.g. "./premake.exe vs2022" for Windows and "premake cmake" for Linux

How to compile
- Windows: Open the generated solution file which will be generated inside of "./proj/vs"
- Linux: open the project folder in CLion and manually select the Generated CMakeLists.txt file that will be generated inside of "./proj/cmake/"

Why does this project exist?
- I was watching a video by Modern Vintage Gamer a couple years ago ("https://www.youtube.com/watch?v=BaX5YUZ5FLk"), in which he was describing how the original game developers were able to fit such a massive game onto the much smaller Nintendo 64 cartridge. To be concise, they slashed the resolution horizontally for the pre-rendered video files on a single axis(vertically) in addition to other compression techniques. One of the unique downsides to slashing resolution on one axis is that the overall image appears more pixellated(aliased) instead of simply blurred and retaining a lot of its sharpness. 

- So I thought that if I combined this with an Anti-aliasing solution that scaled well enough, i could have a really solid and easy to implement upsampler that could be a decent alternative to DLSS and FSR. for this I used SMAA which is not only great at AA in general but is great for retaining image clarity.

So how does this work?
- dynamically scale down the resolution of your project on a single axis and apply SMAA in the post process stack which will act as a type of "pixel-putty" to fill in the cracks


here is an example of this in practice with 85% of the pixels on the X axis being stripped
[Screencast_20250722_155514.webm](https://github.com/user-attachments/assets/de0c9aae-a582-4d56-8ec6-7b8cc9d0cde7)

NOTE:
- this works best when stripping pixels vertically
- if you are rendering via OpenGL, be sure to flip the search and area textures for SMAA to account for Y-flip issues
- the linux pre-built binary can only be run via command line for the time being
