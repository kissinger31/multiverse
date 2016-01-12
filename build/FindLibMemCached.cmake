##-*****************************************************************************
##
## Copyright (C) 2014
##
## All rights reserved.
##
##-*****************************************************************************

# Once done this will define
#  LIBMEMCACHED_FOUND - System has libmemcached library
#  LIBMEMCACHED_INCLUDE_DIR
#  LIBMEMCACHED_INCLUDE_DIRS - The libmemcached include directories
#  LIBMEMCACHED_LIBRARIES - The libraries to link against to use libmemcached
#  LIBMEMCACHED_DEFINITIONS - Compiler switches required for using libmemcached

# We shall worry about windowsification later.

IF (LIBMEMCACHED_LIBRARIES AND LIBMEMCACHED_INCLUDE_DIR)
    SET(LIBMEMCACHED_FIND_QUIETLY TRUE) # Already in cache, be silent
ENDIF (LIBMEMCACHED_LIBRARIES AND LIBMEMCACHED_INCLUDE_DIR)

find_package(PkgConfig)
pkg_check_modules(PC_LIBMEMCACHED QUIET libmemcached)
set(LIBMEMCACHED_DEFINITIONS ${PC_LIBMEMCACHED_CFLAGS_OTHER})
set(LIBMEMCACHED_LINK ${PC_LIBMEMCACHED_LIBS})

find_path(LIBMEMCACHED_INCLUDE_DIR libmemcached/memcached.h
          HINTS ${PC_LIBMEMCACHED_INCLUDEDIR} ${PC_LIBMEMCACHED_INCLUDE_DIRS}
          #PATH_SUFFIXES libgit2
          DOC "The directory where libmemcached/memcached.h resides" )

find_library(LIBMEMCACHED_LIBRARY NAMES libmemcached.so libmemcached.dylib libmemcached.a
             HINTS ${PC_LIBMEMCACHED_LIBDIR} ${PC_LIBMEMCACHED_LIBRARY_DIRS}
             DOC "The libmemcached library" )

# Copy the results to the output variables.
IF (LIBMEMCACHED_INCLUDE_DIR AND LIBMEMCACHED_LIBRARY)
	SET(LIBMEMCACHED_FOUND 1)
	SET(LIBMEMCACHED_LIBRARIES ${LIBMEMCACHED_LIBRARY})
	SET(LIBMEMCACHED_INCLUDE_DIRS ${LIBMEMCACHED_INCLUDE_DIR})
	MESSAGE(STATUS "Found these libmemcached libs: ${LIBMEMCACHED_LIBRARIES}")
ELSE (LIBMEMCACHED_INCLUDE_DIR AND LIBMEMCACHED_LIBRARY)
	SET(LIBMEMCACHED_FOUND 0)
	SET(LIBMEMCACHED_LIBRARIES)
	SET(LIBMEMCACHED_INCLUDE_DIRS)
ENDIF (LIBMEMCACHED_INCLUDE_DIR AND LIBMEMCACHED_LIBRARY)

# Report the results.
IF (NOT LIBMEMCACHED_FOUND)
    SET(LIBMEMCACHED_DIR_MESSAGE "libmemcached was not found. Make sure LIBMEMCACHED_LIBRARY and LIBMEMCACHED_INCLUDE_DIR are set.")
	IF (NOT LIBMEMCACHED_FIND_QUIETLY)
		MESSAGE(STATUS "${LIBMEMCACHED_DIR_MESSAGE}")
	ELSE (NOT LIBMEMCACHED_FIND_QUIETLY)
		IF (LIBMEMCACHED_FIND_REQUIRED)
			MESSAGE(FATAL_ERROR "${LIBMEMCACHED_DIR_MESSAGE}")
		ENDIF (LIBMEMCACHED_FIND_REQUIRED)
	ENDIF (NOT LIBMEMCACHED_FIND_QUIETLY)
ENDIF (NOT LIBMEMCACHED_FOUND)

SET( ALEMBIC_LIBMEMCACHED_INCLUDE_PATH ${LIBMEMCACHED_INCLUDE_DIRS} )
SET( ALEMBIC_LIBMEMCACHED_LIBS ${LIBMEMCACHED_LIBRARIES} )

MARK_AS_ADVANCED(
    LIBMEMCACHED_INCLUDE_DIRS
    LIBMEMCACHED_LIBRARIES
)

IF (LIBMEMCACHED_FOUND)
  MESSAGE( STATUS "LIBMEMCACHED INCLUDE PATH: ${ALEMBIC_LIBMEMCACHED_INCLUDE_PATH}" )
  MESSAGE( STATUS "LIBMEMCACHED LIBRARIES: ${ALEMBIC_LIBMEMCACHED_LIBS}" )
ENDIF()