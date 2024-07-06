cmake_minimum_required(VERSION 3.12...3.29)

#this is to automatically detect the SDK subfolder of the itom build directory.
if(NOT EXISTS ${ITOM_SDK_DIR})
    find_path(ITOM_SDK_DIR "cmake/itom_sdk.cmake"
    HINTS "$ENV{ITOM_SDK_ROOT}"
          "${CMAKE_CURRENT_BINARY_DIR}/../itom/SDK"
    DOC "Path of SDK subfolder of itom root (build) directory")
endif(NOT EXISTS ${ITOM_SDK_DIR})

if(NOT EXISTS ${ITOM_SDK_DIR})
    message(FATAL_ERROR "ITOM_SDK_DIR is invalid. Provide itom SDK directory path first")
endif(NOT EXISTS ${ITOM_SDK_DIR})

message(
    STATUS "------------------- PROJECT itom_plugins_archive ---------------------")
# Retrieve Version Number and Identifier from GIT-TAG
include(${ITOM_SDK_DIR}/cmake/VersionFromGit.cmake)
version_from_git(
  LOG       ON
  TIMESTAMP "%Y%m%d%H%M%S"
)

# define cmake project and version number
project(itom_plugins_archive VERSION ${GIT_VERSION})
set(itom_plugins_archive_VERSION_IDENTIFIERS ${GIT_IDENTIFIERS})

option(BUILD_TARGET64 "Build for 64 bit target if set to ON or 32 bit if set to OFF." ON)
set(ITOM_SDK_DIR NOTFOUND CACHE PATH "path of SDK subfolder of itom root (build) directory")

message(
    STATUS "------------------- Version = ${itom_plugins_archive_VERSION} -----------------------\n")


set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${PROJECT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR} ${ITOM_SDK_DIR}/cmake)
find_package(ITOM_SDK COMPONENTS dataobject itomCommonLib itomCommonQtLib itomWidgets REQUIRED)
include(ItomBuildMacros)

# ITOM Shipment
option(ITOM_BUILD_SHIPMENT "If ITOM is build for shipment, turn this option ON." OFF)

# PCOSensicam
if(WIN32)
    if(BUILD_QTVERSION STREQUAL "Qt5")
        option(PLUGIN_PCOSensicam "Build with this plugin." ${ITOM_BUILD_SHIPMENT})
        if(PLUGIN_PCOSensicam)
            add_subdirectory(PCOSensicam)
        endif(PLUGIN_PCOSensicam)
    endif(BUILD_QTVERSION STREQUAL "Qt5")
endif()

# USBMotion3XIII
if(WIN32)
    option(PLUGIN_USBMotion3XIII "Build with this plugin." ${ITOM_BUILD_SHIPMENT})
    if(PLUGIN_USBMotion3XIII)
        add_subdirectory(USBMotion3XIII)
    endif(PLUGIN_USBMotion3XIII)
endif()


