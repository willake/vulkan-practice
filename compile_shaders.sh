PROJECT_NAME=VulkanTutorial
PROJECT_SOURCE_DIR=.
echo "Compiling shaders..."
cmake -DTARGET_NAME=$PROJECT_NAME -DSHADER_PATH=$PROJECT_SOURCE_DIR/src/shaders -P $PROJECT_SOURCE_DIR/compile_shaders.cmake