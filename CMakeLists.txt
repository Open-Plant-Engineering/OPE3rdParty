cmake_minimum_required(VERSION 3.10)
project(OPE3rdParty)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Check if the variable USE_OCCT is set to ON
if(USE_OCCT)
    message(STATUS "Including OpenCASCADE build logic...")
    include(cMake/OCCT.cmake)
endif()