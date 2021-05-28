cmake_minimum_required(VERSION 3.16)

project(Simple
    VERSION 1.0.1
    DESCRIPTION "A simple Fortran project demonstrating the usage of the CMake build system"
    HOMEPAGE_URL https://github.com/aradi/fypro
    LANGUAGES Fortran)

string(TOLOWER "${PROJECT_NAME}" PROJECT_NAME_LOWER)
include(GNUInstallDirs)
include(config.cmake)

add_subdirectory(lib)
add_subdirectory(prog)

#enable_testing()
#add_subdirectory(test)


#
# Export package info
#
include(CMakePackageConfigHelpers)

install(EXPORT ${PROJECT_NAME_LOWER}-targets
    FILE ${PROJECT_NAME_LOWER}-targets.cmake
    NAMESPACE ${PROJECT_NAME}::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME_LOWER})

configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/export/${PROJECT_NAME_LOWER}-config.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/cmake/${PROJECT_NAME_LOWER}-config.cmake
    INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME_LOWER})

write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/cmake/${PROJECT_NAME_LOWER}-config-version.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion)

install(
    FILES ${CMAKE_CURRENT_BINARY_DIR}/cmake/${PROJECT_NAME_LOWER}-config.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/cmake/${PROJECT_NAME_LOWER}-config-version.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME_LOWER})

if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules)
    install(
        DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME_LOWER})
endif()

list(TRANSFORM PKG_CONFIG_LIBS PREPEND "-l")
configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/export/${PROJECT_NAME_LOWER}.pc.in
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME_LOWER}.pc @ONLY)
install(
    FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME_LOWER}.pc
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig)