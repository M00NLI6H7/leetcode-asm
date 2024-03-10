enable_language(C ASM)

add_executable(11-Container-With-Most-Water
    main.c
    solution.s
)

set(CMAKE_LINKER clang)