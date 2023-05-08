
# https://cmake.org/cmake/help/v3.22/variable/PROJECT_IS_TOP_LEVEL.html
if (NOT PROJECT_IS_TOP_LEVEL)
  # If we are NOT the top level then we are a dependency.
  #

  #
  # Does the parent project specify a wrong version of C++, or doesn't enforce it?
  if (NOT CMAKE_CXX_STANDARD GREATER_EQUAL 20 or NOT CMAKE_CXX_STANDARD_REQUIRED MATCHES "on")

    message(WARNING
      "CMAKE_CXX_VERSION: ${CMAKE_CXX_VERSION}\n"
      "CMAKE_CXX_VERSION_REQUIRED: ${CMAKE_CXX_VERSION_REQUIRED}\n"
      "This project requires C++20"
    )

  endif()

else()

  # If we are the top level project then we should describe that we are using
  # C++20 by default.
  # Individual projects should:
  # add_target_properties(
  #   <target> PROPERTIES
  #   CXX_VERSION "${${PROJECT_NAME}_CXX_VERSION}"
  #   CXX_VERSION_REQUIRED "${${PROJECT_NAME}_CXX_VERSION_REQUIRED}"
  # )

  # Leave this global so we can spot when we are incorrectly inheriting from a
  # dependency and/or tied to its specific version.
  set(CMAKE_CXX_STANDARD 20)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)

endif()

message(STATUS "CMAKE_CXX_VERSION: ${CMAKE_CXX_VERSION}")
message(STATUS "CMAKE_CXX_VERSION_REQUIRED: ${CMAKE_CXX_VERSION_REQUIRED}")
