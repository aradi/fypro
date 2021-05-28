program simpleclient
  use iso_fortran_env, only : stdout => output_unit
  use simple, only : get_version
  implicit none
  
  integer :: major, minor, patch

  call get_version(major, minor, patch)
  write(stdout, "('This is simple client using simple library version ',I0,'.',I0,'.',I0,'!')")&
      & major, minor, patch

end program simpleclient
