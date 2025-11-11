include(ExternalProject)

set(OCC_INSTALL_DIR ${CMAKE_CURRENT_SOURCE_DIR} CACHE PATH "OpenCASCADE install directory")

ExternalProject_Add(OpenCASCADE
    GIT_REPOSITORY https://git.dev.opencascade.org/repos/occt.git
    GIT_TAG master
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/download/occt
    CMAKE_ARGS
        -D3RDPARTY_DIR=${OCC3RDPARTY_DIR}
        -DINSTALL_DIR=${OCC_INSTALL_DIR}/Install/OCCT
        -DCMAKE_BUILD_TYPE=Debug
    BUILD_ALWAYS 1
    INSTALL_DIR ${OCC_INSTALL_DIR}/Install/OCCT
)