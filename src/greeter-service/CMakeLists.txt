
add_executable(
    greeter-service
    main.cpp
)
target_link_libraries(
    greeter-service
    proto
)
install(
    TARGETS greeter-service
    RUNTIME_DEPENDENCIES
    ARCHIVE LIBRARY RUNTIME
)
