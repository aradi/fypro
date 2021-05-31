********************************
FyPro: Fortran project generator
********************************

FyPro generates a template for a Fortran project. It aims to spare your writing
boiler plate code before you can start. Currently it supports the CMake builder
and the FyTest unit testing system and is only capable to create new empty
projects from scratch. (An interface for providing CMake config files for fpm
based project is under development.)


Obtaining FyPro
===============

Currently you have to download the project from
`GitHub <https://github.com/aradi/fypro.git>`_. You can initialize your
environment variables (``PATH`` and ``PYTHONPATH``) by sourceing the
``activate.sh`` script in the root folder of the project:

    source <PROJECT_ROOT_FOLDER>/activate.sh

You will need the Fypp preprocessor being installed, which can be easily
installed via pip::

    pip install fypp


Quick start
===========




License
=======

FyPro is released under the BSD 2-clause license. See the included
`LICENSE <LICENSE>`_ file for the detailed licensing conditions.
