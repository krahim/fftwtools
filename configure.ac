
## This file is part of fftwtools
## Note this file was copied from the file used in the R FFTW package 
## As was the general build principle, and I am indebted to the authors of that
## package.
##
## Process this file with autoconf to produce a configure script.

## Rewritten 22 Feb 2021 by Dirk Eddelbuettel and released under GPL-2 or later

AC_PREREQ(2.61)

## Update this version number along with DESCRIPTION
AC_INIT([fftwtools], [0.9-11])

# Ensure C++ is set up as R expects
: ${R_HOME=`R RHOME`}
if test -z "${R_HOME}"; then
    AC_MSG_ERROR([Could not determine R_HOME.])
fi
CC=`"${R_HOME}/bin/R" CMD config CC`
CFLAGS=`"${R_HOME}/bin/R" CMD config CFLAGS`
AC_REQUIRE_CPP
AC_PROG_CC

## Check for pkg-config
AC_DEFUN([AC_PROG_PKGCONFIG], [AC_CHECK_PROG(PKGCONFIG,pkg-config,yes)])
AC_PROG_PKGCONFIG

## Report failure
if test x"${PKGCONFIG}" != x"yes"; then
   AC_MSG_ERROR([pkg-config not found.])
fi

## Determine values
fftw3_cflags=`pkg-config --cflags fftw3`
fftw3_libs=`pkg-config --libs fftw3`

## Substitute in, respected existing values
AC_SUBST([PKG_CFLAGS],["${fftw3_cflags} ${PKG_CFLAGS}"])
AC_SUBST([PKG_LIBS],["${fftw3_libs} ${PKG_LIBS}"])
AC_CONFIG_FILES([src/Makevars])
AC_OUTPUT

echo "
${PACKAGE_NAME} ${PACKAGE_VERSION}
================

compiler flags: ${PKG_CFLAGS}
link argument:  ${PKG_LIBS}
"
