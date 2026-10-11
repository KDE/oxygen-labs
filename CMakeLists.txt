cmake_minimum_required(VERSION 3.29)
project(OxygenLabs VERSION 0.1 LANGUAGES NONE)

option(INSTALL_PATCHED_ICON_SETTINGS "Build and install experimental Plasma Icons settings" OFF)

if(INSTALL_PATCHED_ICON_SETTINGS)
    include(CTest)
endif()

add_subdirectory(testing/plasma-icon-configuration)
