
find_package(Protobuf CONFIG REQUIRED)
set(protobuf_PROTOC_EXE protobuf::protoc)

add_subdirectory(external)

add_library(
    proto
    STATIC
)

file(GLOB
    PROTO_PROTOS
    "${CMAKE_CURRENT_SOURCE_DIR}/*.proto"
)
file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/proto")
protobuf_generate(
    TARGET proto
    LANGUAGE cpp
    PROTOS ${PROTO_PROTOS}
    PROTOC_OUT_DIR "${CMAKE_CURRENT_BINARY_DIR}/proto"
    IMPORT_DIRS
        "${CMAKE_CURRENT_SOURCE_DIR}"
        "${CMAKE_CURRENT_SOURCE_DIR}/external"
)

target_include_directories(
    proto
    SYSTEM PUBLIC
    "${CMAKE_CURRENT_BINARY_DIR}"
)

target_include_directories(
    proto
    PUBLIC
    "${CMAKE_CURRENT_BINDARY_DIR}"
)

target_link_libraries(
    proto
    proto-external
    protobuf::libprotobuf
)
