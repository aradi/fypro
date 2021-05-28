module simple
  implicit none
  
  private
  public :: get_version

  integer, parameter :: major_ = 0
  integer, parameter :: minor_ = 1
  integer, parameter :: patch_ = 0

contains

  subroutine get_version(major, minor, patch)
    integer, intent(out) :: major, minor, patch

    major = major_
    minor = minor_
    patch = patch_

  end subroutine get_version

end module simple
