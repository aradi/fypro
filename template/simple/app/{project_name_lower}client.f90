program ${project_name_lower}$client
  use iso_fortran_env, only : stdout => output_unit
  use ${project_name_lower}$, only : get_version
  implicit none
  
  integer :: major, minor, patch

  call get_version(major, minor, patch)
  write(stdout, "('This is simple client using simple library version ',I0,'.',I0,'.',I0,'!')")&
      & major, minor, patch

end program ${project_name_lower}$client
