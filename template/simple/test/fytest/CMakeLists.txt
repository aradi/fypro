
fytest_fypp_preprocess("" test_trivial.fpp sources-f90)
add_executable(test_trivial $\{sources-f90})
target_link_libraries(test_trivial ${project_name}$ FyTest::FyTest)
add_test(NAME lib/trival COMMAND test_trivial)
