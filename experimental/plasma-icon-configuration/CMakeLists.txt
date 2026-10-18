cmake_minimum_required(VERSION 3.29)
project(PlasmaIconConfiguration VERSION 0.1 LANGUAGES NONE)

option(INSTALL_PATCHED_ICON_SETTINGS "Build and install experimental Plasma Icons settings" OFF)
if(NOT INSTALL_PATCHED_ICON_SETTINGS)
    message(STATUS "Patched icon settings are disabled. Enable INSTALL_PATCHED_ICON_SETTINGS to opt in.")
    return()
endif()

enable_language(CXX)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
include(CTest)

find_package(ECM 6.29 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})
include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)
include(ECMQmlModule)
include(ECMQtDeclareLoggingCategory)
find_package(Qt6 6.10 REQUIRED COMPONENTS Widgets Svg Quick DBus)
find_package(KF6 REQUIRED COMPONENTS KCMUtils Config I18n IconThemes Archive KIO NewStuff)
if(BUILD_TESTING)
    find_package(Qt6 6.10 REQUIRED COMPONENTS Test)
endif()

find_package(Git REQUIRED)
include(FetchContent)
FetchContent_Declare(plasma_workspace
    GIT_REPOSITORY https://invent.kde.org/plasma/plasma-workspace.git
    GIT_TAG fd05f4c88ab093aee23ce137bf6f2412437c9bba
    PATCH_COMMAND
        "${CMAKE_COMMAND}"
        "-DGIT_EXECUTABLE=${GIT_EXECUTABLE}"
        "-DPATCH_FILE=${CMAKE_CURRENT_SOURCE_DIR}/plasma-workspace-widgets-v6.7.4.patch"
        -P "${CMAKE_CURRENT_SOURCE_DIR}/ApplyPatch.cmake"
    SOURCE_SUBDIR unused-by-icons-only-build
)
FetchContent_MakeAvailable(plasma_workspace)

# Do not install or build the rest of Workspace or its unchanged utilities.
add_subdirectory("${plasma_workspace_SOURCE_DIR}/kcms/icons" icons EXCLUDE_FROM_ALL)
add_custom_target(icon-settings ALL DEPENDS kcm_icons plasma-icon-theme-config)
if(BUILD_TESTING)
    add_custom_target(icon-settings-tests ALL DEPENDS themeconfigtest)
endif()

set(ICON_CONFIGURATION_PLUGIN_DESTINATION
    "${KDE_INSTALL_QTPLUGINDIR}/plasma/kcms/systemsettings")
configure_file(BackupInstallation.cmake.in BackupInstallation.configured.cmake @ONLY)
file(GENERATE
    OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/BackupInstallation.cmake"
    INPUT "${CMAKE_CURRENT_BINARY_DIR}/BackupInstallation.configured.cmake")
install(SCRIPT "${CMAKE_CURRENT_BINARY_DIR}/BackupInstallation.cmake"
    COMPONENT IconConfiguration)
install(TARGETS kcm_icons
    LIBRARY DESTINATION "${ICON_CONFIGURATION_PLUGIN_DESTINATION}"
    COMPONENT IconConfiguration)
install(TARGETS plasma-icon-theme-config
    RUNTIME DESTINATION "${KDE_INSTALL_LIBEXECDIR}"
    COMPONENT IconConfiguration)
install(SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/FinalizeInstallation.cmake"
    COMPONENT IconConfiguration)

message(WARNING
    "Experimental Plasma 6.7.4 Icons settings enabled. Choose your distribution's "
    "plugin/libexec paths before installing. This replaces the installed Icons KCM; "
    "package updates may overwrite it. Oxygen artwork is not installed by this project.")
