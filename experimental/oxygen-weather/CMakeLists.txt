# SPDX-FileCopyrightText: 2026 Nuno Pinheiro <nuno@nuno-icons.com>
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.29)
project(OxygenWeather VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QT_DEFAULT_MAJOR_VERSION 6)
set(QT_MAJOR_VERSION 6)
find_package(ECM REQUIRED NO_MODULE)
list(APPEND CMAKE_MODULE_PATH ${ECM_MODULE_PATH})
include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)
if(NOT CMAKE_LIBRARY_OUTPUT_DIRECTORY)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
endif()
include(ECMQtDeclareLoggingCategory)
find_package(Qt6 6.10 REQUIRED COMPONENTS Core Gui DBus Network Quick Qml Widgets)
include(ECMQmlModule)
find_package(KF6 REQUIRED COMPONENTS I18n UnitConversion KIO)
find_package(Plasma REQUIRED)
find_package(PlasmaWeather REQUIRED)

if(NOT COMMAND plasma_add_applet)
    message(FATAL_ERROR
        "Oxygen Weather requires Plasma's plasma_add_applet CMake API. "
        "This Plasma development package does not provide it.")
endif()
foreach(weather_target Plasma::Weather::Ion Plasma::Weather::Data)
    if(NOT TARGET ${weather_target})
        message(FATAL_ERROR
            "Oxygen Weather requires the ${weather_target} target from "
            "the Plasma Weather development package.")
    endif()
endforeach()

add_definitions(-DTRANSLATION_DOMAIN=\"plasma_applet_org.kde.plasma.weather\")

plasma_add_applet(org.kde.oxygenlabs.weather
    QML_SOURCES
        qml/CompactRepresentation.qml
        qml/DetailsView.qml
        qml/ForecastView.qml
        qml/FullRepresentation.qml
        qml/IconAndTextItem.qml
        qml/main.qml
        qml/NoticesView.qml
        qml/SwitchPanel.qml
        qml/TopPanel.qml
        qml/config/ConfigAppearance.qml
        qml/config/ConfigUnits.qml
        qml/config/ConfigWeatherStation.qml
        qml/config/config.qml
    CPP_SOURCES
        util.cpp
        abstractunitlistmodel.cpp
        locationscontrol.cpp
        forecastcontrol.cpp
        weatherdatamonitor_p.cpp
        ioncontrol_p.cpp
        forecastdata.cpp
        locationsdata.cpp
        types.h
    RESOURCES main.xml
    GENERATE_APPLET_CLASS
    QML_ARGS NO_LINT # Upstream workaround for QTBUG-145572.
)

ecm_qt_declare_logging_category(org.kde.oxygenlabs.weather
    HEADER weathercontroller_debug.h
    IDENTIFIER WEATHER::CONTROLLER
    CATEGORY_NAME org.kde.oxygenlabs.weather.controller
    DEFAULT_SEVERITY Info
    DESCRIPTION "Oxygen Weather controller"
)

target_link_libraries(org.kde.oxygenlabs.weather PRIVATE
    KF6::UnitConversion KF6::I18n KF6::KIOCore
    Qt6::Core Qt6::DBus Qt6::Qml Qt6::Network Qt6::Gui
    Plasma::Weather::Ion Plasma::Weather::Data
)
