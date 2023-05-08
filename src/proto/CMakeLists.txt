
find_package(Protobuf CONFIG REQUIRED)

add_library(
    proto
    STATIC
)

set(PROTO_OUT_DIR "${CMAKE_CURRENT_BINARY_DIR}/proto")
file(MAKE_DIRECTORY "${PROTO_OUT_DIR}")

file(GLOB_RECURSE
    PROTO_PROTOS
    "${CMAKE_CURRENT_SOURCE_DIR}/*.proto"
)

protobuf_generate(
    TARGET proto
    LANGUAGE cpp
    PROTOS ${PROTO_PROTOS}
    PROTOC_OUT_DIR "${PROTO_OUT_DIR}"
    IMPORT_DIRS
        "${PROTO_OUT_DIR}/external"
        "${PROTO_OUT_DIR}"
        "${CMAKE_CURRENT_SOURCE_DIR}/external"
        "${CMAKE_CURRENT_SOURCE_DIR}"
)

target_include_directories(
    proto
    SYSTEM PUBLIC
    "${CMAKE_CURRENT_BINARY_DIR}"
)

target_include_directories(
    proto
    PUBLIC
    "${CMAKE_CURRENT_BINARY_DIR}/proto"
)

target_link_libraries(
    proto
    protobuf::libprotobuf
)
