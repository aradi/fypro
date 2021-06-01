********************************
FyPro: Fortran project generator
********************************

FyPro generates a fully functional minimal Fortran project including
a library, an application and the test infrastructure. Currently it supports
the `CMake <https://cmake.org/>`_ build framework and the `FyTest
<https://github.com/aradi/fytest>`_ unit test system.


Obtaining FyPro
===============

Currently you have to download the project from
`GitHub <https://github.com/aradi/fypro.git>`_. You can initialize your
environment variables (``PATH`` and ``PYTHONPATH``) by sourceing the
``activate.sh`` script in the root folder of the project::

  source <PROJECT_ROOT_FOLDER>/activate.sh

You will need the Fypp preprocessor being installed, which can be easily
installed via pip::

  pip install fypp


Quick start
===========

Creating your project
---------------------

In order to create a minimal project (e.g. ``MyProject``), simply issue ::

    fypro new MyProject

This will create a new directory ``myproject`` and set up a CMake based project
with following features:

* ``src`` directory containing the library source,

* ``app`` directory containing the source of the executable (which uses the
  library),

* ``test`` directory with a unit tests for the library. The unit test
  framework will be download into the ``external/fytest`` directory. You may
  consider to turn it into a git-submodule, though.

* A fully configured CMake build system (using modern CMake!) to build, install
  and test your project and to export it for CMake and pkg-config based build
  systems.

* Simple tests to check, whether your installed project can be built based
  on the CMake or pkg-config export files it created.

You have now working Fortran project, and can start coding in a project . If you
add new files, do not forget to add them to the ``CMakeLists.txt`` files in
their folders.


Building your project
---------------------

The project build follows the usual CMake-workflow. You need a special directory
where the build files should be written (often a ``_build`` folder within your
source). You must invoke CMake from that folder once::

  mkdir _build
  cd _build
  cmake -DCMAKE_INSTALL_DIR=$PWD/_install ..

We have overwritten the default installation path (which is under ``/usr``) to
a special directory (``_install``within the build folder).


Afterwards (and whenever you have changed a source file), simply issue ::

  make


Testing your project
--------------------

If the program was built successfully, you can run the unit tests with ::

  ctest


Installing your project
-----------------------

If you want to install the program, simply execute ::

  make install


Using your project in other projects
------------------------------------

When your project is installed, the installation will also contain the files
``lib/pkgconfig/myproject.pc`` and ``lib/cmake/myproject-config.cmake`` which
can be used to automatically detect your project and extract the right
settings.

You find examples in the ``test/export/cmake`` and the
``test/export/pkgconfig`` folders for invoking your project in
CMake and pkg-config bases builds, respectively. The examples can be used
as tests to test the exports. Be aware, that both, CMake and pkg-config use
special environment variables to guide their search. If you want to
incorporate your installed project in a CMake build, set ::

  export CMAKE_PREFIX_PATH=<INSTALL_FOLDER>/lib/cmake:$CMAKE_PREFIX_PATH

and if it should be found by pkg-config, issue ::

  export PKG_CONFIG_PATH=<INSTALL_FOLDER>/lib/pkgconfig:$PKG_CONFIG_PATH  


FAQ
===

Why not using fpm instead of CMake?
  For simple cases, you would do probably go along much better with the
  `Fortran Package Manager <https://github.com/fortran-lang/fpm>`_, indeed.
  There are, however, some scenarios, fpm can not handle yet, such as
  using custom preprocessor (FyTest needs the `Fypp
  <https://github.com/aradi/fypp>`_ preprocessor) or mixed language
  programming. Additionally, fpm can not generate CMake export
  files yet, which you would need if you want your project to be used by other
  CMake based projects. (We plan to implement fpm -> CMake conversion in
  FyPro).

Why not using Meson instead of CMake?
  Meson is a very nice build system. Unfortunately, the usage of a custom
  preprocessor is not very well implemented yet. So again, in case
  you need a custom preprocessor, CMake may be a better option. (And don't
  worry, using FyPro's template you can tame CMake easily.)
   

License
=======

FyPro is released under the `BSD 2-clause license <LICENSE>`_.