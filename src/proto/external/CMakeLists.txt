
add_library(
    proto-external
    STATIC
)

file(GLOB_RECURSE
    PROTO_EXTERNAL_PROTOS
    "${CMAKE_CURRENT_SOURCE_DIR}/*.proto"
)

protobuf_generate(
    TARGET proto-external
    LANGUAGE cpp
    PROTOS ${PROTO_EXTERNAL_PROTOS}
    IMPORT_DIRS
        "${CMAKE_CURRENT_SOURCE_DIR}"
)

target_include_directories(
    proto-external
    SYSTEM PUBLIC
    "${CMAKE_CURRENT_BINARY_DIR}"
)

target_include_directories(
    proto-external
    PUBLIC
    "${CMAKE_CURRENT_BINARY_DIR}"
)

target_link_libraries(
    proto-external
    protobuf::libprotobuf
)
