program test_export
  use ${project_name_lower}$, only : get_version
  implicit none

  integer :: major, minor, patch

  call get_version(major, minor, patch)
  print "('Library version ',I0,'.',I0,'.',I0,' succesfully linked')", major, minor, patch
  
end program test_export