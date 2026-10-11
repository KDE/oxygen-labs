cmake_minimum_required(VERSION 3.29)
project(OxygenLabs VERSION 0.1 LANGUAGES NONE)

option(INSTALL_PATCHED_ICON_SETTINGS "Build and install experimental Plasma Icons settings" OFF)
option(BUILD_OXYGEN_WEATHER "Build the experimental Oxygen Weather applet" OFF)

if(INSTALL_PATCHED_ICON_SETTINGS)
    include(CTest)
endif()

add_subdirectory(testing/plasma-icon-configuration)

if(BUILD_OXYGEN_WEATHER)
    add_subdirectory(experimental/oxygen-weather)
endif()
