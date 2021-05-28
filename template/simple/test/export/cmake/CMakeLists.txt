cmake_minimum_required(VERSION 3.16)

project(TestExport LANGUAGES Fortran)

find_package(Simple REQUIRED)

add_executable(test_export test_export.f90)
target_link_libraries(test_export Simple::Simple)
