cmake_minimum_required(VERSION 3.16)
project(VulkanTutorial)

# set(CMAKE_C_COMPILER "/usr/bin/clang")
# set(CMAKE_CXX_COMPILER "/usr/bin/clang++")

# Set the C++ standard (optional)
set(CMAKE_CXX_STANDARD 17)
# set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Vulkan REQUIRED)

# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-autolink")

# SET THE SOURCE FILES
file(GLOB_RECURSE SOURCES "src/*.cpp")
# file(GLOB_RECURSE HEADERS "include/*.h" "include/*.hpp")

add_subdirectory(lib/glfw-3.3.8)
set(GLM_TEST_ENABLE OFF CACHE BOOL "GLM Build unit tests")
add_subdirectory(lib/glm)

# Set the include directories
# include_directories(include())
include_directories(${PROJECT_SOURCE_DIR}/lib/stb)
include_directories(${PROJECT_SOURCE_DIR}/lib/tinyobjloader)

# Add any additional libraries or dependencies
# Example: find_package(OpenCV REQUIRED)

# Create the executable
add_executable(${PROJECT_NAME} ${SOURCES})

# Define DEBUG macro in Debug mode
target_compile_definitions(${PROJECT_NAME} PRIVATE $<$<CONFIG:Debug>:DEBUG>)
# Define NDEBUG macro in Release mode
target_compile_definitions(${PROJECT_NAME} PRIVATE $<$<CONFIG:Release>:NDEBUG>)

# Link libraries (if needed)
# Example: target_link_libraries(${PROJECT_NAME} ${OpenCV_LIBS})
target_link_libraries(${PROJECT_NAME} glfw ${GLFW_LIBARIES} Vulkan::Vulkan glm::glm)

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} 
            -DSRC_PATH=${PROJECT_SOURCE_DIR}/assets
            -DDST_PATH=$<TARGET_FILE_DIR:${PROJECT_NAME}>/
            -P ${PROJECT_SOURCE_DIR}/copy_assets.cmake
    COMMENT "Copying assets to target folder..."
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
    # $<TARGET_FILE_DIR:${PROJECT_NAME}>/assets) 

add_custom_command(TARGET ${PROJECT_NAME}
    POST_BUILD
    COMMAND ${CMAKE_COMMAND}
            -DTARGET_NAME=${PROJECT_NAME}
            -DSHADER_PATH=${PROJECT_SOURCE_DIR}/src/shaders
            -P ${PROJECT_SOURCE_DIR}/compile_shaders.cmake
    COMMENT "Comipling shaders..."
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)