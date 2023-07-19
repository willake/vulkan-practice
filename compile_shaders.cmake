function(add_shader TARGET SHADER_PATH SHADER)
    find_program(GLSLC glslc)

    set(current-shader-path ${SHADER_PATH}/${SHADER})
    set(current-output-path ${SHADER_PATH}/compiled/${SHADER}.spv)

    # call glslc to cimple GLSL to SPIR-V
    get_filename_component(current-output-dir ${current-output-path} DIRECTORY)
    file(MAKE_DIRECTORY ${current-output-dir})
    execute_process(COMMAND ${GLSLC} -o ${current-output-path} ${current-shader-path})
endfunction()

# message(TARGET_NAME=${TARGET_NAME})
message(SHADER_PATH=${SHADER_PATH})
add_shader(${TARGET_NAME} ${SHADER_PATH} "shader.vert")
add_shader(${TARGET_NAME} ${SHADER_PATH} "shader.frag")