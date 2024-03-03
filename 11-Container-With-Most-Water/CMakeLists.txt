enable_language(C ASM)

add_executable(11-Container-With-Most-Water
    main.c
    solution.s
)

set(CMAKE_LINKER clang)

target_compile_options(11-Container-With-Most-Water PUBLIC -fsanitize=address)
target_link_options(11-Container-With-Most-Water PUBLIC -fsanitize=address)