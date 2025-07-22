if os.host() == "linux" then
    local cmake = require "cmake"
    cmake.workspace_directory = _SCRIPT_DIR
    cmake.write_settings = {
        CMAKE_CURRENT_SOURCE_DIR = _SCRIPT_DIR
    }
end

function scene_project(name, parents)
    project(name)
        kind "ConsoleApp"
        language "C++"
        cppdialect "C++20"

        toolset "clang"
        debugdir(_SCRIPT_DIR) -- Changed to use workspace location
        local extradir = "./examples/" .. name .. "/"
        local shaderPath = _SCRIPT_DIR .. "/assets/shaders/" .. name .. "/" .. name .. ".json"

        -- common settings
        files {
            "examples/scene/include/**.h",
            "examples/" .. name .. "/include/**.h",
            "examples/" .. name .. "/source/**.cpp",
            "include/Globals.h",
            "lib/imgui-docking/*.cpp",
            "lib/yyjson/src/yyjson.c",
            "lib/ufbx/ufbx.c",
            shaderPath,
        } 

        includedirs {
            "include/",
            "examples/scene/include/",
            "examples/" .. name .. "/include/",
            "lib/tinywindow/",
            "lib/tinywindow/Include",
            "lib/tinywindow/Dependencies",
            "lib/tinyextender/Include",
            "lib/tinyshaders/Include",
            "lib/tinyclock/Include",
            "lib/gl/",
            "lib/EGL-Registry/api/",
            "lib/glm/",
            "lib/gli/",
            "lib/stb/",
            "lib/imgui-docking/",
            "lib/robin-map/include/",
            "lib/Remotery/",
            "lib/yyjson/src/",
            "lib/ufbx/"
        }

       --if extra_files and #extra_files > 0 then
        defines {
            "SHADER_CONFIG_DIR=\"" .. name .. "\"",
            "ASSET_DIR=\"" .. _SCRIPT_DIR .. "/assets/\"",
            "PROJECT_NAME=\"" .. name .. "\"",
        }

        -- Add extra includes
        if parents then
            for _, file in ipairs(parents) do
                --surround the project name with the include path
                local inheritPath = "examples/" .. file .. "/include/"
                --print("Adding extra include: " .. inheritPath)
                includedirs { inheritPath }
            end
        end

        filter { "system:windows" }
            toolset "clang"
            systemversion "latest"
            links { "opengl32.lib" }

        filter { "system:linux" }
            toolset "clang"
            links { "GL", "X11", "Xrandr", "Xinerama", "pthread" } -- Added pthread for Abseil

            -- Add CMake working directory
            debugdir(_SCRIPT_DIR)

        --communal settings for all projects
        filter { "configurations:Debug" }
            defines { "DEBUG" }
            symbols "on"
            optimize "Off"
            targetdir (_SCRIPT_DIR .. "/bin/Debug")

        filter { "configurations:Release" }
            optimize "on"
            symbols "off"
            targetdir (_SCRIPT_DIR .. "/bin/Release")

        filter { "toolset:clang"}
            configurations { "Debug", "Release" }
            buildoptions { "-Wno-missing-template-arg-list-after-template-kw",
                    "-Wno-deprecated-enum-enum-conversion", "-Wno-macro-redefined"}
end

if os.host() == "linux" then
    location "proj/cmake"
    else if os.host() == "windows" then
    location "proj/vs"
    end
end

workspace "Portfolio"
    configurations { "Debug", "Release" }
    filter "system:linux"
        platforms { "Linux" }
    filter "system:windows"
        platforms { "Windows" }
    architecture "x64"

    filter {"platforms:Win64"}
    system "Windows"
    filter {"platforms:Linux"}
    system "Linux"

    filter "configurations:Debug"
        defines { "ABSL_DEBUG_SYNCHRONIZATION_VIOLATION" }
            
    filter "configurations:Release"
        defines { "ABSL_HARDENED" }
            
    filter {}  -- Reset filter

--base scene project

--2d projects
scene_project("scene")
--3d projects
scene_project("scene3D")
--anti aliasing projects
scene_project("SMAA", {"scene3D", "texturedScene3D"})
scene_project("OAUpsampler", {"scene3D", "texturedScene3D", "SMAA"})