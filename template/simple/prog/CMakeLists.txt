set(f90-sources
  simpleclient.f90
)

add_executable(simpleclient ${f90-sources})
target_link_libraries(simpleclient Simple)
