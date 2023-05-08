cmake_minimum_required(VERSION 3.22.1)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/modules/")

project("grpc-stacksmash"
    LANGUAGES CXX
    VERSION "${PROJECT_VERSION}"
    HOMEPAGE_URL "https://github.com/keith-bennett-airmap/grpc-stacksmash"
)

# Toolchain related information. This is the host system performing the build.
message(STATUS "CMAKE_HOST_SYSTEM=${CMAKE_SYSTEM_NAME}")
message(STATUS "CMAKE_HOST_SYSTEM_NAME=${CMAKE_HOST_SYSTEM_NAME}")
message(STATUS "CMAKE_HOST_SYSTEM_PROCESSOR=${CMAKE_HOST_SYSTEM_PROCESSOR}")
message(STATUS "CMAKE_HOST_SYSTEM_VERSION=${CMAKE_HOST_SYSTEM_VERSION}")

# Toolchain related information. This is the targeted build.
message(STATUS "CMAKE_SYSTEM=${CMAKE_SYSTEM}")
message(STATUS "CMAKE_SYSTEM_NAME=${CMAKE_SYSTEM_NAME}")
message(STATUS "CMAKE_SYSTEM_PROCESSOR=${CMAKE_SYSTEM_PROCESSOR}")
message(STATUS "CMAKE_SYSTEM_VERSION=${CMAKE_SYSTEM_VERSION}")

string(TIMESTAMP BUILD_TIMESTAMP "%Y-%m-%dT%H:%M:%S.000000Z" UTC)

include(cmake/cpp-configuration.cmake)
include(cmake/sanitizers-configuration.cmake)
include(cmake/openssl-configuration.cmake)
include(cmake/cpack-configuration.cmake)

find_package(Threads)

add_subdirectory(proto)
add_subdirectory(greeter-service)
