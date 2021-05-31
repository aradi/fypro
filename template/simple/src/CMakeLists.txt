set(f90-sources
    "${project_name_lower}$.f90"
)

add_library(${project_name}$ "$\{f90-sources}")

set_target_properties(${project_name}$ PROPERTIES OUTPUT_NAME "${project_name_lower}$")
list(APPEND PKG_CONFIG_LIBS "${project_name_lower}$")

set(moddir "$\{CMAKE_CURRENT_BINARY_DIR}/modfiles")
set_target_properties(${project_name}$ PROPERTIES Fortran_MODULE_DIRECTORY "$\{moddir}")
target_include_directories(${project_name}$ PUBLIC
  $<BUILD_INTERFACE:$\{moddir}>
  $<INSTALL_INTERFACE:$\{CMAKE_INSTALL_INCLUDEDIR}/$\{INSTALL_MODULEDIR}>)

install(TARGETS ${project_name}$ DESTINATION "$\{CMAKE_INSTALL_LIBDIR}" EXPORT $\{PROJECT_NAME_LOWER}-targets)
install(DIRECTORY "$\{moddir}/" DESTINATION "$\{CMAKE_INSTALL_INCLUDEDIR}/$\{INSTALL_MODULEDIR}")

set(PKG_CONFIG_LIBS "${PKG_CONFIG_LIBS}" PARENT_SCOPE)