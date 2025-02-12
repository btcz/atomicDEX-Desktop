include(${CMAKE_CURRENT_LIST_DIR}/../../project.metadata.cmake)

set(CMAKE_SOURCE_DIR "C:/btcz/btcz/atomicDEX-Desktop/")
set(CMAKE_CURRENT_SOURCE_DIR "C:/btcz/btcz/atomicDEX-Desktop/build")
set(PROJECT_ROOT_DIR ${CMAKE_SOURCE_DIR})

message("Log: CMAKE_SOURCE_DIR - ${CMAKE_SOURCE_DIR}")
message("Log: CMAKE_CURRENT_SOURCE_DIR - ${CMAKE_CURRENT_SOURCE_DIR}")
message("Log: PROJECT_ROOT_DIR - ${PROJECT_ROOT_DIR}")

#get_filename_component(PROJECT_ROOT_DIR ${CMAKE_SOURCE_DIR} DIRECTORY)
if (EXISTS ${PROJECT_ROOT_DIR}/build-Release)
    message(STATUS "from ci tools, readjusting")
    get_filename_component(PROJECT_ROOT_DIR ${PROJECT_ROOT_DIR} DIRECTORY)
endif ()

message(STATUS "PROJECT_ROOT_DIR -> ${PROJECT_ROOT_DIR}")

message("Log: CMAKE_SOURCE_DIR - ${CMAKE_SOURCE_DIR}")
message("Log: CMAKE_CURRENT_SOURCE_DIR - ${CMAKE_CURRENT_SOURCE_DIR}")
message("Log: PROJECT_ROOT_DIR - ${PROJECT_ROOT_DIR}")

set(PROJECT_APP_DIR bin)
set(PROJECT_APP_PATH ${CMAKE_SOURCE_DIR}build/${PROJECT_APP_DIR})
set(TARGET_APP_PATH ${PROJECT_ROOT_DIR}/bundled/windows)


message("Log: PROJECT_APP_DIR - ${PROJECT_APP_DIR}")
message("Log: PROJECT_APP_PATH - ${PROJECT_APP_PATH}")
message("Log: TARGET_APP_PATH - ${TARGET_APP_PATH}")

if (EXISTS ${PROJECT_APP_PATH})
    message(STATUS "PROJECT_APP_PATH path is -> ${PROJECT_APP_PATH}")
    message(STATUS "TARGET_APP_PATH path is -> ${TARGET_APP_PATH}")
else ()
    message(FATAL_ERROR "Didn't find ${PROJECT_APP_PATH}")
endif ()

if (NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/bin.zip)
	execute_process(COMMAND powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::CreateFromDirectory('bin', 'bin.zip'); }"
			WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
			ECHO_OUTPUT_VARIABLE
			ECHO_ERROR_VARIABLE
		)
else()
	message(STATUS "bin.zip already present - skipping")
endif()

if (NOT EXISTS ${TARGET_APP_PATH}/bin.zip)
	message(STATUS "Copying ${CMAKE_SOURCE_DIR}/bin.zip to ${TARGET_APP_PATH}/${DEX_PROJECT_NAME}.zip")
	file(COPY ${CMAKE_SOURCE_DIR}/build/bin.zip DESTINATION ${TARGET_APP_PATH})
else()
	message(STATUS "${TARGET_APP_PATH}/${DEX_PROJECT_NAME}.zip exists - skipping")
endif()

message(STATUS "Creating Installer")
set(IFW_BINDIR C:/Qt/Tools/QtInstallerFramework/4.1/bin)
message(STATUS "IFW_BIN PATH IS ${IFW_BINDIR}")
if (NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/bin/${DEX_PROJECT_NAME}.7z)
	execute_process(COMMAND ${IFW_BINDIR}/archivegen.exe ${DEX_PROJECT_NAME}.7z .
		WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/bin
		ECHO_OUTPUT_VARIABLE
		ECHO_ERROR_VARIABLE
		RESULT_VARIABLE ARCHIVE_RESULT
		OUTPUT_VARIABLE ARCHIVE_OUTPUT
		ERROR_VARIABLE ARCHIVE_ERROR)
else()
	message(STATUS "${DEX_PROJECT_NAME}.7z already exists skipping")
endif()

file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/bin/${DEX_PROJECT_NAME}.7z DESTINATION ${PROJECT_ROOT_DIR}/ci_tools_atomic_dex/installer/windows/packages/com.komodoplatform.atomicdex/data)

execute_process(COMMAND ${IFW_BINDIR}/binarycreator.exe -c ./config/config.xml -p ./packages/ ${DEX_PROJECT_NAME}_installer.exe
	WORKING_DIRECTORY ${PROJECT_ROOT_DIR}/ci_tools_atomic_dex/installer/windows
	ECHO_OUTPUT_VARIABLE
	ECHO_ERROR_VARIABLE)
file(COPY ${PROJECT_ROOT_DIR}/ci_tools_atomic_dex/installer/windows/${DEX_PROJECT_NAME}_installer.exe DESTINATION ${TARGET_APP_PATH})