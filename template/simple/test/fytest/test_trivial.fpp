#\! Demonstrates the usage of simple tests.

#\:include 'fytest.fypp'

#\:block TEST_SUITE('trivial')
  use ${project_name_lower}$, only : get_version
  implicit none

#\:contains

  #\:block TEST('positive_version_nums')
    integer :: major, minor, patch
    call get_version(major, minor, patch)
    @\:ASSERT(major >= 0)
    @\:ASSERT(minor >= 0)
    @\:ASSERT(patch >= 0)
  #\:endblock

#\:endblock TEST_SUITE


@\:TEST_DRIVER()
