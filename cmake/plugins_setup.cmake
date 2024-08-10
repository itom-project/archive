macro(itom_plugin_option PLUGIN_ID)

    set(PLUGINS_LIST    # Legend: X = OFF, D = Default, S = Setup, T = Test
    "+-------------------------------+-----------------------------------+"
    "| **Plugin**                    |  Win  | macOS | Ubu2404 | Rasbian |"
    "+===============================+===================================+"
    "| PLUGIN_PCOSensicam            |   T   |   X   |    X    |    X    |"
    "+-------------------------------+-----------------------------------+"
    "| PLUGIN_QCam                   |   T   |   X   |    X    |    X    |"
    "+-------------------------------+-----------------------------------+"
    "| PLUGIN_USBMotion3XIII         |   T   |   X   |    X    |    X    |"
)

    set(PATTERN "${PLUGIN_ID}.*$")

    # get column index
    if(WIN32)
        set(INDEX 1)
    endif(WIN32)

    if(APPLE)
        set(INDEX 3)
    endif(APPLE)

    if(UNIX)
        set(INDEX 4)
    endif(UNIX)
    # find out raspi

    foreach(PLUGIN_ROW ${PLUGINS_LIST})
        # get row
        string(REGEX MATCH ${PATTERN} MATCHSTRING ${PLUGIN_ROW})
        if(MATCHSTRING)

            string(REPLACE "|" ";" SPLIT_LIST "${MATCHSTRING}")
            list(GET SPLIT_LIST ${INDEX} ELEMENT)
            string(STRIP "${ELEMENT}" VALUE)

            # case DEFAULT
            if(VALUE STREQUAL "D")
                set(BUILD_OPTION ON)
            # case SETUP
            elseif(ITOM_BUILD_SETUP AND (VALUE STREQUAL "D" OR VALUE STREQUAL "S"))
                set(BUILD_OPTION ON)
            # case TEST
            elseif(ITOM_BUILD_TEST AND (VALUE STREQUAL "D" OR VALUE STREQUAL "S" OR VALUE STREQUAL "T"))
                set(BUILD_OPTION ON)
            else()
                set(BUILD_OPTION OFF)
            endif()
        endif(MATCHSTRING)
    endforeach()


    option(${PLUGIN_ID} "Build with this plugin." ${BUILD_OPTION})

endmacro()