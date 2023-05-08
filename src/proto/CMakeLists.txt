
find_package(Protobuf CONFIG REQUIRED)
find_package(gRPC CONFIG REQUIRED)

add_library(
    proto
    STATIC
)

set(PROTO_OUT_DIR "${CMAKE_CURRENT_BINARY_DIR}/proto-out")

# include(external/CMakeLists.txt)

file(GLOB_RECURSE
    PROTO_PROTOS
    "${CMAKE_CURRENT_SOURCE_DIR}/*.proto"
)

#
# asio-grpc's protobuf generate function is super easy to use compared to vanilla grpc
asio_grpc_protobuf_generate(
    GENERATE_GRPC
    TARGET proto
    OUT_VAR PROTO_SRC
    PROTOS ${PROTO_PROTOS}
    OUT_DIR "${PROTO_OUT_DIR}/proto"
    IMPORT_DIRS
        "${CMAKE_CURRENT_SOURCE_DIR}/external"
        "${CMAKE_CURRENT_SOURCE_DIR}"
)

target_include_directories(
    proto
    SYSTEM PUBLIC
    "${PROTO_OUT_DIR}"
)

target_include_directories(
    proto
    PUBLIC
    "${PROTO_OUT_DIR}/proto"
)

target_link_libraries(
    proto
    gRPC::grpc++
)
