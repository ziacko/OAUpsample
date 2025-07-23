# One Axis Upsampling

This project demonstrates a single-axis upsampling technique using SMAA (Subpixel Morphological Anti-Aliasing).

## Requirements

- **Windows:** clang compiler
- **Linux:** clang compiler, cmake, [premake-cmake extension](https://github.com/Enhex/premake-cmake)

## Building the Project

- **Run the premake script:**
  - **Windows:** `./premake.exe vs2022`
  - **Linux:** `premake cmake`

## Compiling

- **Windows:** Open the generated solution file located in `./proj/vs`.
- **Linux:** Open the project folder in CLion and select the generated `CMakeLists.txt` located in `./proj/cmake/`.

  Select the OAUpsampler project in your IDE of choice (Rider/Visual Studio/CLion), set the working directory to be the same folder as the project root folder and compile the selected project 

## Project Motivation

While watching [this video by Modern Vintage Gamer](https://www.youtube.com/watch?v=BaX5YUZ5FLk), I learned how original game developers of Resident Evil 2 managed to fit impressive visuals onto the limited N64 cartridge. Inspired by this, I combined a dynamic resolution technique with an anti-aliasing solution that scales well—resulting in an easy-to-implement upsampler that could serve as a lightweight alternative to DLSS and FSR.

## How It Works

- Dynamically scale down your project's resolution along a single axis.
- Apply SMAA in the post-processing stack. This acts as a kind of "pixel putty" to fill gaps created by upsampling.

### Example

Here’s an example of 85% of the pixels on the X axis being stripped:
[Screencast demo](https://github.com/user-attachments/assets/de0c9aae-a582-4d56-8ec6-7b8cc9d0cde7)

## Notes

- This technique works best when reducing pixels vertically.
- If rendering with OpenGL, flip the search and area textures for SMAA to account for Y-flip issues.
- The Linux pre-built binary can currently only be run via the command line.

