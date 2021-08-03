#!/bin/bash
#
# Tests whether the installed library can be used with pkg-config based builds.
#
# Arguments:
#
#   - building directory (will be created if it does not exist)
#
# Requirements:
#
#   - Environment variable FC contains the same Fortran and C compilers as used for the library
#
#   - Environment variable PKG_CONFIG_PATH contains the lib/pkgconfig folder within
#     the installed library tree.
#
SCRIPT_DIR=$(dirname $0)
PROJECT_NAME="${project_name_lower}$"

[ -n "${FC}" ] \
    || { echo "Fortran compiler (enviroment variable FC) unspecified" >&2; exit 1; }

pkg-config --exists ${PROJECT_NAME} \
    || { echo "No PKG-CONFIG found for ${PROJECT_NAME}" >&2; exit 1; }

cflags=$(pkg-config --cflags ${PROJECT_NAME})
libs=$(pkg-config --libs ${PROJECT_NAME})

cmd="${FC} ${cflags} -o test_export ${SCRIPT_DIR}/test_export.f90 ${libs}"

echo "Build command: ${cmd}"
${cmd} \
    || { echo "Build command failed" >&2;  exit 1; }
echo "PKG-CONFIG build succeeded."
