set(f90-sources
    "simple.f90"
)

add_library(Simple "${f90-sources}")

set_target_properties(Simple PROPERTIES OUTPUT_NAME "simple")
list(APPEND PKG_CONFIG_LIBS "simple")

set(moddir "${CMAKE_CURRENT_BINARY_DIR}/modfiles")
set_target_properties(Simple PROPERTIES Fortran_MODULE_DIRECTORY "${moddir}")
target_include_directories(Simple PUBLIC
  $<BUILD_INTERFACE:${moddir}>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/${INSTALL_MODULEDIR}>)

install(TARGETS Simple DESTINATION "${CMAKE_INSTALL_LIBDIR}" EXPORT ${PROJECT_NAME_LOWER}-targets)
install(DIRECTORY "${moddir}/" DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/${INSTALL_MODULEDIR}")

set(PKG_CONFIG_LIBS "${PKG_CONFIG_LIBS}" PARENT_SCOPE)