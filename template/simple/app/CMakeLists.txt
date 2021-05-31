set(f90-sources
  ${project_name_lower}$client.f90)

add_executable(${project_name_lower}$client $\{f90-sources})
target_link_libraries(${project_name_lower}$client ${project_name}$)
